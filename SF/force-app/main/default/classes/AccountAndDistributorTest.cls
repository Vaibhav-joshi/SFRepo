@isTest
public class AccountAndDistributorTest {
  @TestSetup
  static void makeData() {
    ApexTestUtil.createDistributors(5);
    ApexTestUtil.createAccounts(5);
  }
  @isTest
  static void checkDistributorOptionCrations() {
    Integer totalDistributor = getDistributorOptions().size();
    Assert.areEqual(totalDistributor, 15);
  }

  private static List<Distributor_Option__c> getDistributorOptions() {
    return [SELECT Id FROM Distributor_Option__c];
  }
}