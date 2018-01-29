# Code processors

## About

Projects based on Igloo, and Igloo itself, use automatically generated code to manipulate data metamodels.

At the moment, there are two metamodels in an application:

 * The bindgen metamodel, which allows us to manipulate objects representing bean properties, and use it to access said properties in java code.
 * The QueryDSL metamodel, which allows us to manipulate objects representing entity properties, and use it to build JPA queries.

## Troubleshooting

### Bindgen's bindings code won't compile

In some cases, bindgen will generate code that won't compile. You may ignore code generation for selected attributes by adding `skipAttribute.your.package.YourClass.yourAttribute` to `bindgen.properties`.

There are known issues with bindgen code generation of some classes in Igloo. You may use the following lines to work around these issues. If those are not up-to-date, check out the [basic application's bindgen.properties](https://github.com/igloo-project/igloo-parent/blob/master/basic-application/basic-application-core/bindgen.properties)

```
skipAttribute.org.iglooproject.jpa.business.generic.model.GenericEntityReference.entityClass=true
skipAttribute.org.iglooproject.commons.util.fieldpath.FieldPath.root=true
```

### "Cannot find symbol"

If you spot errors like this in your maven build:

```
[ERROR] diagnostic: /data/home/ANONYMIZED/Documents/ANONYMIZED/livraison/tmp/ANONYMIZED-core/src/main/java/com/ANONYMIZED/core/business/document/dao/FileDaoImpl.java:17: error: cannot find symbol
import com.ANONYMIZED.core.business.document.model.QDocument;
                                             ^
  symbol:   class QDocument
  location: package com.ANONYMIZED.core.business.document.model
```

... then just ignore these errors. You are in one of these two situations:

 * You generated the bindings for the very first time. In that case, the errors are false positives, and if no other error occurred, the bindings should be generated anyhow.
 * Another error occurred during the generation of bindings. In that case, you should check out the very last error, which should be different and is the real cause of your generation failure.
