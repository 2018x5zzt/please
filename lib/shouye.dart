import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/hall_tz.dart';

class ShouYe extends StatefulWidget {
  const ShouYe({Key? key}) : super(key: key);

  @override
  _ShouYeState createState() => _ShouYeState();
}

class _ShouYeState extends State<ShouYe> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('首 页',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: 1000,
        width: width,
        child: Column(children: <Widget>[
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
          SizedBox(height: 10,width: width,),
          Stack(
            children: <Widget>[
              Container(
              padding: const EdgeInsets.all(10.0),
              height: 190,
              //曾经是160
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
      ),
    );
  }
}
