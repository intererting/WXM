//_testGetDb() async {
//  var databasesPath = await getDatabasesPath();
//  String path = join(databasesPath, "wxm.db");
//  DeviceInfoHelper helper = DeviceInfoHelper();
//  await helper(path);
//  await helper.getDeviceInfo().then((DeviceInfo device) {
//    print('sdkInt ${device.sdkInt}');
//  });
//}

//SharedPreferences prefs = await SharedPreferences.getInstance();
//int counter = (prefs.getInt('counter') ?? 0) + 1;
//print('Pressed $counter times.');
//await prefs.setInt('counter', counter);