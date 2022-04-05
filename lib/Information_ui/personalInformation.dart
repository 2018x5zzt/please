// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:please/UserId_global.dart';

import 'bigPicture.dart';

class PersonalInformation extends StatefulWidget {
  final personId;
  const PersonalInformation({Key? key,this.personId}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<PersonalInformation> createState() => _PersonalInformationState(personId);
}

class _PersonalInformationState extends State<PersonalInformation> {
  String studentId;
  _PersonalInformationState(this.studentId);
  Map <String,dynamic> mmap = {};
  Future <void> getStudentInformation() async{
    Dio dio = Dio();
    String url = 'http://$ST_url/users/$studentId';
    Response res = await dio.get(url);
    var ttmp=res.data["data"];
    mmap = ttmp;
    if (kDebugMode) {
      print(mmap['heading']);
      print(mmap);
    }


  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return FutureBuilder(
      future: getStudentInformation(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(
              appBar: AppBar(
                title: const Text('用户主页',style: TextStyle(color: Colors.black),),
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
                  onPressed: (){Navigator.of(context).pop();},
                ),
                backgroundColor: const Color(0xFFC8C4DB),
              ),
              body: Container(
                width: width,
                height: height,
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
                  SizedBox(height: height,width: 35,),
                  SizedBox(height: height,width: width-70,child: Column(children: <Widget>[
                    SizedBox(height: 180,width: width-70,
                      child: Stack(children: <Widget>[
                        Align(alignment: const Alignment(0,-0.4),child: GestureDetector(
                          onTap: (){
                              if (kDebugMode) {
                                print('你好');
                              }
                              if(mmap['heading']!='') Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShowBigPicture(imageUrl: mmap['heading'].toString(),)));
                            },
                          child: Container(width: 120,height: 120,
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),color: Colors.white
                                ),child: Center(
                                  child: Container(width:105,height:105,decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
                                  child: ClipOval(child: (mmap['heading']=='')?Image.asset('assets/png/帖子.png',):Image.network(mmap['heading'],fit: BoxFit.cover,),)),
                                ),),
                        )),
                        Align(alignment: const Alignment(0,0.95),child: Text(mmap["nickname"],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                      ],),
                    ),
                    SizedBox(width: width-70,height: 20,child: Center(child: Text('id: '+mmap["id"],style: const TextStyle(color: Colors.grey),),)),
                    const SizedBox(height: 27,),
                    Container(width: width-70,height: 150,decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                    ),
                        padding: const EdgeInsets.all(15),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                          SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                            const Align(alignment: Alignment(-1,0),child: Text('昵称 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                            Align(alignment: const Alignment(1,0),child: Text(mmap["nickname"],style: const TextStyle(fontSize: 15,color: Colors.black),),)
                          ],),),
                          SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                            const Align(alignment: Alignment(-1,0),child: Text('性别 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                            Align(alignment: const Alignment(1,0),child: Text((mmap["gender"]=='M') ? '男':'女',style: const TextStyle(fontSize: 15,color: Colors.black),),),
                          ],),),
                          SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                            const Align(alignment: Alignment(-1,0),child: Text('专业 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                            Align(alignment: const Alignment(1,0),child: Text(mmap["major"],style: const TextStyle(fontSize: 15,color: Colors.black),),)
                          ],),),
                        ],)
                    ),
                    const SizedBox(height: 10,),
                    Container(width: width-70,height: 150,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.white,
                      ),child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                        SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                          const Align(alignment: Alignment(-1,0),child: Text('校区 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                          Align(alignment: const Alignment(1,0),child: Text((mmap["campus"]=='X') ? '北洋园':'卫津路',style: const TextStyle(fontSize: 15,color: Colors.black),),)
                        ],),),
                        SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                          const Align(alignment: Alignment(-1,0),child: Text('QQ :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                          Align(alignment: const Alignment(1,0),child: Text(mmap["qq"],style: const TextStyle(fontSize: 15,color: Colors.black),))
                        ],),),
                        SizedBox(width: width-120,height: 30,child: Stack(children: <Widget>[
                          const Align(alignment: Alignment(-1,0),child: Text('微信 :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                          Align(alignment: const Alignment(1,0),child: Text(mmap["wechat"],style: const TextStyle(fontSize: 15,color: Colors.black),))
                        ],),),
                      ],),),
                    const SizedBox(height: 20,),

                  ],),),
                  SizedBox(height: height,width: 35,),
                ],),
              ),
            );

          }else{
            return Container(
              width: width,
              height: height,
              color: Colors.white,
              child: Container(
                width: width,
                height: height,
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
              ),
            );
          }

        }
    );
  }
}
