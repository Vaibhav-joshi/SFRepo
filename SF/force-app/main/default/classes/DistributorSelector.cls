public inherited sharing class DistributorSelector {
  public static Map<String, List<Distributor__c>> getDistributorsByState(
    Set<String> states
  ) {
    Map<String, List<Distributor__c>> distributorsByState = new Map<String, List<Distributor__c>>();
    if (states.isEmpty()) {
      return distributorsByState;
    }
    for (Distributor__c distributor : [
      SELECT id, Billing_Address__StateCode__s
      FROM Distributor__c
      WHERE Billing_Address__StateCode__s IN :states
      WITH SECURITY_ENFORCED
      LIMIT 3
    ]) {
      List<Distributor__c> distributors = new List<Distributor__c>();
      distributors.add(distributor);
      if (
        distributorsByState.containsKey(
          distributor.Billing_Address__StateCode__s
        )
      ) {
        distributors.addAll(
          distributorsByState.get(distributor.Billing_Address__StateCode__s)
        );
      }
      distributorsByState.put(
        distributor.Billing_Address__StateCode__s,
        distributors
      );
    }
    return distributorsByState;
  }
}