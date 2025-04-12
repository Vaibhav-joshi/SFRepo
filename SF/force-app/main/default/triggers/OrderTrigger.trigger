trigger OrderTrigger on Order(
  before insert,
  after insert,
  before update,
  after update
) {
  TriggerHandler.run(
    'OrderTrigger',
    new OrderTriggerHandler(),
    Trigger.operationType,
    Trigger.old,
    Trigger.new,
    Trigger.oldMap,
    Trigger.newMap
  );
}