public inherited sharing class DistributorOptionSelector {
  public static List<Distributor_Option__c> getDistributorOptionByAccountId(
    Set<Id> accountIds
  ) {
    return [
      SELECT Id, Account__c, BillingState__c
      FROM Distributor_Option__c
      WHERE Account__c IN :accountIds
      WITH SECURITY_ENFORCED
    ];
  }
}