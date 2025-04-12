public inherited sharing class TriggerHandler {
  public static Integer executionCount = 0;
  public static boolean isExecuting = false;
  public static boolean onDemandBypass = false;
  public static void run(
    String triggerName,
    TriggerHandlerInterface handlerInstance,
    TriggerOperation op,
    List<SObject> oldRecords,
    List<SObject> newRecords,
    map<Id, SObject> oldMap,
    map<Id, SObject> newMap
  ) {
    if (isBypass(triggerName) || onDemandBypass /*|| isRecussion()*/) {
      return;
    }

    switch on op {
      when BEFORE_INSERT {
        handlerInstance.beforeInsert(newRecords);
      }
      when AFTER_INSERT {
        handlerInstance.afterInsert(newMap);
      }
      when BEFORE_UPDATE {
        handlerInstance.beforeUpdate(oldMap, newMap);
      }
      when AFTER_UPDATE {
        handlerInstance.afterUpdate(oldMap, newMap);
      }
      when else {
        return;
      }
    }
  }
  private static boolean isBypass(String triggerName) {
    TriggerBypass__c bypassUtil = TriggerBypass__c.getInstance();
    String fieldName = getBypassFieldName(triggerName);
    if (doesFieldExist(fieldName)) {
      Object fieldValue = bypassUtil.get(fieldName);
      return fieldValue != null && (Boolean) fieldValue;
    } else {
      return false;
    }
  }

  private static String getBypassFieldName(String triggerName) {
    return triggerName + '__c';
    //TODO __c , __c, __x, __b make dynamic on object type
  }

  private static boolean isRecussion() {
    executionCount = !isExecuting ? executionCount++ : executionCount;
    isExecuting = executionCount == 1;

    return executionCount > 1;
    //TODO define max execution count in config
  }

  private static boolean doesFieldExist(String fieldName) {
    Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.TriggerBypass__c.fields.getMap();
    return fieldMap.containsKey(fieldName);
  }
}