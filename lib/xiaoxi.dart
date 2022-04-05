import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/Information_ui/DialogUtil.dart';
import 'package:please/Information_ui/MyPost.dart';

import 'Information_ui/MyTeam.dart';
import 'UserId_global.dart';
class XiaoXi extends StatefulWidget {
  const XiaoXi ({Key? key}) : super(key: key);

  @override
  _XiaoXiState createState() => _XiaoXiState();
}

class _XiaoXiState extends State<XiaoXi> {
  List <dynamic> list=[];
  var itemcount = 0;
  var sszzt = false;
  ScrollController _controller = ScrollController();
  List <Map<String,dynamic>> TZ=[];

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
  /*
  var ttype=1;
  var cchoose=0;
  var rrefuse = 0;
  */

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('消 息',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          Opacity(opacity: 0.03,child: Container(width: width,height: height,color: Colors.grey,),),
          SizedBox(
            width: width,
            height: height,
            child: Column(children: <Widget>[
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  //print("2");
                },
                child: Container(
                  width: width-50,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1),
                    //color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyPost()));
                        },
                        child: SizedBox(width: 140,height: 50,child: Row(children: <Widget>[
                          const SizedBox(width: 25,),
                          Transform.scale(scale:1.8,child:const ImageIcon(AssetImage('assets/png/帖子.png'),color: Color(0xFFB3ACC1),)),
                          const SizedBox(width: 15,),
                          const Text('我发布的',style: TextStyle(fontSize: 18),),
                        ],),),
                      ),
                      const SizedBox(width: 1,height: 50,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey),),),
                      GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyTeam()));
                          getpostdata();
                          //teamAgree();
                          //showDialogs(context,BaseDialog(title:'提示',content:'确认退出？'));
                        },
                        child: SizedBox(width: 140,height: 50,child: Row(children: <Widget>[
                          const SizedBox(width: 15,),
                          Transform.scale(scale:1.8,child:const ImageIcon(AssetImage('assets/png/招募-1.png'),color: Color(0xFFB3ACC1),)),
                          const SizedBox(width: 15,),
                          const Text('我的队伍',style: TextStyle(fontSize: 18),),
                        ],),),
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
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
                  child: ListView.builder(
                    itemCount: itemcount,
                    controller: _controller,
                    itemBuilder: (context,i){
                      return (TZ[i]["flag"]==0) ?Container(
                        height: 170,
                        width: width-50,
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Stack(children: <Widget>[
                            Positioned(left:20,top: 20,child: Container(
                              width: width-100,
                              height: 70,

                              child: Row(children: <Widget>[
                                Container(
                                  width: 70, height: 70,
                                  child: ClipOval(
                                    child: (TZ[i]["heading"]=='') ? Image.asset('assets/png/帖子.png') :
                                    Image.network(TZ[i]['heading'],fit: BoxFit.cover,),
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/png/帖子.png")),
                                    borderRadius: BorderRadius.circular(43),
                                  ),
                                ),
                                Expanded(flex:1,child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                  const SizedBox(height: 7,),
                                  Text('     '+TZ[i]['nickName'],style: TextStyle(fontSize: 16),),
                                  const SizedBox(height: 8,),
                                  Text('    申请加入您创建的拼车队伍',style: TextStyle(fontSize: 16),)
                                ],))
                              ],),
                            )),
                            Positioned(
                              bottom: 15,
                              right: 20,
                              child: Container(
                                width: 170,
                                height: 40,
                                //color: Colors.yellow,
                                child: (TZ[i]['state'] == 0) ? Stack(children: <Widget>[
                                  Positioned(left: 0, child: InkWell(
                                      onTap: (){
                                        agreeSuccessfully=false;
                                        print('同意');
                                        nowTeamId=TZ[i]["teamId"];
                                        nowMemberId=TZ[i]["userId"];
                                        teamAgree().then((value) {
                                          if(agreeSuccessfully==true){
                                            Fluttertoast.showToast(msg: '已同意！');
                                            sszzt=false;
                                            getpostdata();
                                          }
                                          else{
                                            Fluttertoast.showToast(msg: '请求失败！');
                                            sszzt=false;
                                            getpostdata();
                                          }
                                        });
                                      },
                                      child: Container(height: 40, width: 75,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.grey),), child:  const Center(child: Text('同意',style: TextStyle(fontSize: 17,color: Color(0xFF635B73)),),),
                                      ),
                                    ),),
                                  Positioned(right: 0, child: InkWell(
                                    onTap: (){
                                      refuseSuccessfully=false;
                                      nowMemberId = TZ[i]['userId'];
                                      nowTeamId = TZ[i]['teamId'];
                                      print('拒绝');
                                      teamRefuse().then((value) {
                                        if(refuseSuccessfully==true){
                                          Fluttertoast.showToast(msg: '已拒绝！');
                                          sszzt=false;
                                          getpostdata();
                                        }
                                        else{
                                          Fluttertoast.showToast(msg: '请求失败！');
                                          sszzt=false;
                                          getpostdata();
                                        }
                                      });
                                    },
                                    child: Container(height: 40, width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(color: Colors.grey),), child:  const Center(child: Text('拒绝',style: TextStyle(fontSize: 17,color: Color(0xFF635B73)),),),
                                    ),
                                  ),),
                                ],)
                                    :Stack(children: <Widget>[
                                      Positioned(right:0, child: Container(
                                        height: 40, width: 75,
                                        child: (TZ[i]["state"] == 1) ? const Center(child: Text('已同意',style: TextStyle(fontSize: 17,color: Color(0xFFA49BB5)),),):const Center(child: Text('已拒绝',style: TextStyle(fontSize: 17,color: Color(0xFFA49BB5)),),),
                                      ),),
                                ],)
                              ),
                            )

                          ],),
                        ),
                      ):Container(
                          height: 130,
                          width: width-50,
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                left:20, top: 20
                                  ,
                                  child: Text('加入 '+TZ[i]['nickName']+' 创建的拼车招募队伍',style: TextStyle(fontSize: 16),)),
                              Positioned(
                                right: 25,bottom: 15,
                                  child: InkWell(
                                    onTap: (){
                                      print('取消申请');
                                      cancel_Successfully=false;
                                      nowTeamId = TZ[i]["teamId"].toString();
                                      print(nowTeamId);
                                      cancelApply().then((value) {
                                        if(TZ[i]['state'] == 3){
                                          Fluttertoast.showToast(msg: '请勿重复申请！');
                                        }
                                        else{
                                        if(cancel_Successfully == true){
                                          Fluttertoast.showToast(msg: '取消申请成功！');
                                          sszzt=false;
                                          getpostdata();
                                        }
                                        else{
                                          Fluttertoast.showToast(msg: '取消申请失败！');
                                          sszzt=false;
                                          getpostdata();
                                        }}
                                      });
                                      },
                                    child: Container(
                                      width: 100,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: const Center(child: Text('取消申请',style: TextStyle(fontSize: 17,color: Color(0xFF635B73)),),),
                                    ),
                                  ),),
                              Positioned(
                                left: 45,
                                  bottom: 20,
                                  child: (TZ[i]['state']==0)? const Text('正在申请',style: TextStyle(fontSize: 15,color: Color(0xFF635B73)),)
                                      : ((TZ[i]['state']==1) ? const Text('同意',style: TextStyle(fontSize: 15,color: Color(0xFF635B73)),)
                                      : ((TZ[i]['state']==4) ?const Text('拒绝',style: TextStyle(fontSize: 15,color: Color(0xFF635B73)),)
                                      : const Text('已取消',style: TextStyle(fontSize: 15,color: Color(0xFF635B73))))
                                  ),
                              ),
                            ],),
                          ),
                      );

                    },
                  ),
                ),
              ),
            ],),
          ),
        ],));
  }
}
