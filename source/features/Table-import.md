# Table import

## About

Igloo comes with an optional feature that allows you to import data from table structured documents. Today, it means that you can import data from documents under either CSV or Excel format.

A classical case which can be treated with this feature is the following:

1. Iterate over rows in a sheet.
2. For each row, get data from some columns and check its consistency.
3. Save each row as an element of a table in your database (or in a collection, etc.).
4. At the end of the treatment, commit the transaction if no error occurs or rollback all changes if so.

The main benefit of it is to trace all errors / warnings in a unique run. It avoids a boring couple of "run - error on line 84 - run again - error on line 123 - etc.".

## Include sub-module

To be able to use the classes we will mention later in this documentation, you need to include the Maven sub-module containing them.

```XML
<dependency>
	<groupId>org.iglooproject.components</groupId>
	<artifactId>igloo-component-imports</artifactId>
	<version>${igloo.version}</version>
</dependency>
```

## Interfaces and implementation

The `org.iglooproject.imports.table.common` module is currently divided in 3 parts:
- `common`: all interfaces and abstract class common to all implementation ;
- `apache.poi`: implementation to read Excel format using the [Apache POI API](https://poi.apache.org/) ;
- `opencsv`: implementation to read CSV format using [Opencsv](http://opencsv.sourceforge.net/).

## Using it in your application

Notes about the sample coming:

1. We will use the `apache.poi` implementation. However, it should be really close of it to deal with a CSV file.
2. We will have a main class `CarDataUpgrade` containing all other classes. If you project architecture needs to do something different, you are obviously free to make separate classes.

### Declare you columns

First of all, you need to declare how your data file is structured. Each column defines :
- its position (0 based) ;
- its type.

```java
private static final class CarSheetColumnSet extends ApachePoiImportColumnSet {
	private final Column<Long> id = withIndex(0).asLong().build();
	private final Column<String> brand = withIndex(3).asString().build();
	private final Column<String> referenceName = withIndex(4).asString().build();
	private final Column<Date> firstSellingDate = withIndex(5).asDate().build();
}
```

In the definition above, we can see that columns at positions 1, 2 and 3 are ignored. They may contains informative data, or whatever else, and don't concern the data import. We just ignore them in our structure declaration.

### Iterate over sheets

After that, you will need to use an `IExcelImportFileScanner` to iterate over sheets in the Excel file. Our sample contains only one sheet, but you could have a more complex workbook and you could deal with it making different cases inside the `visitSheet()` method.

```java
@Autowired
private ITransactionScopeIndependantRunnerService transactionScopeIndependantRunnerService;

[...]

private final class CarExcelFileImporter {
	private final ApachePoiImportFileScanner scanner = new ApachePoiImportFileScanner();

	private final CarSheetColumnSet carSheetColumnSet = new CarSheetColumnSet();

	public void doImportExcelFile(InputStream stream, String fileName) throws TableImportException {
		scanner.scan(stream, fileName, SheetSelection.ALL, new IExcelImportFileVisitor<Workbook, Sheet, Row, Cell, CellReference>() {
			@Override
			public void visitSheet(final ITableImportNavigator<Sheet, Row, Cell, CellReference> navigator, Workbook workbook, final Sheet sheet)
					throws TableImportException {
				transactionScopeIndependantRunnerService.run(false, new Callable<Void>() {
					@Override
					public Void call() throws Exception {
						ITableImportEventHandler eventHandler = new LoggerTableImportEventHandler(LOGGER);
						importCarSheet(navigator, sheet, eventHandler);
						eventHandler.checkNoErrorOccurred();
						return null;
					}
				});
			}
		});
	}

	[...]
}
```

**Transaction**

Please note that we use an `ITransactionScopeIndependantRunnerService` to be sure that all database actions are performed in a unique transaction. It allows us to log all potential errors and rollback all changes only at the end of the Excel sheet.

**Event handler**

The `ITableImportEventHandler` allow the import process we build to log some messages about the treated data.
We can initialize it with a `TableImportNonFatalErrorHandling` mode:
- `THROW_ON_CHECK` (default) will throw an exception when the `checkNoErrorOccurred()` is called ;
- `THROW_IMMEDIATELY` will throw an exception when the event is handle ; following rows are not treated.

### Iterates overs rows

Now that we are in a sheet, we can iterate over its rows. We can do it simply like shown below.

```java
private void importCarSheet(ITableImportNavigator<Sheet, Row, Cell, CellReference> navigator,
		Sheet sheet, ITableImportEventHandler eventHandler) throws TableImportContentException, TableImportMappingException {
	CarSheetColumnSet.TableContext sheetContext = carSheetColumnSet.map(sheet, navigator, eventHandler);

	for (CarSheetColumnSet.RowContext rowContext : Iterables.skip(sheetContext, 1)) {
		CarSheetColumnSet.CellContext<Long> idCell = rowContext.cell(carSheetColumnSet.id);
		CarSheetColumnSet.CellContext<String> brandCell = rowContext.cell(carSheetColumnSet.brand);
		CarSheetColumnSet.CellContext<String> referenceNameCell = rowContext.cell(carSheetColumnSet.referenceName);
		CarSheetColumnSet.CellContext<Date> firstSellingDateCell = rowContext.cell(carSheetColumnSet.firstSellingDate);

		Long idFromXls = idCell.getMandatory("Car id is mandatory.");
		String brandFromXls = brandCell.getMandatory("Brand is mandatory");
		String referenceNameFromXls = referenceNameCell.get();
		Date firstSellingDateFromXls = firstSellingDateCell.get();

		Car car = carService.getById();
		if (car != null) {
			// The id cannot be found, the car will not be updated
			idCell.error("Car {} not found.", idFromXls);
			continue;
		}

		if (firstSellingDateFromXls != null && firstSellingDateFromXls.after(new Date())) {
			// The first selling date should be wrong, but it's a secondary information,
			// the car will be updated with this information
			firstSellingDateCell.warn("Car {} - The first selling date ({}) is in the future.", firstSellingDateFromXls);
		}

		car.setBrand(brandFromXls);
		car.setReferenceName(brandFromXls);
		car.setFirstSellingDate(firstSellingDateFromXls);

		try {
			carService.update(car);
		} catch (ServiceException | SecurityServiceException e) {
			LOGGER.error("An error occured while updating a car.", e);
			rowContext.error("An error occured while updating a car.");
		}
	}
}
```

**Getting values**

You can handle some basic behavior while getting values:
- treat result with some functions at column description like `withDefault()`, `extract()` or `capitalize()`
- raise an error in case of missing value with `getMandatory()` instead of a simple `get()`

**Error location**

Please note that using cell or row context to record logs will produce messages with precise location details (i.e.:
```
(at TableImportLocation[fileName=my-pretty-cars.xlsx,tableName=cars,rowIndex (1-based)=123,cellAddress=F123])
```

### Eating the data file

Obviously, we need to give the file to our data import mechanic. Here we get this file from the project's resources, but we also could get it from the file system, from a user input, etc.

```java
public class CarDataUpgrade implements IDataUpgrade {

	private static final Logger LOGGER = LoggerFactory.getLogger(CarDataUpgrade.class);

	private static final String FILE_PATH = "/dataupgrade/my-pretty-cars.xlsx";

	[...]

	public void perform() throws TableImportException {
		InputStream inputStream = null;
		try {
			LOGGER.info("Car import...");
			inputStream = CarDataUpgrade.class.getResourceAsStream(FILE_PATH);
			new CarExcelFileImporter().doImportExcelFile(inputStream, FilenameUtils.getName(FILE_PATH));
			LOGGER.info("Car import completed.");
		} finally {
			IOUtils.closeQuietly(inputStream);
		}
	}
}
```
