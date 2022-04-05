// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:please/UserId_global.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: camel_case_types
class Post_post extends StatefulWidget {
  const Post_post({Key? key}) : super(key: key);

  @override
  _Post_postState createState() => _Post_postState();
}

// ignore: camel_case_types
class _Post_postState extends State<Post_post> {
  var sendSuccessfully=false;
  // ignore: non_constant_identifier_names
  var controller_start;
  // ignore: non_constant_identifier_names
  var controller_end;
  // ignore: non_constant_identifier_names
  var controller_decoration;
  // ignore: non_constant_identifier_names
  var controller_people;
  // ignore: non_constant_identifier_names
  var ddate;
  // ignore: non_constant_identifier_names
  var ttime;
  var t_year;
  var t_month;
  var t_day;
  var t_hour;
  var t_minute;
  @override
  void initState(){
    super.initState();
    controller_start=TextEditingController();
    controller_start.addListener((){});
    controller_end=TextEditingController();
    controller_end.addListener((){});
    controller_decoration=TextEditingController();
    controller_decoration.addListener((){});
    controller_people=TextEditingController();
    controller_people.addListener((){});
  }
  Future<void> Send_post() async{
    Dio dio = Dio();
    var ssstmp = controller_people.text;
    var ssTmp = int.parse(ssstmp);
    String url = "http://$ST_url/posts";
    Map<String,dynamic> mapp = {};
    mapp["content"] = controller_decoration.text;
    mapp["posterId"] = UserId_Global;
    mapp["startLocation"] = controller_start.text;
    mapp["destination"] = controller_end.text;
    mapp["year"] = t_year;
    mapp["month"] = t_month;
    mapp["day"] = t_day;
    mapp["hour"] = t_hour;
    mapp["minute"] = t_minute;
    mapp["flag"] = 0;
    mapp['heading']=User_heading;
    //mapp["teamNumber"] = ss_tmp;
    mapp["posterName"] = User_Nickname;
    Map <String,dynamic> mmmappp = {};
    mmmappp["teamNumber"] =ssTmp;
    if (kDebugMode) {
      print(mapp);
    }
    try{
      Response response = await dio.post(url,data: mapp,queryParameters: mmmappp);
      if (kDebugMode) {
        print(response);
      }
      sendSuccessfully=response.data["flag"];
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      sendSuccessfully =false;
    }

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
        title: const Text('创建帖子',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop('refresh');},
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              if(controller_start.text==''||controller_end.text==''||controller_people==''||ddate.toString()==''||ttime.toString()==''||controller_decoration.text.toString()=='') {
                  Fluttertoast.showToast(msg: '请完善信息！');
                }else{
                sendSuccessfully=false;
              Send_post().then((value) {
                if(sendSuccessfully==true)  {
                  Fluttertoast.showToast(msg: '发帖成功！');
                  Navigator.of(context).pop('refresh');
                }
                else {
                  Fluttertoast.showToast(msg: '发帖失败');
                }
              });
              //print('发送创建帖子请求');
            }},
            icon:const ImageIcon(AssetImage('assets/png/wancheng.png'),color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(height: height,width: width-50,child: Column(mainAxisAlignment:MainAxisAlignment.start,children: <Widget>[
            const SizedBox(height: 16,),
            SizedBox(height: 24,width: width-50,child: const Text('出发地',style: TextStyle(fontSize: 18),),),
            TextField(controller:controller_start,decoration: const InputDecoration(hintText: '请输入出发地',),maxLength: 15,),
            const SizedBox(height: 3,),
            SizedBox(height: 24,width: width-50,child: const Text('目的地',style: TextStyle(fontSize: 18),),),
            TextField(controller:controller_end, decoration: const InputDecoration(hintText: '请输入目的地',),maxLength: 15,),
            const SizedBox(height: 3,),
            SizedBox(height: 24,width: width-50,child: const Text('拼车人数',style: TextStyle(fontSize: 18),),),
            TextField(controller:controller_people, maxLength: 1,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[2-4]"))],
                decoration: const InputDecoration(
                  hintText: '请输入人数(2-4，包括自己哟)',
            )),
            const SizedBox(height: 3,),
            SizedBox(height: 24,width: width-50,child: const Text('拼车日期',style: TextStyle(fontSize: 18),),),
            DateTimePicker(
              initialValue: '',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onChanged: (val) {
                ddate=val.toString();
                //rint(ddate);
                String tYearnew=ddate.substring(0,4);
                t_year=int.parse(tYearnew);
                //print(t_year);
                String tMonthnew=ddate.substring(5,7);
                t_month=int.parse(tMonthnew);
                //print(t_month);
                String tDaynew = ddate.substring(8,10);
                t_day = int.parse(tDaynew);
                //print(t_day);
                },
            ),
            const SizedBox(height: 12,),
            SizedBox(height: 24,width: width-50,child: const Text('拼车时间',style: TextStyle(fontSize: 18),),),
            DateTimePicker(
              type: DateTimePickerType.time,
              initialValue: '',
              firstDate: DateTime(2022),
              lastDate: DateTime(2023),
              onChanged: (val) {
                ttime=val.toString();
                //print(ttime);
                String tHournew=ttime.substring(0,2);
                t_hour =  int.parse(tHournew);
                //print(t_hour);
                String tMinutenew = ttime.substring(3,5);
                t_minute = int.parse(tMinutenew);
                //print(t_minute);
                },
            ),
            const SizedBox(height: 12,),
            SizedBox(height: 24,width: width-50,child: const Text('描述',style: TextStyle(fontSize: 18),),),
            const SizedBox(height: 12,),
            Container(width: width-50,height: 150,decoration:BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey),),child: TextField(
              controller: controller_decoration,
              maxLines: 15,
              maxLength: 200,
              decoration: const InputDecoration.collapsed(hintText: "请输入描述"),
            ),),
          ],),),
        ),
      ),
    );
  }
}
