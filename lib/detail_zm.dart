import 'package:flutter/material.dart';

class Detail_zm extends StatefulWidget {
  final postid;
  Detail_zm({Key? key,this.postid}) : super(key: key);

  @override
  _Detail_zmState createState() => _Detail_zmState(postid);
}
class _Detail_zmState extends State<Detail_zm> {
  String? Postid='';
  _Detail_zmState(this.Postid);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('帖子详情',style: TextStyle(color: Colors.black),), centerTitle: true,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){
            print(Postid);
            Navigator.of(context).pop();
          },
        ),),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(height: height,width: width-50,child: Column(children: <Widget>[
          const SizedBox(height: 20,),
          Stack(
            children: <Widget>[SizedBox(height: 44,width: width-50,child: Row(children: <Widget>[
              ///头像的部分
              Container(
                height: 44,width: 44,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),image: DecorationImage(fit: BoxFit.cover,image:AssetImage("assets/png/帖子.png"), )),
              ),
              const SizedBox(width: 10,),
              ///用户名，发布时间
              Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                Text('用户A',style: TextStyle(color: Colors.black,fontSize: 16),),
                Text('2022-01-21 20:22',style: TextStyle(color: Colors.grey),),
              ],)
            ],),),
              Positioned(right: 10,bottom:5,child: Text('剩余0时03分06秒',style: TextStyle(color: Color(0xFFBF544A)),)),
            ],

          ),
          const SizedBox(height: 25,),
          SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
            Container(height: 24,width: 60,decoration: const BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
            Center(child: Text('出发地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
            const SizedBox(width: 5,), Text('天津大学北洋园校区',style: TextStyle(fontSize: 15,),),
          ],),),
          const SizedBox(height: 4,),
          Container(height: 24,width: width-50,child: Row(children: <Widget>[
            Container(height: 24,width: 60,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
            Center(child: Text('目的地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
            const SizedBox(width: 5,), Text('天津大学卫津路校区',style: TextStyle(fontSize: 15,),),
          ],),),
          const SizedBox(height: 4,),
          SizedBox(height: 24,width: width-50,child: Row(children: <Widget>[
            Container(height: 24,width: 75,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
            Center(child: Text('拼车时间',style: TextStyle(fontSize: 15,color: Colors.white),)),),
            const SizedBox(width: 5,), Text('2022年1月25日 16:30',style: TextStyle(fontSize: 15,),),
          ],),),
          SizedBox(height: 4,),
          Container(height: 24,width: width-50,child: Row(children: <Widget>[
            Container(height: 24,width: 40,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
            Center(child: Text('状态',style: TextStyle(fontSize: 15,color: Colors.white),)),),
            SizedBox(width: 5,), Text('当前（1/3）人',style: TextStyle(fontSize: 15,),),
          ],),),
          const SizedBox(height: 4,),
          Container(height: 300,width: width-50,alignment:Alignment.topCenter,child: Row(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
            Container(height: 24,width: 40,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
            Center(child: Text('描述',style: TextStyle(fontSize: 15,color: Colors.white),)),),
            const SizedBox(width: 5,), Expanded(
              child: Text('本人男本人女本人男本人女本人男本人女本人男本人女本人男本人男本人男本人女本人男本人女本人男本人女本人男本人女本人男本人男',style:
              TextStyle(fontSize: 15),),
            ),
          ],),),
          const SizedBox(height: 15,),
          
        ],),),
      ),
    );
  }
}
