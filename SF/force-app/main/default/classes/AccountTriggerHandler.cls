public with sharing class AccountTriggerHandler implements TriggerHandlerInterface {
  public void beforeInsert(List<SObject> newRecords) {
  }
  public void afterInsert(map<Id, SObject> newMap) {
    Set<String> states = AccountServiceLayer.getAccountStates(
      (List<Account>) newMap.values()
    );
    Map<String, List<Distributor__c>> distributorsByState = DistributorSelector.getDistributorsByState(
      states
    );
    List<Distributor_Option__c> distrubutorOptionsToCreate = AccountServiceLayer.getDistributorOptionToCreate(
      distributorsByState,
      (Map<Id, Account>) newMap
    );
    DataDmlService.insertRecords(distrubutorOptionsToCreate);
  }
  public void beforeUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap) {
  }
  public void afterUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap) {
    List<Distributor_Option__c> distrubutorOptionsToUpdate = AccountServiceLayer.getDistributorOptionToUpdate(
      (Map<Id, Account>) oldMap,
      (Map<Id, Account>) newMap
    );
    DataDmlService.updateRecords(distrubutorOptionsToUpdate);
  }
}