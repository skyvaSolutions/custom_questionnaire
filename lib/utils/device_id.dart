import 'dart:io';
import 'package:device_info/device_info.dart';

DeviceID deviceID = DeviceID();
class DeviceID{
  String deviceId = "";
  getInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    }
    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
      deviceId = iosInfo.identifierForVendor;
    }

  }
}