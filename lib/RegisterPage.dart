import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'UserId_global.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ignore: prefer_typing_uninitialized_variables
  var controller_1;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var controller_qq;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var controller_wechat;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var controller_major;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var controller_userid;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var controller_userpwd;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var controller_userpwd_again;
  var sex=0;
  var xiaoqu=0;
  var zhucechenggong=false;
  final FocusNode _focusNode = FocusNode();
  var build_only = false;
  @override
  void initState(){
    super.initState();
    controller_1=TextEditingController();
    controller_1.addListener((){});
    controller_qq=TextEditingController();
    controller_qq.addListener((){});
    controller_wechat=TextEditingController();
    controller_wechat.addListener((){});
    controller_major=TextEditingController();
    controller_major.addListener((){});
    controller_userid=TextEditingController();
    controller_userid.addListener((){});
    controller_userpwd=TextEditingController();
    controller_userpwd.addListener((){});
    controller_userpwd_again=TextEditingController();
    controller_userpwd_again.addListener((){});
  }
  Future <void> TryToRegister() async{
    Dio dio = Dio();
    String url = "http://$ST_url/users/register";
    Map <String,dynamic> mapp = Map();
    mapp["id"]=controller_userid.text;
    mapp["nickname"]=controller_1.text;
    mapp["pwd"]=controller_userpwd.text;
    if(sex==0) mapp["gender"]='M';
    else mapp["gender"]='F';

    if(xiaoqu==0) mapp["campus"]='X';
    else mapp["campus"]='L';

    mapp["qq"]=controller_qq.text;
    mapp["wechat"]=controller_wechat.text;
    mapp["major"]=controller_major.text;
    mapp["heading"]='';
    //if (kDebugMode) {print(mapp);}
    //var jsonstring = json.encode(mapp);
    try{
      Response response = await dio.post(url,data: mapp);
      //if (kDebugMode) {print(response);}
      Map<String,dynamic> fanhui = response.data;
      if(fanhui["flag"]==true) zhucechenggong=true;
      if (kDebugMode) {
        print(zhucechenggong);
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('注册',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),
        backgroundColor: Colors.white,
        actions: [IconButton(
            onPressed: (){
              if(controller_userpwd.text==''){
                Fluttertoast.showToast(msg: '请输入密码！');
              }
              else{
                if(controller_userpwd.text==controller_userpwd_again.text) {
                  if(controller_qq.text==controller_wechat) {
                    Fluttertoast.showToast(msg: '请输入微信qq中至少一个！');
                  }
                  else{

                    TryToRegister();
                    Future.delayed(Duration(milliseconds: 1200),(){
                      if(zhucechenggong==true){
                        Fluttertoast.showToast(msg: '注册成功！');
                        Navigator.of(context).pop();
                      }
                      else{
                        Fluttertoast.showToast(msg: '注册失败！');
                      }
                    });
                  }
                }
                else Fluttertoast.showToast(msg: '两次输入密码不一致！');
              }
            },
            icon: const ImageIcon(AssetImage('assets/png/wancheng.png'),color: Colors.black,)
        )],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Row(
              children: <Widget>[
                SizedBox(width: 25,height: height),
                Column(children: <Widget>[
                  SizedBox(width: width-50,height: 25),
                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                  const Text('学生卡ID',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    controller: controller_userid,
                    decoration: const InputDecoration(hintText: '请输入学生卡ID',),),),
                  SizedBox(width: width-50,height: 10,),
                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                  const Text('密码',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    obscureText: true,
                    controller: controller_userpwd,
                    decoration: const InputDecoration(hintText: '请输入密码',),),),
                  SizedBox(width: width-50,height: 10,),
                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                  const Text('重复密码',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    obscureText: true,
                    controller: controller_userpwd_again,
                    decoration: const InputDecoration(hintText: '请重复您的密码',),),),
                  SizedBox(width: width-50,height: 10,),
                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                  const Text('昵称',style: TextStyle(fontSize: 17),),),
                  const SizedBox(height: 5,),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    controller: controller_1,
                    decoration: const InputDecoration(hintText: '请输入昵称(最大长度为10)',),),),
                  SizedBox(
                    width: width-50,
                    height: 40,
                    child: Stack(children: <Widget>[
                      const Positioned(top:10,left:0,child: Text('性别',style: TextStyle(fontSize: 17),),),
                      Positioned(right:0,child: Row(children: <Widget>[
                        Radio(value: 0,onChanged: (value){setState(() {
                          sex=0;
                        });},
                          groupValue: sex,),
                        const Text('男'),
                        const SizedBox(width: 10,),
                        Radio(value: 1,onChanged: (value){setState(() {
                          sex=1;
                        });},
                          groupValue: sex,),
                        const Text('女'),
                      ],)),
                    ],),
                  ),
                  SizedBox(
                    width: width-50,
                    height: 40,
                    child: Stack(children: <Widget>[
                      const Positioned(top:10,left:0,child: Text('校区',style: TextStyle(fontSize: 17),),),
                      Positioned(right:0,child: Row(children: <Widget>[
                        Radio(value: 0,onChanged: (value){setState(() {
                          xiaoqu=0;
                        });},
                          groupValue: xiaoqu,),
                        const Text('北洋园'),
                        const SizedBox(width: 10,),
                        Radio(value: 1,onChanged: (value){setState(() {
                          xiaoqu=1;
                        });},
                          groupValue: xiaoqu,),
                        const Text('卫津路'),
                      ],)),
                    ],),
                  ),
                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                  const Text('QQ',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                    controller: controller_qq,
                    decoration: const InputDecoration(hintText: '请输入QQ(选填)',),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                  ),),

                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                  const Text('微信',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    controller: controller_wechat,
                    decoration: const InputDecoration(hintText: '请输入微信(选填)',),),),
                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                  const Text('专业',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    controller: controller_major,
                    decoration: const InputDecoration(hintText: '请输入专业(选填)',),),),
                ],),
              ],
            ),
          ),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
