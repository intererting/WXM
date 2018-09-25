import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';

class FilePathTest extends StatefulWidget {
  @override
  _FilePathTestState createState() => _FilePathTestState();
}

class _FilePathTestState extends State<FilePathTest> {
  PermissionStatus status;

  @override
  void initState() {
    super.initState();
    _testPath();
  }

  @override
  Widget build(BuildContext context) {
    String msg;
    switch (status) {
      case PermissionStatus.allow:
        msg = 'allow';
        break;
      case PermissionStatus.deny:
        msg = 'deny';
        break;
      case PermissionStatus.noAgain:
        msg = 'noAgain';
        break;
    }
    return Text(msg ?? '');
  }

  _testPath() async {
    PermissionStatus status =
        await Permission.requestSinglePermission(PermissionName.Storage);
    switch (status) {
      case PermissionStatus.allow:
        Directory tempDir = await getExternalStorageDirectory();
        print('${tempDir.path}/flutter_test');
        Directory directory = Directory('${tempDir.path}/flutter_test');
        bool exist = await directory.exists();
        if (!exist) {
          directory.create();
        }
        break;
      case PermissionStatus.deny:
        Permission.openSettings();
        break;
      case PermissionStatus.noAgain:
        break;
    }
    setState(() {
      this.status = status;
    });
  }
}
