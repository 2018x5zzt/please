import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/UserId_global.dart';
import 'package:please/gerenxinxigenggai.dart';
import 'package:please/fankui.dart';
import 'package:please/loginpage.dart';
import 'package:please/utils/BaseData.dart';
import 'package:please/utils/Sp.dart';

class GeRenZhongXin extends StatefulWidget {
  const GeRenZhongXin({Key? key}) : super(key: key);

  @override
  _GeRenZhongXinState createState() => _GeRenZhongXinState();
}

class _GeRenZhongXinState extends State<GeRenZhongXin> {
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
  }
  @override

  /*sharedpreference本地*/
  String? userId;
  String? userPass;
  getData() async{
    String? _userId = await Storage.getString("userId");
    String? _userPass = await Storage.getString("userPass");
    //print("_id:$_userId");
   // print("_pwsd:$_userPass");
    setState(() {
      userId=_userId;
      userPass=_userPass;
      print('get完成');
    });
  }
  // 设置数据
  setData() async{
    if (kDebugMode) {
      print("存储$UserId_Global");
    }
    if (kDebugMode) {
      print("存储$User_Password");
    }
    await Storage.setString("userId", UserId_Global);
    await Storage.setString("userPass", User_Password);
  }
  // 移除数据
  removeData() async{
    await Storage.removeString("userId");
    await Storage.removeString("userPass");
    setState(() {
      userId=null;
      userPass=null;
    });
  }
  /*sharedpreference本地*/

  @override

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('个人信息',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        /*
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),

         */
        backgroundColor: const Color(0x778B80A4),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangePersonalInformation())).then((resultData) {
                print('返回');
                Future.delayed(Duration(microseconds: 1000)).then((value) {
                  setState(() {
                  });
                });

              });
            },
            child: Container(height: 40,width: 60,child: Row(children: <Widget>[
              Text('更改',style: TextStyle(color: Colors.black,fontSize: 17),),
              ImageIcon(AssetImage('assets/png/jinru.png'),color: Colors.black,),
            ],),),
          ),

          ],
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
                    Align(alignment: const Alignment(1,0),child: Text(User_Nickname,style: TextStyle(fontSize: 15,color: Colors.black),),)
                  ],),),
                  SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                    const Align(alignment: Alignment(-1,0),child: Text('性别 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                    Align(alignment: const Alignment(1,0),child: Text((User_Gender==0) ? '男':'女',style: TextStyle(fontSize: 15,color: Colors.black),),),
                  ],),),
                  SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                    const Align(alignment: Alignment(-1,0),child: Text('专业 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                    Align(alignment: const Alignment(1,0),child: Text(User_major,style: TextStyle(fontSize: 15,color: Colors.black),),)
                  ],),),
                ],)
            ),
            const SizedBox(height: 20,),
            Container(width: width-70,height: 150,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
              ),child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-1,0),child: Text('校区 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  Align(alignment: const Alignment(1,0),child: Text((User_campus==0) ? '北洋园':'卫津路',style: TextStyle(fontSize: 15,color: Colors.black),),)
                ],),),
                SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-1,0),child: Text('QQ :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  Align(alignment: const Alignment(1,0),child: Text(User_qq,style: TextStyle(fontSize: 15,color: Colors.black),))
                ],),),
                SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-1,0),child: Text('微信 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  Align(alignment: const Alignment(1,0),child: Text(User_wechat,style: TextStyle(fontSize: 15,color: Colors.black),))
                ],),),
              ],),),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                removeData().then((value){
                  if (kDebugMode) {
                    print(userId);
                  }
                  if (kDebugMode) {
                    print(userPass);
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                });
              },
              child: Container(width: width-70,height: 50,decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(child: Text('退出登录',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),),
              ),
            ),
            const SizedBox(height: 10,),
            Container(width: width-70,height: 30,
              child: Stack(children: <Widget>[
                Align(alignment: const Alignment(1.0,0),child: GestureDetector(
                  onTap: (){
                    print('反馈');
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BackSeed()));
                  },
                    child: Text('遇到问题了？点我反馈！',style: TextStyle(fontSize: 13,color: Colors.blue),)),)
              ],),
            ),
          ],),),
          SizedBox(height: height,width: 35,),
        ],),
      ),
    );
  }
}

/*
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('个人中心',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: width,
        height: 1000,
        child: Column(children: <Widget>[
          SizedBox(
            width: width,
            height: 130,
            child: Row(children: <Widget>[
              const SizedBox(height: 130,width: 30,),
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/png/帖子.png")),
                  borderRadius: BorderRadius.circular(43),
                ),
              ),
              const SizedBox(height: 130,width: 25,),
              Text('$User_Nickname',style: TextStyle(fontSize: 18),),
              const SizedBox(height: 130,width: 7,),
              ///const ImageIcon(AssetImage("assets/png/guanliyuan.png"),color: Colors.grey,),
            ],),
          ),
          Container(
            width: width,
            height: 130,
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1,color: Colors.grey),
              ),
              child: Stack(children: <Widget>[
                Positioned(top: 2,child: SizedBox(
                  width: width,
                  height: 48,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangePersonalInformation())).then((resultData) {
                        print('返回');
                        Future.delayed(Duration(microseconds: 1000)).then((value) {
                          setState(() {

                          });
                        });

                      });

                    },
                    child: SizedBox(
                      height: 48,
                      width: width,
                      child: Row(children: <Widget>[
                        Container(width: 20,),
                        Transform.scale(scale: 1.2,child: const ImageIcon(AssetImage('assets/png/gerenxinxi.png'))),
                        Container(width: 10,),
                        const Text('个人信息更改',style: TextStyle(fontSize: 15),),
                      ],),
                    ),
                  ),
        //          color: Colors.blue,
                )),
                const Divider(height: 100,color: Colors.grey,),
                Positioned(bottom: 2,child: SizedBox(
                  width: width,
                  height: 48,
         //         color: Colors.green,
                  child: InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BackSeed()));},
                    child: SizedBox(
                      height: 48,
                      width: width,
                      child: Row(children: <Widget>[
                        Container(width: 20,),
                        Transform.scale(scale: 1.2,child: const ImageIcon(AssetImage('assets/png/fankui.png'))),
                        Container(width: 10,),
                        const Text('反馈',style: TextStyle(fontSize: 15),),
                      ],),
                    ),
                  ),
                )),
              ],),
            )
          ),
          SizedBox(
            width: width,
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              //print("1");
              //print(UserId_Global);
            },
            child: Container(
              width: width,
              height: 70,
              padding: EdgeInsets.all(15),
              child: InkWell(
                onTap: (){
                  removeData().then((value){
                    if (kDebugMode) {
                      print(userId);
                    }
                    if (kDebugMode) {
                      print(userPass);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1,color: Colors.grey),
                  ),
                  child: SizedBox(
                    height: 48,
                    width: width,
                    child: Row(children: <Widget>[
                      Container(width: 20,),
                      Transform.scale(scale: 1.0,child: const ImageIcon(AssetImage('assets/png/dengchu.png'))),
                      Container(width: 10,),
                      const Text('登出',style: TextStyle(fontSize: 15),),
                    ],),
                  ),
                ),
              ),
            ),
          ),
        ],),
      ),
       */