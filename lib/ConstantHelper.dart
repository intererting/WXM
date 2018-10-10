class ConstantHelper {
  String serverResourcesUrl = "";

  static ConstantHelper constantHelper;

  ConstantHelper._internal();

  factory ConstantHelper() {
    if (null == constantHelper) {
      constantHelper = ConstantHelper._internal();
    }
    return constantHelper;
  }
}
