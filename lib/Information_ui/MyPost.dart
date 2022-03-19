import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:please/UserId_global.dart';
import 'package:please/detail_tz.dart';
import 'package:please/postpost.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  _MyPostState createState() => _MyPostState();
}

var itemcount = 0;
var sszzt = false;

class _MyPostState extends State<MyPost> {
  List <dynamic> list=[];
  List <Map<String,dynamic>> TZ=[];
  ScrollController _controller = ScrollController();

  @override
  Future <void> getpostdata() async{
    TZ.clear();
    Dio dio = Dio();
    String url = "http://$ST_url/posts/search/poster/$UserId_Global";
    Response response = await dio.get(url);
    list.clear();
    Map <String,dynamic> data = response.data;
    list = data["data"];
    if(sszzt == false) {
      itemcount = (list.length > 10) ? 10 : list.length;
      sszzt=true;
    }
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
    super.initState();
    getpostdata();
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
        getpostdata();
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('我发布的',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(children: <Widget>[
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
                        getpostdata();
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
                                SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
                                  Container(height: 24,width: 40,decoration: const BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                  const Center(child: Text('描述',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                  const SizedBox(width: 5,), SizedBox(width: width-100,height: 24,child: Text(TZ[i]["content"],style:
                                  const TextStyle(fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                                ],),),
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

