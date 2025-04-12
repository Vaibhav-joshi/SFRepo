trigger AccountTrigger on Account(after insert, after update) {
  TriggerHandler.run(
    'AccountTrigger',
    new AccountTriggerHandler(),
    Trigger.operationType,
    Trigger.old,
    Trigger.new,
    Trigger.oldMap,
    Trigger.newMap
  );
}