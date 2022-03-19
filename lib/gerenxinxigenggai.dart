import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/UserId_global.dart';
import 'package:please/utils/BaseData.dart';

class ChangePersonalInformation extends StatefulWidget {
  const ChangePersonalInformation({Key? key}) : super(key: key);

  @override
  _ChangePersonalInformationState createState() => _ChangePersonalInformationState();
}

class _ChangePersonalInformationState extends State<ChangePersonalInformation> {
  // ignore: prefer_typing_uninitialized_variables
  var controller_1;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var controller_qq;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var controller_wechat;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var controller_major;
  var sex=User_Gender;
  var xiaoqu=User_campus;
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
  }
  Future <void> TryToChange() async{
    Dio dio = Dio();
    String url = "http://$ST_url/users";
    Map <String,dynamic> mapp = Map();
    mapp["id"]=UserId_Global;
    if(controller_1.text!=''){
      mapp["nickname"]=controller_1.text;
      User_Nickname=controller_1.text;
    }else{mapp["nickname"] = User_Nickname;}
    mapp["pwd"]=User_Password;
    if(sex==0){
      mapp["gender"]='M';
      User_Gender=0;
    }
    else{
      mapp["gender"]='F';
      User_Gender=1;
    }
    if(xiaoqu==0) {
      mapp["campus"]='X';
      User_campus=0;
    }
    else {
      mapp["campus"]='L';
      User_campus=1;
    }
    if(controller_qq.text!=''){
      mapp["qq"]=controller_qq.text;
      User_qq=controller_qq.text;
    }else{mapp["qq"] = User_qq;}
    if(controller_wechat.text!=''){
      mapp["wechat"]=controller_wechat.text;
      User_wechat=controller_wechat.text;
    }else{mapp["wechat"] = User_wechat;}
    if(controller_major.text!=''){
      mapp["major"]=controller_major.text;
      User_major=controller_major.text;
    }else{mapp["major"] = User_major;}
    mapp["heading"]='';
    print(mapp);
    try{
      Response response = await dio.put(url,data: mapp);
      //print(response);
      Map<String,dynamic> fanhui = response.data;
      print(fanhui["flag"]);
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future <void> Get_personal_information() async{
    Dio dio = Dio();
    String url_1 = "http://$ST_url/users/$UserId_Global";
    Response response = await dio.get(url_1);
    Map <String,dynamic> data = response.data;
    Map <String,dynamic> dd = data["data"];
    dd["heading"]='';
    BaseData basedata= BaseData.fromJson(dd);
    User_Nickname = basedata.nickname;
    User_qq = basedata.qq;
    User_wechat = basedata.wechat;
    User_major = basedata.major;
    if(basedata.gender=='M') User_Gender = 0;
    else User_Gender = 1;

    if(basedata.campus=='X') User_campus =0;
    else User_campus = 1 ;
  }
  void changeGender(){
    if(sex==0){sex=1;}else{sex=0;}
    setState(() {});
  }
  void changeXiaoqu(){
    if(xiaoqu==0){xiaoqu=1;}else{xiaoqu=0;}
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('更改您的信息',style: TextStyle(color: Colors.black),),
        elevation: 0,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),
        backgroundColor: const Color(0x778B80A4),
        actions: [
          Container(
          width: 80,
          height: 5,
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
            onTap: (){
              TryToChange().then((value) {
                Get_personal_information().then((value){
                  Fluttertoast.showToast(msg: '个人信息更改成功！');
                  Future.delayed(const Duration(milliseconds: 800),(){
                    Navigator.of(context).pop("refresh");
                  });
                });
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Color(0xff8B80A4),
              ),
              child: const Center(child: Text('保存',style: TextStyle(fontSize: 13),)),
            ),
          ),
        )],
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x778B80A4),
              Color(0x008B80A4),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Row(children: <Widget>[
            SizedBox(height: height,width: 35,),
            SizedBox(height: height,width: width-70,child: Column(children: <Widget>[
              SizedBox(height: 180,width: width-70,
              child: Stack(children: <Widget>[
                Align(alignment: const Alignment(0,-0.4),child: Container(width: 110,height: 110,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(55)),
                color: Colors.blue),)),
                Align(alignment: const Alignment(0,0.8),child: Text(User_Nickname,style: TextStyle(fontSize: 18),),)
              ],),
              ),
              Container(width: width-70,height: 150,decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              padding: EdgeInsets.all(15),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-1,0),child: Text('昵称 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  Align(alignment: const Alignment(1,0),child: TextField(textAlign: TextAlign.right,
                  decoration: InputDecoration.collapsed(hintText: User_Nickname,hintStyle: const TextStyle(fontSize: 15,color: Color(
                      0xff707075))),style: const TextStyle(fontSize: 15,color: Color(
                        0xff707075)),controller: controller_1,onSubmitted: (text){
                    User_Nickname=controller_1.text;setState(() {});},),)
                ],),),
                SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-1,0),child: Text('性别 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  Align(alignment: const Alignment(1,0),child: GestureDetector(onTap: (){changeGender();},
                    child: Text((sex==0)?'男':'女',style: const TextStyle(fontSize: 15,color: Color(0xff707075)),),
                  )),
                ],),),
                SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-1,0),child: Text('专业 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  Align(alignment: const Alignment(1,0),child: TextField(textAlign: TextAlign.right,
                    decoration: InputDecoration.collapsed(hintText: User_major,hintStyle: const TextStyle(fontSize: 15,color: Color(
                        0xff707075))),style: const TextStyle(fontSize: 15,color: Color(
                        0xff707075)),controller: controller_major,),)
                ],),),
              ],)
              ),
              const SizedBox(height: 15,),
              Container(width: width-70,height: 150,
                padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
              ),child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                  SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                    const Align(alignment: Alignment(-1,0),child: Text('校区 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                    Align(alignment: const Alignment(1,0),child: GestureDetector(onTap: (){changeXiaoqu();},
                      child: Text((xiaoqu==0)?'北洋园':'卫津路',style: const TextStyle(fontSize: 15,color: Color(0xff707075)),),
                    )),
                  ],),),
                  SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                    const Align(alignment: Alignment(-1,0),child: Text('QQ :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                    Align(alignment: const Alignment(1,0),child: TextField(textAlign: TextAlign.right,
                      decoration: InputDecoration.collapsed(hintText: User_qq,hintStyle: const TextStyle(fontSize: 15,color: Color(
                          0xff707075))),style: const TextStyle(fontSize: 15,color: Color(
                          0xff707075)),controller: controller_qq,),)
                  ],),),
                  SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                    const Align(alignment: Alignment(-1,0),child: Text('微信 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                    Align(alignment: const Alignment(1,0),child: TextField(textAlign: TextAlign.right,
                      decoration: InputDecoration.collapsed(hintText: User_wechat,hintStyle: const TextStyle(fontSize: 15,color: Color(
                          0xff707075))),style: const TextStyle(fontSize: 15,color: Color(
                          0xff707075)),controller: controller_wechat,),)
                  ],),),
                ],),),
            ],),),
            SizedBox(height: height,width: 35,),
          ],),
        ),
      ),
    );
  }
}

