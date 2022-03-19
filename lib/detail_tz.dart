
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:please/Jubao.dart';
import 'package:please/UserId_global.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Detail_tz extends StatefulWidget {
  final postid;
  Detail_tz({Key? key,this.postid}) : super(key: key);
  @override

  _Detail_tzState createState() => _Detail_tzState(postid);
}
class _Detail_tzState extends State<Detail_tz> {
  var in_the_team = false;
  String Postid='';
  var tteamId;
  Map <String,dynamic> dd = Map();
  _Detail_tzState(this.Postid);
  int ST=0;
  var successfully_joinin = false;
  int predict_num=0;
  List <dynamic> list=[];
  List <Map<String,dynamic>> MB=[];
  @override
  Future <void> Obtaindetaildata() async{
    //print("obtain");
    Dio dio = Dio();
    String url = "http://$ST_url/posts/$Postid";
    Response response = await dio.get(url);
    //print('response');
    //print(response);
    Map<String,dynamic> data = response.data;
    dd = data["data"];
    tteamId = dd["teamId"];
    print('teamId:$tteamId');
    String url_2 = 'http://$ST_url/teams/count/$tteamId';
    String url_1 = 'http://$ST_url/teams/$tteamId';
    String url_3 = 'http://$ST_url/teams/tm/$tteamId';
    Response responsewsws = await dio.get(url_2);
    //print('responsenwnw');
    //print(responsewsws);
    Response res = await dio.get(url_1);
    //print('res');
    print(res);
    Response zres = await dio.get(url_3);
    //print(zres);
    MB.clear();
    list.clear();
    var zztdata = responsewsws.data;
    ST = zztdata["data"];
    var ddata = res.data;
    list=ddata["data"];
    for(int i=0;i<ST;i++){
      Map<String,dynamic> tmpk= list[i];
      if(tmpk["id"] == UserId_Global) in_the_team = true;
      MB.add(tmpk);
    }
    print(MB[0]['nickname']);
    if(ST!=list.length){
      print('长度出错啦！');
    }
    var somt = zres.data;
    var tmplk = somt["data"];
    predict_num = tmplk["teamNumber"];
    //print(predict_num);
    //print('in the team : $in_the_team');
  }
  Future <void> Delete_post() async{
    Dio dio = Dio();
    String url = "http://$ST_url/posts/$Postid";
    Response response = await dio.delete(url);
    if (kDebugMode) {
      print(response);
    }
  }

  Future <void> Join_in() async{
    print("join");
    Dio dio = Dio();
    String url = "http://$ST_url/teams/apply";
    Map<String,dynamic> mapp = Map();
    mapp["teamId"] = tteamId;
    mapp["memberId"] = UserId_Global;
    Response response = await dio.post(url,data: mapp);
    if (kDebugMode) {
      print(response);
    }
    successfully_joinin = response.data["flag"];
    print(successfully_joinin);
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return FutureBuilder(
      future: Obtaindetaildata(),
        builder:(BuildContext context,AsyncSnapshot snapshot){

        if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: const Text('帖子详情',style: TextStyle(color: Colors.black),), centerTitle: true,
                  leading: IconButton(
                    icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  actions: [
                    (dd["posterId"]!=Null) ?
                    IconButton(onPressed: (){
                      if(dd["posterId"] == UserId_Global){
                        print('删除帖子');
                        Delete_post();
                        Fluttertoast.showToast(msg: '删除成功！');
                        Navigator.of(context).pop();
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                          var tmp = Postid;
                          return JuBao(postid: '$tmp',);
                        }));
                      }
                    },
                        icon: (dd["posterId"] == UserId_Global) ? ImageIcon(AssetImage('assets/png/shanchu.png'),color: Color(0xFFB3ACC1),)
                            : ImageIcon(AssetImage('assets/png/jubao.png'),color: Color(0xFFB3ACC1),)
                    ) : Container()
                  ],
                ),

