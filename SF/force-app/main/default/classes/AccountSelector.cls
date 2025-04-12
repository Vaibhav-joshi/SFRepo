public inherited sharing class AccountSelector {
  public static Map<Id, Account> getAccountsMapForIds(Set<Id> accountIds) {
    try {
      return new Map<Id, Account>(
        [
          SELECT Id, Total_Contacts__c
          FROM Account
          WHERE Id IN :accountIds
          //WITH SECURITY_ENFORCED
        ]
      );
    } catch (Exception e) {
      throw e;
      //recommended custom exception
    }
  }
}