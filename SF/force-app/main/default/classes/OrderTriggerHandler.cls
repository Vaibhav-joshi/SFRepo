public with sharing class OrderTriggerHandler implements TriggerHandlerInterface {
  public void beforeInsert(List<SObject> newRecords) {
  }
  public void afterInsert(map<Id, SObject> newMap) {
    //Good tyo have -> do not allow order creation in completed state // validation rule !
  }
  public void beforeUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap) {
  }
  public void afterUpdate(map<Id, SObject> oldMap, map<Id, SObject> newMap) {
    List<Order> completedOrders = OrderServiceLayer.getCompletedOrders(
      oldMap,
      newMap
    );
    system.debug('~~completedOrders -' + completedOrders);
    if (!completedOrders.isEmpty()) {
      OrderServiceLayer.sendCompletedOrdersToInventoryManagement(
        completedOrders
      );
    }
  }
}