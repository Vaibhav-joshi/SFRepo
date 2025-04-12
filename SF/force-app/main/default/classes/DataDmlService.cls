public inherited sharing class DataDmlService {
  public static void updateRecords(List<sObject> records) {
    Database.SaveResult[] results = Database.update(records, true);
    for (Database.SaveResult result : results) {
      if (result.isSuccess()) {
        //LOG utility
      } else {
        //LOG utility result.getId()
        System.debug('Failed to update record with Id: ' + result.getId());
        for (Database.Error error : result.getErrors()) {
          //LOG utility
        }
      }
    }
  }
  public static void insertRecords(List<sObject> records) {
    Database.insert(records, true);
  }
}