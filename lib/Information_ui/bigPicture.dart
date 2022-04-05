import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
class ShowBigPicture extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final imageUrl;

  const ShowBigPicture({Key? key,this.imageUrl}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ShowBigPicture> createState() => _ShowBigPictureState(imageUrl);
}



class _ShowBigPictureState extends State<ShowBigPicture> {
  String url;
  _ShowBigPictureState(this.url);
  @override
  initState(){
    if (kDebugMode) {
      print('页面');
      print(url);
    }
    super.initState();
  }
  var saveSuccessfully=false;
  void saveImage() async{
    if (kDebugMode) {
      print(url);
    }
    var response = await Dio().get(url,options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    if (kDebugMode) {
      print(result["isSuccess"]);
    }
    saveSuccessfully=result["isSuccess"];
    if(saveSuccessfully==true) {
      Fluttertoast.showToast(msg: '保存成功！').then((value) {
        Navigator.of(context).pop();
      });
    }else{
      Fluttertoast.showToast(msg: '保存失败！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(children: <Widget>[
        Center(
            child: Image.network(url),),
          GestureDetector(
            onTap: (){
              if (kDebugMode) {
                print('123');
              }
              saveSuccessfully=false;
              saveImage();
            },
            child: Align(alignment: const Alignment(0.9,0.9),child: Stack(children: <Widget>[
            Transform.scale(
              scale:1.6, child: const Icon(Icons.radio_button_off_outlined,color: Colors.grey,)),
            const Icon(Icons.download,color: Colors.grey,)
        ],)),
          ),
      ],),
    );
  }
}
