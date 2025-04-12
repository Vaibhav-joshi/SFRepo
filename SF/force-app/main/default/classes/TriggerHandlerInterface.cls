public interface TriggerHandlerInterface {
  void beforeInsert(List<SObject> newRecords);
  void afterInsert(map<Id, SObject> newMap);
  void beforeUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap);
  void afterUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap);
}