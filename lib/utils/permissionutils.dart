import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  /// 所有
  static Future requestAllPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.camera,
      Permission.photos,
      Permission.speech,
      Permission.storage,
      Permission.location,
      Permission.phone,
      Permission.notification,
    ].request();

    if (await Permission.camera.isGranted) {
      if (kDebugMode) {
        print("相机权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("相机权限申请失败");
      }
    }

    if (await Permission.photos.isGranted) {
      if (kDebugMode) {
        print("照片权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("照片权限申请失败");
      }
    }

    if (await Permission.speech.isGranted) {
      if (kDebugMode) {
        print("语音权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("语音权限申请失败");
      }
    }

    if (await Permission.storage.isGranted) {
      if (kDebugMode) {
        print("文件权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("文件权限申请失败");
      }
    }

    if (await Permission.location.isGranted) {
      if (kDebugMode) {
        print("定位权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("定位权限申请失败");
      }
    }

    if (await Permission.phone.isGranted) {
      if (kDebugMode) {
        print("手机权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("手机权限申请失败");
      }
    }

    if (await Permission.notification.isGranted) {
      if (kDebugMode) {
        print("通知权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("通知权限申请失败");
      }
    }
  }

  static Future requestCameraPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.camera,
    ].request();

    if (await Permission.camera.isGranted) {
      if (kDebugMode) {
        print("相机权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("相机权限申请失败");
      }
    }
  }

  static Future requestPhotosPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.photos,
    ].request();

    if (await Permission.photos.isGranted) {
      if (kDebugMode) {
        print("照片权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("照片权限申请失败");
      }
    }

  }

  static Future requestSpeechPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.speech,
    ].request();



    if (await Permission.speech.isGranted) {
      if (kDebugMode) {
        print("语音权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("语音权限申请失败");
      }
    }

  }

  static Future requestStoragePermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.storage,
    ].request();

    if (await Permission.storage.isGranted) {
      if (kDebugMode) {
        print("文件权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("文件权限申请失败");
      }
    }
  }

  static Future requestLocationPermission() async {
    Map<Permission, PermissionStatus> permission = await [

      Permission.location,
    ].request();

    if (await Permission.location.isGranted) {
      if (kDebugMode) {
        print("定位权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("定位权限申请失败");
      }
    }

  }

  static Future requestPhonePermission() async {
    Map<Permission, PermissionStatus> permission = await [

      Permission.phone,
    ].request();

    if (await Permission.phone.isGranted) {
      if (kDebugMode) {
        print("手机权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("手机权限申请失败");
      }
    }

  }

  static Future requestNotificationPermission() async {
    Map<Permission, PermissionStatus> permission = await [

      Permission.notification,
    ].request();

    if (await Permission.notification.isGranted) {
      if (kDebugMode) {
        print("通知权限申请通过");
      }
    } else {
      if (kDebugMode) {
        print("通知权限申请失败");
      }
    }
  }

}