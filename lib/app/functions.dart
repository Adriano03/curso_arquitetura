import 'dart:io';
import 'dart:math';

import 'package:curso_arquitetura/domain/models/model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = 'Unknown';
  String identifier = 'Unknown';
  String version = 'Unknown';

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var random = Random();
      var build = await deviceInfoPlugin.androidInfo;

      // Name recebe a marca e modelo do dispositivo;
      name = '${build.brand} ${build.model}';
      identifier = random.nextInt(1 << 32).toString();
      version = build.version.codename;
    } else if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;

      name = '${build.name} ${build.model}';
      identifier = build.identifierForVendor!;
      version = build.systemVersion!;
    }
  } on PlatformException {
    return DeviceInfo(name: name, identifier: identifier, version: version);
  }
  return DeviceInfo(name: name, identifier: identifier, version: version);
}
