public class ApexTestUtil {
  public static void createDistributors(Integer numberOfRecords) {
    List<Distributor__c> distribiutorsToCreate = new List<Distributor__c>();
    for (Integer i = 1; i <= numberOfRecords; i++) {
      distribiutorsToCreate.add(
        new Distributor__c(
          Name = 'Test Distributor ' + i,
          Billing_Address__CountryCode__s = 'AU',
          Billing_Address__StateCode__s = 'VIC'
        )
      );
    }
    if (!distribiutorsToCreate.isEmpty()) {
      DataDmlService.insertRecords(distribiutorsToCreate);
    }
  }
  public static void createAccounts(Integer numberOfRecords) {
    List<Account> accToCreate = new List<Account>();
    for (Integer i = 1; i <= numberOfRecords; i++) {
      Account a = new Account(
        Name = 'Test Acc ' + String.valueOf(i),
        BillingCountry = 'AU',
        BillingState = 'VIC'
      );
      accToCreate.add(a);
    }
    if (!accToCreate.isEmpty()) {
      DataDmlService.insertRecords(accToCreate);
    }
  }
}