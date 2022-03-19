import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:please/rootpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RootPage()));
          },
        ),
        title: const Text(
          '个人中心',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          textAlign: TextAlign.right,
        ),
        ),
      body: SizedBox(
        height: 1000,
        child: Column(children: <Widget>[
          Container(height: 25,),
          SizedBox(
            width: 500,
            child: Row(children: <Widget>[
              Container(width: 70,),
              Container(
                width: width-140,
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  '个人信息',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.yellowAccent,
                ),
              ),
              Container(width: 70,),
            ],),
          ),
          ///个人信息的黄色框
          Container(height: 20,),
          SizedBox(
            width: 500,
            child: Row(children: <Widget>[
              Container(width: 30,),
              SizedBox(
                height: 150,
                width: 200,
                child:Column(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 200,
                      child: Row(children: <Widget>[
                        Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '昵称:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        const Expanded(child:
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        ),
                        Container(
                          width: 30,
                        ),
                      ],),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 200,
                      child: Row(children: <Widget>[
                        Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '性别:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        const Expanded(child:
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        ),
                        Container(
                          width: 30,
                        ),
                      ],),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 200,
                      child: Row(children: <Widget>[
                        Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '校区:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        const Expanded(child:
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        ),
                        Container(
                          width: 30,
                        ),
                      ],),
                    ),
                  ),
                ],)
                ,),
              Container(width: 10,),
              GestureDetector(
                onTap: (){
                  if (kDebugMode) {
                    print('没做完呢');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 170,
                  child: const Text(
                    '(上传头像)',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ],),
          ),
          ///昵称性别校区以及上传头像按钮
          Container(height: 20,),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: 150,
              width: 330,
              child:Column(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 500,
                    child: Row(children: <Widget>[
                      Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'QQ:  ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      const Expanded(child:
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ),
                      Container(
                        width: 10,
                      ),
                    ],),
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 500,
                    child: Row(children: <Widget>[
                      Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '微信:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      const Expanded(child:
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ),
                      Container(
                        width: 10,
                      ),
                    ],),
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 500,
                    child: Row(children: <Widget>[
                      Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '专业:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      const Expanded(child:
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ),
                      Container(
                        width: 10,
                      ),
                    ],),
                  ),
                ),
              ],)
              ,),
          ),
          ///qq，微信，专业的信息栏
          Container(height: 70,),
          MaterialButton(
            color: Colors.green,
            child: const Text(
              '确认提交/更改',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => RootPage()));},
          ),
        ],),
      ),
    );
  }
}
