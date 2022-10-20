import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/Information_ui/personalInformation.dart';
import 'package:please/detail_tz.dart';

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
  var cjCount=0;
  var sqCount=0;
  List <dynamic> list=[];
  var itemcount = 0;
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
    var data=response.data;
    print(data);
    refuseSuccessfully=data["flag"];
    print(refuseSuccessfully);
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
    print(cancel_Successfully);
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
    if (kDebugMode) {
      print(response);
    }
    Map <String,dynamic> data = response.data;
    list = data["data"];
    print(list);
    itemcount = list.length;
    cjCount=0; sqCount=0;
    print("itemcount:$itemcount");
    for(var i=0 ; i < itemcount ; i++){
      Map<String,dynamic> listdynamic = list[i];
      print(listdynamic);
      if(listdynamic["flag"]==0) cjCount+=1;
      else sqCount+=1;

      TZ.add(listdynamic);
    }
    print('cj$cjCount'); print('sq$sqCount');
    setState(() {

    });
  }
  @override
  void initState(){
    super.initState();
    getpostdata();
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
                      Color(0xFFC8C4DB),
                      Color(0xFFF3F3F3),
                      Color(0xFFF3F3F3),
                    ],
                  ),
                ),
                child: SizedBox(width: width,height: height,child: Column(children: <Widget>[
                  const SizedBox(height: 70,),
                  Container(width: width-70,height: 35,alignment: Alignment.topLeft,child: SizedBox(
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

                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: itemcount,
                      controller: _controller,
                      itemBuilder: (context,i){
                        return (selectItemValue=='我创建的') ?((TZ[i]["flag"]==0) ?((cjCount ==0) ? const SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(child: Text('暂无数据'),),
                        ):Container(
                          height: 180,
                          width: width-50,
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(left:20,top: 20,child: SizedBox(
                                width: width-100,
                                height: 70,

                                child: Row(children: <Widget>[
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                        return PersonalInformation(personId: TZ[i]["userId"],);
                                      }));
                                    },
                                    child: SizedBox(
                                      width: 70, height: 70,
                                      child: ClipOval(
                                        child: (TZ[i]["heading"]=='') ? Image.asset('assets/png/帖子.png') :
                                        Image.network(TZ[i]['heading'],fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                  Expanded(flex:1,child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(height: 7,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                            return PersonalInformation(personId: TZ[i]["userId"],);
                                          }));
                                        },
                                          child: Text('     '+TZ[i]['nickName'],style: const TextStyle(color: Colors.blue,fontSize: 17),)),
                                      const SizedBox(height: 8,),
                                      RichText(
                                        text: TextSpan(
                                            text: '     申请加入您的 ',
                                            style: const TextStyle(color: Color(0xFF635B73),fontSize: 17),
                                            children: [

                                              TextSpan(
                                                  text: ' 拼车队伍',
                                                  style: const TextStyle(color: Colors.indigo,fontSize: 17),
                                                  recognizer: TapGestureRecognizer()..onTap = (){
                                                    print('查看队伍');
                                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                                      var tmp = TZ[i]["teamId"];
                                                      return Detail_tz(postid: '$tmp',);
                                                    }));
                                                  }
                                              ),
                                            ]
                                        ),
                                      ),
                                    ],))
                                ],),
                              )),
                              Positioned(
                                bottom: 15,
                                right: 20,
                                child: SizedBox(
                                    width: 150,
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
                                              getpostdata();
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: '请求失败！');
                                              getpostdata();
                                            }
                                          });
                                        },
                                        child: Container(height: 35, width: 65,
                                          decoration:  const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            //border: Border.all(color: Colors.grey),
                                            color: Color(0xFF5CB85C),
                                            ), child:  const Center(child: Text('同意',style: TextStyle(fontSize: 17,color:Colors.white),),),
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
                                              getpostdata();
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: '请求失败！');
                                              getpostdata();
                                            }
                                          });
                                        },
                                        child: Container(height: 35, width: 65,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            //border: Border.all(color: Colors.grey),
                                            color: Color(0xFFD9534F),
                                            ), child:  const Center(child: Text('拒绝',style: TextStyle(fontSize: 17,color: Colors.white),),),
                                        ),
                                      ),),
                                    ],)
                                        :Stack(children: <Widget>[
                                      Positioned(right:20, child: SizedBox(
                                        height: 40, width: 60,
                                        child: (TZ[i]["state"] == 1) ? const Center(child: Text('已同意',style: TextStyle(fontSize: 17,color: Color(
                                            0xFF5CB85C)),),): (TZ[i]['state']==4) ?(const Center(child: Text('已拒绝',style: TextStyle(fontSize: 17,color: Color(
                                            0xFFD9534F)),),)) : (const Center(child: Text('已取消',style: TextStyle(fontSize: 17,color: Colors.grey),),))
                                      ),),
                                    ],)
                                ),
                              )

                            ],),
                          ),
                        )): Container())
                            : (TZ[i]["flag"]==1 ? ((sqCount==0) ? Container():Container(
                          height: 140,
                          width: width-50,
                          //color: Colors.yellow,
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                  left:20, top: 20,
                                  child: RichText(
                                    text: TextSpan(
                                      text: '申请加入 ',
                                      style: const TextStyle(color: Color(0xFF635B73),fontSize: 17),
                                      children: [
                                        TextSpan(
                                          text: TZ[i]["nickName"],
                                          style: const TextStyle(color: Colors.blue,fontSize: 17),
                                          recognizer: TapGestureRecognizer()..onTap = (){
                                            print('查看个人信息');
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                              var tmp = TZ[i]["leaderId"];
                                              return PersonalInformation(personId: '$tmp',);
                                            }));
                                          }
                                        ),
                                        const TextSpan(
                                          text: ' 的 ',
                                          style: TextStyle(color: Color(0xFF635B73),fontSize: 17),
                                        ),
                                        TextSpan(
                                          text: ' 拼车队伍',
                                          style: const TextStyle(color: Colors.indigo,fontSize: 17),
                                            recognizer: TapGestureRecognizer()..onTap = (){
                                              print('查看队伍');
                                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                                var tmp = TZ[i]["teamId"];
                                                return Detail_tz(postid: '$tmp',);
                                              }));
                                            }
                                        ),
                                      ]
                                    ),
                                  ),),
                              Positioned(
                                right: 25,bottom: 15,
                                child: InkWell(
                                  onTap: (){
                                    if(TZ[i]['state']==0){
                                    if (kDebugMode) {
                                      print('取消申请');
                                    }
                                    cancel_Successfully=false;
                                    nowTeamId = TZ[i]["teamId"].toString();
                                    if (kDebugMode) {
                                      print(nowTeamId);
                                    }
                                    cancelApply().then((value) {
                                      if(TZ[i]['state'] == 3){
                                        Fluttertoast.showToast(msg: '请勿重复申请！');
                                      }
                                      else{
                                        if(cancel_Successfully == true){
                                          Fluttertoast.showToast(msg: '取消申请成功！');
                                          getpostdata();
                                        }
                                        else{
                                          Fluttertoast.showToast(msg: '取消申请失败！');
                                          getpostdata();
                                        }}
                                    });}else{
                                      if (kDebugMode) {
                                        print('无事发生');
                                      }
                                    }
                                  },
                                  child:(TZ[i]['state']==0)?Container(
                                    width: 100,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.grey),
                                      //color: const Color(0xFFD9534F),
                                    ),
                                    child:(const Center(child: Text('取消申请',style: TextStyle(fontSize: 17,color: Color(
                                        0xFFD9534F)),),)),
                                        // (const Center(child: Text('已处理',style: TextStyle(fontSize: 17,color: Color(0xFF635B73)),),)),
                                  ):
                                  SizedBox(
                                    width: 100,
                                    height: 35,
                                    /*
                                    decoration: BoxDecoration(
                                      //borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      //border: Border.all(color: Colors.grey),

                                    ),*/
                                   //child:(const Center(child: Text('已处理',style: TextStyle(fontSize: 17,color: Color(0xFF635B73)),),)),
                                    child: Center(child: (TZ[i]['state']==0)? const Text('正在申请',style: TextStyle(fontSize: 15,color: Color(0xFF635B73)),)
                                        : ((TZ[i]['state']==1) ? const Text('已同意',style: TextStyle(fontSize: 17,color: Color(0xFF5CB85C)),)
                                        : ((TZ[i]['state']==4) ?const Text('已拒绝',style: TextStyle(fontSize: 17,color: Color(0xFFD9534F)),)
                                        : const Text('已取消',style: TextStyle(fontSize: 17,color: Colors.grey)))),)
                                  )
                                ),),
                              /*
                              Positioned(
                                left: 45,
                                bottom: 20,
                                child: (TZ[i]['state']==0)? const Text('正在申请',style: TextStyle(fontSize: 15,color: Color(0xFF635B73)),)
                                    : ((TZ[i]['state']==1) ? const Text('同意',style: TextStyle(fontSize: 15,color: Color(0xFF5CB85C)),)
                                    : ((TZ[i]['state']==4) ?const Text('拒绝',style: TextStyle(fontSize: 15,color: Color(0xFFD9534F)),)
                                    : const Text('已取消',style: TextStyle(fontSize: 15,color: Colors.grey)))
                                ),
                              ),*/
                            ],),
                          ),
                        )):Container());


                      },
                    ),
                  ),
                ],),),
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
                      Color(0xFFC8C4DB),
                      Color(0xFFF3F3F3),
                      Color(0xFFF3F3F3),
                    ],
                  ),
                ),
                child: const Center(child:
                  CircularProgressIndicator(),
                ),
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
