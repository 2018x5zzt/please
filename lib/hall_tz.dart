
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:please/detail_tz.dart';
import 'package:please/postpost.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'UserId_global.dart';

class CallHall extends StatefulWidget {
  const CallHall({Key? key}) : super(key: key);

  @override
  _CallHallState createState() => _CallHallState();
}

var itemcount = 0;
var sszzt = false;
var controller_search;
class _CallHallState extends State<CallHall> {
  List <dynamic> list=[];
  List <Map<String,dynamic>> TZ=[];
  ScrollController _controller = ScrollController();

  @override
  Future <void> search_zzt() async{
    print("search");
    bool zzzz=false;
    Dio dio = Dio();
    String url='';
    var con = controller_search.text;
    if(con==''){
      if (kDebugMode) {
        print('空');
      }
      getpostdata();
    }else{
      if(selectItemValue == '出发地'){
        if (kDebugMode) {
          print('出发地');
        }
        url = 'http://$ST_url/posts/search/startlocation/$con';

      }else if(selectItemValue == '目的地'){
        if (kDebugMode) {
          print('目的地');
        }
        url = 'http://$ST_url/posts/search/destination/$con';

      }else if(selectItemValue == '发起人'){
        if (kDebugMode) {
          print('发起人');
        }
        url = 'http://$ST_url/posts/search/poster/$con';

      }else if(selectItemValue == '描述'){
        if (kDebugMode) {
          print('描述');
        }
        url = 'http://$ST_url/posts/search/content/$con';

      }else{
        if (kDebugMode) {
          print('其他');
        }
        zzzz=true;
        getpostdata();
    }
      if(zzzz==false){
        TZ.clear();
        //print(url);
        Response response = await dio.get(url);
        list.clear();
        Map <String,dynamic> data = response.data;
        list = data["data"];
        //print(itemcount);
        if(sszzt == false) {
          itemcount = (list.length > 10) ? 10 : list.length;
          sszzt=true;
        }

        for(var i=0 ; i < itemcount ; i++){
          Map<String,dynamic> listdynamic = list[i];
          TZ.add(listdynamic);
        }
      }
      setState(() {});
    }

  }

  @override
  Future <void> getpostdata() async{
    print("post");
    TZ.clear();
    Dio dio = Dio();
    String url = "http://$ST_url/posts/flag/0";
    Response response = await dio.get(url);
    list.clear();
    //print(response);
    Map <String,dynamic> data = response.data;
    list = data["data"];

    if(sszzt == false) {
      itemcount = (list.length > 10) ? 10 : list.length;
      sszzt=true;
      }
    //print(list[1]);
    TZ = [];
    for(var i=0 ; i < itemcount ; i++){
      Map<String,dynamic> listdynamic = list[i];
      TZ.add(listdynamic);
    }
    setState(() {

    });
  }

