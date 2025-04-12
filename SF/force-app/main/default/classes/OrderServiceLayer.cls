public inherited sharing class OrderServiceLayer {
  public static List<Order> getCompletedOrders(
    map<Id, SObject> oldMap,
    map<Id, SObject> newMap
  ) {
    List<Order> completedOrders = new List<Order>();
    for (Order newOrder : (List<Order>) newMap.values()) {
      Order oldOrder = (Order) oldMap.get(newOrder.Id);
      if (
        OrderDomain.isStatusChangedToCompleted(oldOrder.Status, newOrder.Status)
      ) {
        completedOrders.add(newOrder);
      }
    }
    return completedOrders;
  }
  public static void sendCompletedOrdersToInventoryManagement(
    List<Order> completedOrders
  ) {
    System.enqueueJob(
      new ApexRestFireAndForgetQueueable(JSON.serialize(completedOrders))
    );
  }
}