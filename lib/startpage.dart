import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:please/UserId_global.dart';
import 'package:please/loginpage.dart';
import 'package:please/rootpage.dart';
import 'package:please/utils/BaseData.dart';
import 'package:please/utils/Sp.dart';


class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  String? userId;
  String? userPass;
  getData() async{
    String? _userId = await Storage.getString("userId");
    String? _userPass = await Storage.getString("userPass");
    if(mounted){
      setState(() {
        userId=_userId;
        userPass=_userPass;
        print('get完成');
      });
    }
  }
  var zzt=false;
  Future <void> TryToLogin() async{
    Dio dio = Dio();
    var id = userId;
    var pwd = userPass;
    //print('hello');
    String url = "http://$ST_url/users/login/$id/$pwd";
    //print(url);
    //print('world');
    Response response = await dio.get(url);
    print(response);
    Map <String,dynamic> data = response.data;
    zzt = false;
    if(data["flag"] == true) {
      zzt = true;
      //print(zzt);
    }
  }

  Future <void> Get_personal_information() async{
    Dio dio = Dio();
    String url_1 = "http://$ST_url/users/$UserId_Global";
    Response response = await dio.get(url_1);
    //print('你好你好');
    print(response);
    Map <String,dynamic> data = response.data;
    //print(data);
    Map <String,dynamic> dd = data["data"];
    //print(dd);
    BaseData basedata= BaseData.fromJson(dd);
    //print(basedata);
    User_Nickname = basedata.nickname;
    User_qq = basedata.qq;
    User_wechat = basedata.wechat;
    User_major = basedata.major;
    User_heading=dd['heading'];
    print('heading'+User_heading);
    if(basedata.gender=='M') User_Gender = 0;
    //else if(basedata.gender=='F') User_Gender = 1;
    else User_Gender =1;
    if(basedata.campus=='X') User_campus =0;
    //else if(basedata.campus=='L') User_campus = 2;
    else User_campus = 1 ;
  }

  Timer? _timer;
  // ignore: non_constant_identifier_names
  var _CurrentTime = 0;

  String appName ='';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  void getVersion() async{
    WidgetsFlutterBinding.ensureInitialized();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  void _jumprootpage(){
    _timer!.cancel();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context ) => RootPage(),
        ),
            (route) => false);
  }
  @override
  void initState() {
    super.initState();
    zzt=false;
    getVersion();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer)  {
      if(mounted){
        setState(() {
          _CurrentTime++;
        });
      }
      if(_CurrentTime == 4) {
       // _jumprootpage();
        getData().then((value){
          // ignore: unrelated_type_equality_checks
          if(userId!=Null) {
            // ignore: unrelated_type_equality_checks
            if(userPass!=Null) {
              TryToLogin().then((value){
                if(zzt == true){
                  UserId_Global = userId!;
                  User_Password = userPass!;
                  if (kDebugMode) {
                    print(UserId_Global);
                  }
                  if (kDebugMode) {
                    print(User_Password);
                  }
                  Get_personal_information().then((value) => _jumprootpage());
                }else{
                  print('失败');
                  _jumpLoginPage();
                }
              });

            }
          }
        });
      }
    });
  }
  //跳转首页
  void _jumpLoginPage(){
    _timer!.cancel();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context ) => LoginPage(),
        ),
            (route) => false);

  }
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const <Widget>[
          Center(
          child: Text('北洋杂烩',
            style: TextStyle(
              color: Color(0xFFA095B5),
              fontSize: 40,
            ),
          ),),
          Align(alignment: Alignment(0,0.8),child: Text('v1.1.5',style: TextStyle(fontSize: 14,color: Colors.grey),),),
          Align(alignment: Alignment(0, 0.6),child: Text('天外天工作室',style: TextStyle(fontSize: 18,color: Colors.grey),)),
          Align(alignment: Alignment(0, 0.7),child: Text('成双成队',style: TextStyle(fontSize: 16,color: Colors.grey),)),

        ],
      ),
    );
  }
}
