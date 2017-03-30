# Task Executor

## About

OWSI-Core comes with a task service allowing to persist and execute background tasks.

## Configuration

The task service can manage multiple queues (typically, a queue for short tasks and a queue for long tasks).
```java
@Configuration
public class YourAppTaskManagementConfig extends AbstractTaskManagementConfig {

	@Override
	@Bean
	public Collection<? extends IQueueId> queueIds() {
		return EnumUtils.getEnumList(YourAppTaskQueueId.class);
	}

}
```

The task manager can be configured with the following properties:
* `task.startMode`: auto or manual: define if the task manager is started automatically at application startup
* `task.queues.config.<queueId>.threads`: number of execution threads for the given queue (by default 1)
* `task.stop.timeout`: timeout of a task: the task is stopped if its execution lasts longer than the timeout

## Queueing a task

A task extends `AbstractTask`. It's going to be serialized as JSON (using Jackson) in order to be persisted.

A task has a name (for identification by a human beand a type.

You can define the queue used by implementing the `selectQueue()` method. It allows you to choose a different queue depending on the parameters passed (e.g. selecting a different queue based on the task type, or based on how many items you have to export).

It's quite easy to submit a new task:
```java
YourTask task = new YourTask(user, parameters...);
queuedTaskHolderService.submit(task);
```

## Inside a task

TODO GSM

## Console

The administration console contains an administration UI for the task manager.
