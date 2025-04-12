public inherited sharing class AccountServiceLayer {
  public static Set<String> getAccountStates(List<Account> accounts) {
    Set<String> states = new Set<String>();
    for (Account account : accounts) {
      states.add(account.BillingState);
    }
    return states;
  }

  public static List<Distributor_Option__c> getDistributorOptionToCreate(
    Map<String, List<Distributor__c>> distributorsByState,
    Map<Id, Account> accountMap
  ) {
    List<Distributor_Option__c> distributorOptions = new List<Distributor_Option__c>();
    for (Account a : accountMap.values()) {
      String thisState = a.BillingState;
      if (String.isBlank(thisState)) {
        continue;
      }
      for (Distributor__c d : distributorsByState.get(thisState)) {
        distributorOptions.add(
          new Distributor_Option__c(
            Account__c = a.ID,
            BillingState__c = thisState
          )
        );
      }
    }
    return distributorOptions;
  }

  public static List<Distributor_Option__c> getDistributorOptionToUpdate(
    Map<Id, Account> oldAccountMap,
    Map<Id, Account> newAccountMap
  ) {
    List<Distributor_Option__c> distributorOptions = DistributorOptionSelector.getDistributorOptionByAccountId(
      newAccountMap.keySet()
    );

    for (Distributor_Option__c distributorOption : distributorOptions) {
      Account newAccount = newAccountMap.get(distributorOption.Account__c);
      Account oldAccount = oldAccountMap.get(distributorOption.Account__c);
      if (
        (String.isBlank(newAccount.BillingState)) ||
        (!AccountDomain.isValueChangedPrimitive(
          oldAccount.BillingState,
          newAccount.BillingState
        ))
      ) {
        continue;
      }
      distributorOption.BillingState__c = newAccount.BillingState;
    }

    return distributorOptions;
  }
}