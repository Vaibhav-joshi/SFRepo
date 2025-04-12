public inherited sharing class OrderDomain {
  public static boolean isStatusChangedToCompleted(
    String oldStatus,
    String newStatus
  ) {
    return isValueChangedPrimitive(oldStatus, newStatus) &&
      newStatus == 'Completed';
  }
  public static boolean isValueChangedPrimitive(
    Object oldValue,
    Object newValue
  ) {
    return oldValue != newValue;
  }
}