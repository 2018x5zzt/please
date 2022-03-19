import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../UserId_global.dart';

class NewXiaoxi extends StatefulWidget {
  const NewXiaoxi({Key? key}) : super(key: key);

  @override
  State<NewXiaoxi> createState() => _NewXiaoxiState();
}
List<String> items =[
  '我创建的','我申请的'
];
Future <void> getPostData() async{

}
class _NewXiaoxiState extends State<NewXiaoxi> {
  List <dynamic> list=[];
  var itemcount = 0;
  var sszzt = false;
  ScrollController _controller = ScrollController();
  List <Map<String,dynamic>> TZ=[];
  String selectItemValue = '我创建的';
  String nowTeamId = '';
  String nowMemberId = '';
  var agreeSuccessfully=false;
  Future <void> teamAgree()async{
    Dio dio =Dio();
    String url = 'http://$ST_url/teams/join';
    Map <String,dynamic> mapp=Map();
    mapp["teamId"] = nowTeamId;
    mapp["memberId"] = nowMemberId;
    print("点击队伍同意");
    print(mapp);
    Response response = await dio.post(url,data: mapp);
    var data=response.data;
    agreeSuccessfully = data["flag"];
    print(agreeSuccessfully);
    getpostdata();
  }

  var refuseSuccessfully=false;
  Future <void> teamRefuse() async{
    Dio dio =Dio();
    String url = 'http://$ST_url/teams/refuse';
    Map <String,dynamic> mapp=Map();
    mapp["userId"] = nowMemberId;
    mapp["teamId"] = nowTeamId;
    print('点击队伍拒绝');
    print(mapp);
    Response response = await dio.post(url,data: mapp);
    print(response);
    getpostdata();
  }
  var cancel_Successfully = false;
  Future <void> cancelApply() async{
    Dio dio = Dio();
    String url = 'http://$ST_url/teams/cancel/$nowTeamId/$UserId_Global';
    print(url);
    Response response = await dio.post(url);
    print(response);
    var data = response.data;
    cancel_Successfully = data["flag"];
    getpostdata();
  }



  @override
  Future <void> getpostdata() async{
    TZ.clear();
    list.clear();
    Dio dio = Dio();
    //print('hello');
    String url = "http://$ST_url/teams/message/$UserId_Global";
    Response response = await dio.get(url);
    print(response);
    Map <String,dynamic> data = response.data;
    list = data["data"];
    print(list);
    if(sszzt == false) {
      itemcount = (list.length > 10) ? 10 : list.length;
      sszzt=true;
    }
    print("itemcount:$itemcount");
    for(var i=0 ; i < itemcount ; i++){
      Map<String,dynamic> listdynamic = list[i];
      print(listdynamic);
      TZ.add(listdynamic);
    }
    setState(() {

    });
  }
  @override
  void initState(){
    super.initState();
    sszzt=false;
    getpostdata();
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }
  Future<Null> _loadMoreData(){
    return Future.delayed(const Duration(seconds: 1),(){
      if(mounted){
        itemcount = (list.length > itemcount + 5) ? itemcount+5 : list.length;
        getpostdata();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return FutureBuilder(
        future: getPostData(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(

              body: Container(height: height,width: width,
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
                  const SizedBox(width: 35,),
                  Container(width: width-70,height: height,child: Column(children: <Widget>[
                    const SizedBox(height: 70,),
                    Container(width: width-70,height: 35,alignment: Alignment.topLeft,child: Container(
                      width: 100, height: 35,
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
                                    fontWeight: FontWeight.bold,
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
                          buttonHeight: 100,
                          buttonWidth:100,
                          itemHeight: 50,
                        ),
                      ),
                    ),),
                    SizedBox(width: width-70,height: 30),
                    Expanded(
                      flex: 1,
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
                          child: Container(
                            child: ListView.builder(
                              itemCount: itemcount,
                              controller: _controller,
                              itemBuilder: (context,i){
                                  return (selectItemValue=='我创建的') ?
                                  (TZ[i]["flag"]==0) ?
                                  Container(height:300,child: Column(children: <Widget>[
                                    Container(width: width-70,height: 280,padding: EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),

                                      child: Column(children: <Widget>[
                                        const SizedBox(height: 10,),
                                        Container(height: 35,width: width-90,
                                        child: Stack(children: <Widget>[
                                          Positioned(left: 0,child: Container(width: 100,height: 35,color: Colors.purple,),),
                                          Align(alignment: const Alignment(0,0),child: Transform.scale(scale: 3,child: const ImageIcon(AssetImage('assets/png/jiantou.png'),color: Color(
                                              0xe37d5f96)),),),
                                          Positioned(right: 0,child: Container(width: 100,height: 35,color: Colors.purple,),),
                                        ],),
                                        ),
                                      ],),
                                    ),
                                    SizedBox(height: 20,),
                                  ],),) :Container()
                                      :Container(width:20,height:20,color: Colors.purple,);
                              },
                            ),
                          ),
                        ),),
                  ],),),
                  const SizedBox(width: 35,),
                ],),
              ),
            );
          }else{
            return Scaffold(
              body: Container(
                height: height,
                width: width,
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
                child: const Center(child: CircularProgressIndicator(),),
              ),
            );
          }
    },
    );
      /*Scaffold(
      body: Container(height: height,width: width,
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
        const SizedBox(width: 35,),
        Container(width: width-70,height: height,child: ,),
        const SizedBox(width: 35,),
      ],),
      ),
    );*/
  }
}
