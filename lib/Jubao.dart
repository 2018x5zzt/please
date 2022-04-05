import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:please/UserId_global.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JuBao extends StatefulWidget {
  final postid;
  const JuBao({Key? key,this.postid}) : super(key: key);

  @override
  _JuBaoState createState() => _JuBaoState(postid);
}

class _JuBaoState extends State<JuBao> {
  String Postid='';
  _JuBaoState(this.Postid);

  TextEditingController controller = TextEditingController();
  Future SubmitJuBao() async{
    Dio dio = Dio();
    String url = "http://$ST_url/reports";
    Map <String,dynamic> mapp = Map();
    mapp["reporterId"]=UserId_Global;
    mapp["content"]=controller.text;
    mapp["postId"] = Postid;
    //print(mapp);
    Response res = await dio.post(url,data: mapp);
    Map <String,dynamic> zzt = res.data;
    if (kDebugMode) {
      print(zzt["flag"]);
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('举 报',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),
        backgroundColor: const Color(0xFFC8C4DB),
      ),
      body: Container(
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
        height: height,
        width: width,
        child: Stack(children: <Widget>[
          SizedBox(
            width: width,
            height: height,
            child: Row(
              children: <Widget>[
                SizedBox(height: height,width: 25,),
                Column(children: <Widget>[
                  const SizedBox(height: 25,),
                  Container(height: 30,width: width-50,alignment: Alignment.centerLeft,child: Text('举报原因：',style: TextStyle(fontSize: 18,),),),
                  const SizedBox(height: 25,),
                  Container(width: width-50,height: 250,decoration:BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey),),child: TextField(
                    controller: controller,
                    maxLength: 200,
                    maxLines: 15,
                    decoration: const InputDecoration.collapsed(hintText: "请输入举报理由"),
                  ),),
                  const SizedBox(height: 50,),
                  GestureDetector(onTap: (){
                    SubmitJuBao();
                    Fluttertoast.showToast(msg: '举报成功');
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                    child: Container(width: 180,height: 50,
                      decoration: BoxDecoration(color:const Color(0xFFA49BB5),borderRadius: BorderRadius.circular(5),),
                      child: const Center(child: Text('提 交',style: TextStyle(fontSize: 20,color: Colors.white),)),
                    ),),
                ],),
                SizedBox(height: height,width: 25,),
              ],
            ),
          ),
        ],),
      ),
    );
  }
}
