# Cronjobs

Cronjobs tasks can be defined in the `YourAppCoreSchedulingConfig` class.

We use the `@Scheduled` annotation to define the cronjob expression: `@Scheduled(cron = "...")`.

The syntax for the cron expression respects the following rules: https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/scheduling/support/CronSequenceGenerator.html .