/*
      Container(
        width: ,
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Row(
              children: <Widget>[
                SizedBox(width: 25,height: height),
                Column(children: <Widget>[
                  SizedBox(width: width-50,height: 25),
                  Container(width: width-50,height: 25,alignment: Alignment.centerLeft,child:
                    const Text('昵称',style: TextStyle(fontSize: 17),),),
                  const SizedBox(height: 5,),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    controller: controller_1,
                    decoration: const InputDecoration(hintText: '请输入昵称(最大长度为10)',),),),
                  SizedBox(width: width-50,height: 10,),
                  SizedBox(
                    width: width-50,
                    height: 50,
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
                    height: 50,
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
                  const SizedBox(height: 5,),
                  Container(width: width-50,height: 30,alignment: Alignment.centerLeft,child:
                  const Text('微信',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    controller: controller_wechat,
                    decoration: const InputDecoration(hintText: '请输入微信(选填)',),),),
                  Container(width: width-50,height: 30,alignment: Alignment.centerLeft,child:
                  const Text('专业',style: TextStyle(fontSize: 17),),),
                  SizedBox(width: width-50,height: 35,child: TextField(
                    controller: controller_major,
                    decoration: const InputDecoration(hintText: '请输入专业(选填)',),),),
                ],),
                //Positioned(right:0,child: SizedBox(width: 25,height: height,)),
              ],
            ),
          ),
        ),
      ),
      */