  @override
  void initState(){
    //print('initstate');
    sszzt=false;
    super.initState();
    getpostdata();
    controller_search = TextEditingController();
    controller_search.addListener((){});
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  Future<Null> _loadMoreData(){

    return Future.delayed(Duration(seconds: 1),(){
      if(mounted){
        itemcount = (list.length > itemcount + 5) ? itemcount+5 : list.length;
        //print('加载更多,$itemcount');
        search_zzt();
      }
    });
  }
  String selectItemValue='目的地';
  List<String> items =[
    '出发地','目的地','发起人','描述'
  ];

String Deal_time(String ttt){

  return ttt.substring(0,19);
}
  @override
  Widget build(BuildContext context) {

    //print('start to build');

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('拼车',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              //print('创建帖子');
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => Post_post()
              )).then((value) {
                print('你好');
                getpostdata();
              });
            },
            icon:const ImageIcon(AssetImage('assets/png/fatie.png'),color: Color(0xffb3acc1),),
          )
        ],
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(children: <Widget>[
          SizedBox(
            width: width,
            height: 80,

            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(opacity: 0.1,child: Container(width: width,height: 80,color: Colors.grey,),),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  height: 40,
                  width: width-50,
                  child: Stack(children: <Widget>[
                    Positioned(
                        left: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            //color: Colors.yellow,
                          ),
                          height: 40,
                          width: 100,
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                items: items
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                value: selectItemValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectItemValue = value as String;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: 140,
                                itemHeight: 40,
                              ),
                            ),
                          ),
                        ),
                    ),
                    ///上面这个是左边的搜索选项
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          sszzt=false;
                          search_zzt();
                          if (kDebugMode) {
                            print('搜索');
                          }
                          },
                        child: Container(
                          height: 40,
                          width: 60,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Color(0xFFB3ACC1),),
                          child: Transform.scale(scale:0.6,child: const ImageIcon(AssetImage('assets/png/sousuo.png'),color: Colors.white,)),
                        ),
                      ),
                    ),
                    ///这里是右边的搜索按钮
                    Positioned(
                      left: 100,
                      child: SizedBox(
                        width: 180,
                        height: 35,
                        child: TextField(
                          controller: controller_search,
                          onChanged: (text){
                            if(text==''){
                              sszzt=false;
                              if (kDebugMode) {
                                print('清空');
                              }
                              getpostdata();
                            }
                          },
                          decoration: const InputDecoration(
                            //border: OutlineInputBorder()
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    ///中间的输入框
                  ],),
                ),
              ],
            ),
          ),
          ///上面都是搜索部分
          const Divider(height: 1,indent: 0,color: Colors.grey,),
          Expanded(
            child: Stack(children: <Widget>[
              Opacity(opacity: 0.1,child: Container(width: width,height: height,color: Colors.grey,),),
              Container(
                constraints: BoxConstraints(maxHeight: height),
                child: RefreshIndicator(
                  onRefresh: () async {
                    if(mounted){
                      //print('start to refresh');
                      Future.delayed(const Duration(seconds: 1),(){
                        search_zzt();
                        //getpostdata();
                        setState(() {
                          itemcount = (list.length > 10) ? 10 : list.length;
                        });

                      });
                      //print('finish refresh');
                    }
                  },
                  //list.isNotEmpty ?ListView.builder(
                  child: list.isNotEmpty ?ListView.builder(
                    itemCount: itemcount,
                    controller: _controller,
                    ///每个帖子预览图
                    itemBuilder: (context,i){
                      return Container(
                        height: 200,
                        width: width,
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (){
                            //print('这个是第$i');
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                              var tmp = TZ[i]["id"];
                              return Detail_tz(postid: '$tmp',);
                            }));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Center(child: SizedBox(height: 160,width: width-50,child: Column(children: <Widget>[
                              SizedBox(height: 40,width: width-50,child: Row(children: <Widget>[
                                ///头像的部分
                                Container(
                                  height: 40,width: 40,
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),image: DecorationImage(fit: BoxFit.cover,image:AssetImage("assets/png/帖子.png"), )),
                                ),
                                const SizedBox(width: 10,),
                                ///用户名，发布时间
                                Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                                  Text(TZ[i]["posterName"],style: const TextStyle(color: Colors.black,fontSize: 16),),
                                  Text(TZ[i]["postTime"],style: const TextStyle(color: Colors.grey),),
                                ],)
                              ],),),
                              const SizedBox(height: 5,),
                              SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 60,decoration: const BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                const Center(child: Text('出发地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                const SizedBox(width: 5,), Text(TZ[i]["startLocation"],style: const TextStyle(fontSize: 15,),),
                              ],),),
                              const SizedBox(height: 4,),
                              SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 60,decoration: const BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                const Center(child: Text('目的地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                const SizedBox(width: 5,), Text(TZ[i]["destination"],style: const TextStyle(fontSize: 15,),),
                              ],),),
                              const SizedBox(height: 4,),
                              SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 75,decoration: const BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                const Center(child: Text('拼车时间',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                const SizedBox(width: 5,), Text(TZ[i]["year"].toString()+'年'+TZ[i]["month"].toString()+'月'+TZ[i]["day"].toString()+'日 '+TZ[i]["hour"].toString()+':'+TZ[i]["minute"].toString(),style: const TextStyle(fontSize: 15,),),
                              ],),),
                              const SizedBox(height: 4,),
                              Stack(
                                children: <Widget>[
                                  SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
                                    Container(height: 24,width: 40,decoration: const BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                    const Center(child: Text('描述',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                    const SizedBox(width: 5,), SizedBox(width: width-100,height: 24,child: Text(TZ[i]["content"],style:
                                    const TextStyle(fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                                  ],),),

                                  //Positioned(right:0,child: Text(Deal_time(TZ[i]["deadTime"]))),
                                ],
                              ),

                            ],),),),
                          ),
                        ),
                      );
                    }

                  ): Center(child: SizedBox(height: 200,width: width-200,child: const Center(child: Text('暂无数据！'),),)),
                ),
              ),
            ],),
          )
        ],),
      ),
    );
  }
}

