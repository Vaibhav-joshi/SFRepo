trigger ContactTrigger on Contact(after insert, after update) {
  TriggerHandler.run(
    'ContactTrigger',
    new ContactTriggerHandler(),
    Trigger.operationType,
    Trigger.old,
    Trigger.new,
    Trigger.oldMap,
    Trigger.newMap
  );
}