                body: (dd["posterName"] != Null ) ? Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(height: height,width: width-50,child: Column(children: <Widget>[
                    const SizedBox(height: 20,),
                    SizedBox(height: 44,width: width-50,child: Row(children: <Widget>[
                      ///头像的部分
                      Container(
                        height: 44,width: 44,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),image: DecorationImage(fit: BoxFit.cover,image:AssetImage("assets/png/帖子.png"), )),
                      ),
                      const SizedBox(width: 10,),
                      ///用户名，发布时间
                      Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                        Text(dd["posterName"],style: TextStyle(color: Colors.black,fontSize: 16),),
                        Text(dd["postTime"],style: TextStyle(color: Colors.grey),),
                      ],)
                    ],),),
                    const SizedBox(height: 25,),
                    SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
                      Container(height: 24,width: 60,decoration: const BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                      Center(child: Text('出发地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                      const SizedBox(width: 5,), Text(dd["startLocation"],style: TextStyle(fontSize: 15,),),
                    ],),),
                    const SizedBox(height: 4,),
                    Container(height: 24,width: width-50,child: Row(children: <Widget>[
                      Container(height: 24,width: 60,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                      Center(child: Text('目的地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                      const SizedBox(width: 5,), Text(dd["destination"],style: TextStyle(fontSize: 15,),),
                    ],),),
                    const SizedBox(height: 4,),
                    SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
                      Container(height: 24,width: 75,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                      Center(child: Text('拼车时间',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                      const SizedBox(width: 5,), Text(dd["year"].toString()+'年'+dd["month"].toString()+'月'+dd["day"].toString()+'日 '+dd["hour"].toString()+':'+dd["minute"].toString(),style: const TextStyle(fontSize: 15,),),
                    ],),),
                    const SizedBox(height: 4,),
                    Container(height: 200,width: width-50,alignment:Alignment.topCenter,child: Row(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                      Container(height: 24,width: 40,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                      Center(child: Text('描述',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                      const SizedBox(width: 5,), Expanded(
                        child: Text(dd["content"],style:
                        TextStyle(fontSize: 15),),
                      ),
                    ],),),
                    Container(
                      width: width-50,
                      height: 150,
                      //color: Colors.yellow,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(width: 70,height: 150,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                            Container(width: 70,height: 70,decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular((35))),
                                image: DecorationImage(image: AssetImage('assets/png/帖子.png')),
                            ),),
                            Text(MB[0]['nickname']),
                          ],),),
                          Container(width: 1,height: 70,color: Colors.grey,),

                          /*以下是一个方块组件*/
                          (predict_num >= 2) ? SizedBox(width: 70,height: 100,child: ( ST>=2 ) ?
                          Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                            Container(width: 70,height: 70,decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular((35))),
                                image: DecorationImage(image: AssetImage('assets/png/帖子.png')),
                            ),),
                            Text(MB[1]['nickname']),
                          ],) : Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [
                            (in_the_team == false) ? GestureDetector(
                              onTap:(){
                                successfully_joinin = false;
                                Join_in().then((value) {
                                  if(successfully_joinin==true){
                                    Fluttertoast.showToast(msg: '申请加入成功！');
                                    Obtaindetaildata().then((value) {Navigator.of(context).pop();});
                                  }else{
                                    Fluttertoast.showToast(msg: '申请加入失败！');
                                    Obtaindetaildata();
                                  }
                                });
                                print("加入");
                              },
                              child: Container(width: 70,height: 70,decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular((35))),
                                border: Border.all(color: const Color(0xFF706B6B),width: 5),
                                image: const DecorationImage(
                                  image: AssetImage('assets/png/tianjia.png'),
                                  fit: BoxFit.fill
                                ),
                              ),),
                            ):Container(width: 70,height: 70,decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular((35))),
                              border: Border.all(color: const Color(0xFF706B6B),width: 5),
                            ),),
                            (in_the_team == false) ?const Text('点击加入'):const Text('虚位以待'),
                          ],)
                          ):Container(),
                          /*以上是一个方块组件*/


                          /*以下是一个方块组件*/
                          (predict_num >= 3) ? SizedBox(width: 70,height: 100,child: ( ST>=3 ) ?
                          Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                            Container(width: 70,height: 70,decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular((35))),
                              image: DecorationImage(image: AssetImage('assets/png/帖子.png')),
                            ),),
                            Text(MB[1]['nickname']),
                          ],) : Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [
                              (in_the_team == false) ? GestureDetector(
                                onTap:(){
                                  successfully_joinin = false;
                                  Join_in().then((value) {
                                    if(successfully_joinin==true){
                                      Fluttertoast.showToast(msg: '申请加入成功！');
                                      Obtaindetaildata().then((value) {Navigator.of(context).pop();});
                                    }else{
                                      Fluttertoast.showToast(msg: '申请加入失败！');
                                      Obtaindetaildata();
                                    }
                                  });
                                  print("加入");
                                },
                                child: Container(width: 70,height: 70,decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular((35))),
                                  border: Border.all(color: const Color(0xFF706B6B),width: 5),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/png/tianjia.png'),
                                      fit: BoxFit.fill
                                  ),
                                ),),
                              ):Container(width: 70,height: 70,decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular((35))),
                                border: Border.all(color: const Color(0xFF706B6B),width: 5),
                              ),),
                              (in_the_team == false) ?const Text('点击加入'):const Text('虚位以待'),
                            ],)
                          ):Container(),
                          /*以上是一个方块组件*/


                          /*以下是一个方块组件*/
                          (predict_num >= 4) ? SizedBox(width: 70,height: 100,child: ( ST>=4 ) ?
                          Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                            Container(width: 70,height: 70,decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular((35))),
                              image: DecorationImage(image: AssetImage('assets/png/帖子.png')),
                            ),),
                            Text(MB[1]['nickname']),
                          ],) : Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [
                              (in_the_team == false) ? GestureDetector(
                                onTap:(){
                                  successfully_joinin = false;
                                  Join_in().then((value) {
                                    if(successfully_joinin==true){
                                      Fluttertoast.showToast(msg: '申请加入成功！');
                                      Obtaindetaildata().then((value) {Navigator.of(context).pop();});
                                    }else{
                                      Fluttertoast.showToast(msg: '申请加入失败！');
                                      Obtaindetaildata();
                                    }
                                  });
                                  print("加入");
                                },
                                child: Container(width: 70,height: 70,decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular((35))),
                                  border: Border.all(color: const Color(0xFF706B6B),width: 5),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/png/tianjia.png'),
                                      fit: BoxFit.fill
                                  ),
                                ),),
                              ):Container(width: 70,height: 70,decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular((35))),
                                border: Border.all(color: const Color(0xFF706B6B),width: 5),
                              ),),
                              (in_the_team == false) ?const Text('点击加入'):const Text('虚位以待'),
                            ],)
                          ):Container(),
                          /*以上是一个方块组件*/




                        ],),
                    ),

                  ],),),
                ) : const Center(child: Text('暂无数据！'),)
            );

        }
        else {
            return Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: const CircularProgressIndicator(),
            );
          }
        }

    );



  }

}