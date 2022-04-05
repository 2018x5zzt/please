import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/hall_tz.dart';

import 'UserId_global.dart';

class ShouYe extends StatefulWidget {
  const ShouYe({Key? key}) : super(key: key);

  @override
  _ShouYeState createState() => _ShouYeState();
}

class _ShouYeState extends State<ShouYe> {
  String sentense_0 = '拼小车车';
  String sentense_1 = '学小习习';
  String sentense_2 = '吃小喝喝';
  Future <void> getNote() async {
    Dio dio = Dio();
    String url_0 = 'http://$ST_url/sentences/0';
    String url_1 = 'http://$ST_url/sentences/1';
    String url_2 = 'http://$ST_url/sentences/2';
    Response response0 = await dio.get(url_0);
    Response response1 = await dio.get(url_1);
    Response response2 = await dio.get(url_2);
    if (kDebugMode) {
      print(response0);
    print(response1);
    print(response2);
  }

    var mp0 = response0.data["data"];
    var mp1 = response1.data["data"];
    var mp2 = response2.data["data"];
    if (kDebugMode) {
      print(mp0);
      print(mp1);
      print(mp2);
    }
    sentense_0 = mp0["content"];
    sentense_1 = mp1["content"];
    sentense_2 = mp2["content"];
    setState(() {
    });
}
@override
  void initState() {
    getNote();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFC8C4DB),
        title: const Text('首 页',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC8C4DB),
              Color(0xFFF3F3F3),
              Color(0xFFF3F3F3),
            ],
          ),
        ),
        child: Row(children: <Widget>[
          const SizedBox(width: 30,),
          SizedBox(width: width-60,height: height,child: Column(children: <Widget>[
            const SizedBox(height: 30,),
            ///下面是拼车的小块
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const CallHall()));
              },
              child: Container(width: width-60,height: (height-250)/3,decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [BoxShadow(
                  color: Color(0x11000000),
                  offset: Offset(0,5),
                  blurRadius: 10,

                ),],
                color: Colors.white
              ),
                child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-0.7,-0.6),child: Text('拼车',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
                  Align(alignment: const Alignment(0,0.4),child: Text('「 $sentense_0」'),),
                  Align(alignment: const Alignment(1,1.3),child: SvgPicture.asset('assets/svg/爱车_1.svg',width: 130,height: 130,color: const Color(0x33C7C3DC),))
                ],),
              ),
            ),
            const SizedBox(height: 25,),
            ///下面是学习的小块
            GestureDetector(
              onTap: (){
                Fluttertoast.showToast(msg: '功能开发中！');
              },
              child: Container(width: width-60,height: (height-250)/3,decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [BoxShadow(
                    color: Color(0x22000000),
                    offset: Offset(0,5),
                    blurRadius: 10,

                  ),],
                  color: Color(0xFFE3E1ED),
              ),
                child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-0.7,-0.6),child: Text('学习',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
                  Align(alignment: const Alignment(0,0.4),child: Text('「 $sentense_1」'),),
                  Align(alignment: const Alignment(1,1.5),child: SvgPicture.asset('assets/svg/学习.svg',width: 135,height: 135,color: const Color(0x33FFFFFF)))
                ],),
              ),
            ),
            const SizedBox(height: 25,),
            ///下面是吃喝玩乐的小块
            GestureDetector(
              onTap: (){
                var srand = Random().nextInt(100);
                if (kDebugMode) {
                  print(srand);
                }
                if(srand<=30) {
                  Fluttertoast.showToast(msg: '变成光守护嘉然小姐');
                }else if(srand<=60){
                  Fluttertoast.showToast(msg: '好果汁！你让我陷入疯狂！');
                }else{
                  Fluttertoast.showToast(msg: '功能开发中');
                }
              },
              child: Container(width: width-60,height: (height-250)/3,decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [BoxShadow(
                    color: Color(0x11000000),
                    offset: Offset(0,5),
                    blurRadius: 10,
                  ),],
                  color: Colors.white
              ),
                child: Stack(children: <Widget>[
                  const Align(alignment: Alignment(-0.7,-0.6),child: Text('吃喝玩乐',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
                  Align(alignment: const Alignment(0,0.4),child: Text('「 $sentense_2 」'),),
                  Align(alignment: const Alignment(1.1,1.6),child: SvgPicture.asset('assets/svg/吃喝玩乐.svg',width: 140,height: 140,color: const Color(0x33C7C3DC),))
                ],),
              ),
            ),
          ],),),
          const SizedBox(width: 30,),
        ],)
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('sentense_1', sentense_1));
  }
}
/*
        Column(children: <Widget>[

          SizedBox(height: 10,width: width,),
          Stack(
            children: <Widget>[
              Container(
              padding: const EdgeInsets.all(10.0),
              height: 190,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CallHall()));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                      '拼车',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB3ACC1),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))
                  ),
                ),
              ),
            ),
              Positioned(right:60,bottom:60,child: GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CallHall()));},
                  child: Transform.scale(scale: 5,child: const ImageIcon(AssetImage("assets/png/汽车.png"),color: Colors.white30,),))),
          ]),
          Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 190,
                  child: InkWell(
                    onTap: (){
                      Fluttertoast.showToast(msg: '功能开发中,,,敬请期待！');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        '学习',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          color: Color(0xFFB3ACC1),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                      ),
                    ),
                  ),
                ),
                Positioned(right:60,bottom:60,child: GestureDetector(
                  onTap: (){Fluttertoast.showToast(msg: '不要乱点啦喂！');},
                    child: Transform.scale(scale: 5,child: const ImageIcon(AssetImage("assets/png/配网引导.png"),color: Colors.white30,),))),
              ]),
          Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 190,
                  child: InkWell(
                    onTap: (){
                      Fluttertoast.showToast(msg: '功能开发中,,,敬请期待！');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        '吃喝玩乐',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          color: Color(0xFFB3ACC1),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                      ),
                    ),
                  ),
                ),
                Positioned(right:60,bottom:60,child: GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(msg: '嘉然');
                  },
                    child: Transform.scale(scale: 5,child: const ImageIcon(AssetImage("assets/png/城市.png"),color: Colors.white30,),))),
              ]),
        ],),
      */
/*
          GestureDetector(
            onTap: (){},
            child: Container(
              width: width,
              height: 70,
              color: Colors.grey[300],
              child: SizedBox(
                width: width,
                height: 70,
                child: Row(children: <Widget>[
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Transform.scale(scale: 0.5,child: const ImageIcon(AssetImage("assets/png/站内消息备份.png"),color: Colors.grey,),)
                  ),

                  Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                      Container(height: 2,),
                      Text(
                        ' 【拼车】',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),

                      Text(
                        '2021年12月16日8：30',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),

                      Text(
                        '天津大学北洋园校区→津南永旺 (1/3)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],),
                  ),
                ],),
              ),
            ),
          ),
          */
///灰色的消息通知条