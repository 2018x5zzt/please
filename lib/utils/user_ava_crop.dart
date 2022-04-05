import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:please/utils/BaseData.dart';
import 'package:please/utils/user_ava_pic.dart';

import '../UserId_global.dart';

class AvatarCropPage extends StatefulWidget {
  @override
  _AvatarCropPageState createState() => _AvatarCropPageState();
}


class _AvatarCropPageState extends State<AvatarCropPage> {
  File? file;
  Dio dio = Dio();
  String url = "http://$ST_url/saveProfiles";
  var sssszzt = false;
  var finishimage = false;

  Future<void> Get_personal_information() async {
    print('开始get');
    Dio dio = Dio();
    String url_1 = "http://$ST_url/users/$UserId_Global";
    Response response = await dio.get(url_1);
    Map<String, dynamic> data = response.data;
    Map<String, dynamic> dd = data["data"];
    if (dd["heading"] != '') {
      User_heading = dd["heading"];
      sssszzt=true;
    }else{
      User_heading = dd["heading"];
      sssszzt=false;
    }
    print('sszzt'+sssszzt.toString());
    BaseData basedata = BaseData.fromJson(dd);
    User_Nickname = basedata.nickname;
    User_qq = basedata.qq;
    User_wechat = basedata.wechat;
    User_major = basedata.major;
    if (basedata.gender == 'M')
      User_Gender = 0;
    else
      User_Gender = 1;

    if (basedata.campus == 'X')
      User_campus = 0;
    else
      User_campus = 1;
    setState(() {

    });
    print('get完成');
  }


  Future<void> imageUpload() async {print('图片裁剪完成');
  print(file!.path.toString());
  FormData formData = FormData.fromMap({
    "file": MultipartFile.fromFileSync(
      file!.path,
      contentType: MediaType('image', 'jpg'),
    ),
    "uid": UserId_Global,
  });
  print(UserId_Global);
  print('上传头像');
  try {
    Response res = await dio.post(url, data: formData);
    print(res);
  } catch (e) {
    print('出错啦qwq');
    print(e);
  }

  }

  Future <bool> _requestPop(){
    print('PoP');
    if(Navigator.canPop(context)){
      Navigator.pop(context);
    }else{
      SystemNavigator.pop();
    }
    return Future.value(false);
  }
  pickAndCropImage(BuildContext context, ImageSource source) async {

    var image = await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (image == null) return; // 取消选择图片的情况
    Navigator.pop(context);
    file = await ImageCropper()
        .cropImage(
      sourcePath: image.path,
      cropStyle: CropStyle.circle,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: '裁剪',
          toolbarColor: Color.fromRGBO(98, 103, 123, 1),
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Color.fromRGBO(177, 175, 227, 1.0),
          dimmedLayerColor: Colors.black26,
          backgroundColor: Color.fromRGBO(58, 59, 69, 1.0),
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),

    );
    print(file!.path.toString());
    print('file完成');
    imageUpload().then((value) {
      Get_personal_information();
    });
    print('get完成');
  }

  showActionButtons(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("拍照"),
                  onTap: () async {
                    pickAndCropImage(context, ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("相册"),
                  onTap: () async {
                    pickAndCropImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget getAvatar() {
    var width = MediaQuery.of(context).size.width - 30;
    if (file != null) {
      return CircleAvatar(
        radius: width / 2,
        backgroundColor: Color.fromRGBO(98, 103, 124, 1),
        backgroundImage: FileImage(file!),
        child: SizedBox(width: width, height: width),
      );
    }
    return UserAvatarImage(size: width);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            const Spacer(),
            Hero(tag: 'avatar', child: getAvatar()),
            const Spacer(),
            const Divider(height: 1.0, color: Colors.white),
            TextButton(
              onPressed: () => showActionButtons(context),
              child: const Text(
                '修改个人头像',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
