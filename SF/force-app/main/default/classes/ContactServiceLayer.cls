public inherited sharing class ContactServiceLayer {
  public static set<Id> getAccountIds(List<Contact> contacts) {
    Set<ID> accountIds = new Set<ID>();
    for (Contact contact : contacts) {
      if (contact.AccountId != null) {
        accountIds.add(contact.AccountId);
      }
    }
    return accountIds;
  }
  public static List<Account> incrementContactCount(
    Map<Id, Contact> newContactMap,
    Map<Id, Account> accountMap
  ) {
    Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
    for (Contact contact : newContactMap.values()) {
      Account account;
      if (accountsToUpdate.containsKey(contact.AccountId)) {
        account = accountsToUpdate.get(contact.AccountId);
      } else {
        account = accountMap.get(contact.AccountId);
      }
      account.Total_Contacts__c = account.Total_Contacts__c != null
        ? account.Total_Contacts__c++
        : 0;
      accountsToUpdate.put(contact.AccountId, account);
    }
    return accountsToUpdate.values();
  }
}