import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:please/rootpage.dart';
import 'package:please/RegisterPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/UserId_global.dart';
import 'package:please/utils/BaseData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:please/utils/Sp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  /*sharedpreference本地*/
  String? userId;
  String? userPass;
  getData() async{
    String? _userId = await Storage.getString("userId");
    String? _userPass = await Storage.getString("userPass");
    print("_id:$_userId");
    print("_pwsd:$_userPass");
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

  var zzt = false;
  Future <void> TryToLogin() async{
    Dio dio = Dio();
    var id = controller.text;
    var pwd = _controller.text;
    String url = "http://$ST_url/users/login/$id/$pwd";
    //print(url);
    Response response = await dio.get(url);
    //print(response);
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
    dd["heading"]='';
    //print(dd);
    BaseData basedata= BaseData.fromJson(dd);
    //print(basedata);
    User_Nickname = basedata.nickname;
    User_qq = basedata.qq;
    User_wechat = basedata.wechat;
    User_major = basedata.major;
    if(basedata.gender=='M') User_Gender = 0;
    //else if(basedata.gender=='F') User_Gender = 1;
    else User_Gender =1;
    if(basedata.campus=='X') User_campus =0;
    //else if(basedata.campus=='L') User_campus = 2;
    else User_campus = 1 ;
  }
  void _jumprootpage(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context ) => RootPage(),
        ),
            (route) => false);
  }
  bool _showpassword = true;
  bool _finishinput = false;
  var controller;
  var _controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: UserId_Global);
    controller.addListener((){});
    _controller = TextEditingController(text: User_Password);
    _controller.addListener((){});
    controller.text = UserId_Global;
    _controller.text = User_Password;

    if(controller.text=="" || _controller.text=="") {
      _finishinput=false;
    } else {
      _finishinput = true;
    }
    getData();

  }
  void _touchtochange(){
    setState(() {
      _showpassword = !_showpassword;
    });
  }
  @override
  void inputfinished(){
    setState(() {
      if(controller.text=="" || _controller.text=="") {
        _finishinput=false;
      } else {
        _finishinput = true;
      }
    });
  }
  final mUserName = 'userName';
  @override
  Widget build(BuildContext context) {
    save() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(mUserName, controller.text.toString());
    }

    Future<String> get() async{
      var mUserId;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      mUserId = prefs.getString(mUserName);
      return mUserId;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SizedBox(
          height: 1000,
          child: Column(children: <Widget>[
            Container(height: 200,),
            Container(
              height: 50,
              width: 150,
            //  color: Colors.yellow,
              child : Stack(
                children: <Widget>[
                  Positioned(child: Container(width: 53,height: 28,color: const Color(0xffb3acc1),)),
                  Positioned(left: 30,top: 20,child: Container(width: 120,height: 32,color: const Color(0x99b3acc1),)),
                  const Positioned(left: 16, top: 8, child: Text('WELCOME', style: TextStyle(fontSize: 25),),),
                ],
              ),
            ),
            Container(height: 50,),
            SizedBox(
              width: 400,
              height: 50,
              child: Row(children: <Widget>[
                Container(
                  width: 50,
                ),
                Expanded(child:
                  TextField(
                    controller: controller,
                    //onChanged: (text){print('输入改变'+text);},
                    onChanged: (text){inputfinished();_controller.clear();},
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Color(0xffb3acc1),),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Color(0x99b3acc1),),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: '请输入账号',
                      hintStyle: const TextStyle(color:Color(0xFFb3acc1), ),
                      prefixIcon: IconButton(
                        icon: Image.asset("assets/png/账号.png"),
                        onPressed: (){},
                        iconSize: 5,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: (){controller.clear();_controller.clear();},
                      ),

                    ),
                  ),
                ),
                Container(
                  width: 50,
                ),
              ],),
            ),
            Container(
              height: 30,
            ),
            SizedBox(
              width: 400,
              height: 50,
              child: Row(children: <Widget>[
                Container(
                  width: 50,
                ),
                Expanded(child:
                TextField(
                  obscureText: _showpassword,
                  controller: _controller,
                  onChanged: (text){inputfinished();},
                  //onChanged: (text){print('输入改变'+text);},

                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Color(0xffb3acc1),),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Color(0x99b3acc1),),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: '请输入密码',
                    hintStyle: const TextStyle(color:Color(0xFFb3acc1), ),
                    prefixIcon: IconButton(
                      icon: Image.asset("assets/png/密码.png"),
                      onPressed: (){},
                      iconSize: 5,
                    ),

                    suffixIcon: GestureDetector(
                      onTap: (){_touchtochange();},
                      child: Icon(_showpassword ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ),
                ),
                Container(
                  width: 50,
                ),
              ],),
            ),
            Container(
              height: 60,
            ),
            GestureDetector(
              onTap: (){
                //_jumprootpage();
                //print('尝试登录');
                if(_finishinput == false){
                  Fluttertoast.showToast(msg: '请输入账号和密码！');
                }
                else{
                  TryToLogin();
                  Future.delayed(Duration(seconds: 1),(){
                    if(zzt == true) {
                      UserId_Global = controller.text;
                      User_Password = _controller.text;
                      //removeData();
                      setData().then((value){
                        Get_personal_information().then((value) => _jumprootpage());
                      });
                      /*

                      getData().then((value) {
                        print(userId);
                        print(userPass);
                        print('完成');
                      });

                       */
                    }
                    else {
                      Fluttertoast.showToast(msg: '用户名或密码错误！');
                    }
                  });
                }
              },
              child: Container(
                height: 50,
                width: 140,
                decoration: BoxDecoration(
                  color: _finishinput ? const Color(0xCC3F394B): const Color(0xffb3acc1),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text('登  录', style: TextStyle(fontSize: 22, color: Colors.white,),),
              ),

            ),
            const SizedBox(height: 15,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
            }, child: Text('没有账号？点我注册！',style: TextStyle(fontSize: 14),))

          ],),
        ),
      ),
    );
  }
}
