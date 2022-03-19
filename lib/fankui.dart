import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:please/UserId_global.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BackSeed extends StatefulWidget {
  const BackSeed({Key? key}) : super(key: key);

  @override
  _BackSeedState createState() => _BackSeedState();
}
/*
enum Action{
  Ok,
  Cancel,
}
*/
class _BackSeedState extends State<BackSeed> {
  //String _choice = 'Nothing';
  TextEditingController controller = TextEditingController();
  /*
  Future _showdialog() async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('你好'),
            content: Text('是否提交？'),
            actions: <Widget>[
              TextButton(onPressed: () {
                Navigator.of(context).pop(Action.Cancel);
              }, child: Text('取消'),),
              TextButton(onPressed: () {
                print('选择确认1');
                Navigator.of(context).pop(Action.Ok);
                Navigator.of(context).pop();
              }, child: Text('确认'),),
            ],
          );
        }
    );

    switch (action) {
      case Action.Ok:
        setState(() {
          _choice = 'Ok';
        });
        break;
      case Action.Cancel:
        setState(() {
          _choice = 'Cancel';
        });
        break;
      default:
    }
  }
*/
  Future SubmitFankui() async{
    Dio dio = Dio();
    String url = "http://$ST_url/feedbacks";
    Map <String,dynamic> mapp = Map();
    mapp["feedbackPersonId"]=UserId_Global;
    mapp["content"]=controller.text;
    //print(mapp);
    Response res = await dio.post(url,data: mapp);
    Map <String,dynamic> zzt = res.data;
    print(zzt["flag"]);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('反馈',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(children: <Widget>[
          Opacity(opacity: 0.1,child: Container(color: Colors.grey,),),
          SizedBox(
            width: width,
            height: height,
            child: Row(
              children: <Widget>[
                SizedBox(height: height,width: 25,),
                Column(children: <Widget>[
                  SizedBox(height: 25,),
                  Container(height: 30,width: width-50,alignment: Alignment.centerLeft,child: Text('意见与建议：',style: TextStyle(fontSize: 18,),),),
                  SizedBox(height: 25,),
                  Container(width: width-50,height: 250,decoration:BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey),),child: TextField(
                    controller: controller,
                    maxLength: 200,
                    maxLines: 15,
                    decoration: InputDecoration.collapsed(hintText: "请留下您的宝贵意见"),
                  ),),
                  SizedBox(height: 15,),
                  GestureDetector(onTap: (){
                    SubmitFankui();
                    print('提交反馈');
                    Fluttertoast.showToast(msg: '反馈成功！');
                    Navigator.of(context).pop();
                  },
                  child: Container(width: 180,height: 50,
                  decoration: BoxDecoration(color:Color(0xFFA49BB5),borderRadius: BorderRadius.circular(10),),
                  child: Center(child: Text('提 交',style: TextStyle(fontSize: 20,color: Colors.white),)),
                  ),),
                ],),
                SizedBox(height: height,width: 25,),
              ],
            ),
          ),
        ],),
      ),
    );
  }
}
