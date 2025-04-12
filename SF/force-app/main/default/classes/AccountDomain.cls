public inherited sharing class AccountDomain {
  public static boolean isValueChangedPrimitive(
    Object oldValue,
    Object newValue
  ) {
    return GenericUtils.isValueChangedPrimitive(oldValue, newValue);
  }
}