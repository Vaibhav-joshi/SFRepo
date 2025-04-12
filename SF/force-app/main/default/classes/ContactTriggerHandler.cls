public with sharing class ContactTriggerHandler implements TriggerHandlerInterface {
  public void beforeInsert(List<SObject> newRecords) {
  }
  public void afterInsert(map<Id, SObject> newMap) {
    Set<Id> accountIds = ContactServiceLayer.getAccountIds(
      (List<Contact>) newMap.values()
    );

    Map<Id, Account> accountsMap = AccountSelector.getAccountsMapForIds(
      accountIds
    );

    List<Account> accountsToUpdate = ContactServiceLayer.incrementContactCount(
      (Map<Id, contact>) newMap,
      accountsMap
    );
    TriggerHandler.onDemandBypass = true;
    DataDmlService.updateRecords(accountsToUpdate);
    TriggerHandler.onDemandBypass = false;
  }
  public void beforeUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap) {
  }
  public void afterUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap) {
  }
}