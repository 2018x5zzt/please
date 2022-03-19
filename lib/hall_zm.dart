import 'package:flutter/material.dart';
import 'package:please/utils/SmallPostUtils.dart';
import 'package:please/detail_zm.dart';

class PostHall extends StatefulWidget {
  const PostHall({Key? key}) : super(key: key);

  @override
  _PostHallState createState() => _PostHallState();
}
var itemcount = 10;
class _PostHallState extends State<PostHall> {
  late List <BaseData> list;
  ScrollController _controller = ScrollController();
  @override
  void initState(){
    super.initState();
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  Future<Null> _loadMoreData(){
    return Future.delayed(Duration(seconds: 1),(){
      if(mounted){
        setState(() {
          print('加载更多');
          itemcount+=5;
        });
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
        title: const Text('拼车',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();},
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon:const ImageIcon(AssetImage('assets/png/fatie.png'),color: Color(0xffb3acc1),),
          )
        ],
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(children: <Widget>[
          Container(
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
                      right: 0,
                      child: GestureDetector(
                        onTap: (){print('搜索');},
                        child: Container(
                          height: 40,
                          width: 60,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Color(0xFFB3ACC1),),
                          child: Transform.scale(scale:0.6,child: const ImageIcon(AssetImage('assets/png/sousuo.png'),color: Colors.white,)),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 20,
                      child: SizedBox(
                        width: 270,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],),
                ),
              ],
            ),
          ),
          ///上面都是搜索部分
          Divider(height: 1,indent: 0,color: Colors.grey,),
          Expanded(
            child: Stack(children: <Widget>[
              Opacity(opacity: 0.1,child: Container(width: width,height: height,color: Colors.grey,),),
              Container(
                constraints: BoxConstraints(maxHeight: height),
                child: RefreshIndicator(
                  onRefresh: () async {
                    Future.delayed(Duration(seconds: 2),(){
                      setState(() {
                        itemcount = 10 ;
                      });
                    });
                  },
                  child: ListView.builder(
                    itemCount: itemcount,
                    controller: _controller,
                    ///每个帖子预览图
                    itemBuilder: (context,i) => Container(
                      height: 250,
                      width: width,
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: (){
                          print('这个是第$i');
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return Detail_zm(postid: '$i',);
                          }));
                        },
                        child: Stack(
                          children: [
                            Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Center(child: SizedBox(height: 210,width: width-50,child: Column(children: <Widget>[
                              Container(height: 40,width: width-50,child: Row(children: <Widget>[
                                ///头像的部分
                                Container(
                                  height: 40,width: 40,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),image: DecorationImage(fit: BoxFit.cover,image:AssetImage("assets/png/帖子.png"), )),
                                ),
                                SizedBox(width: 10,),
                                ///用户名，发布时间
                                Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                                  Text('用户A',style: TextStyle(color: Colors.black,fontSize: 16),),
                                  Text('2022-01-21 20:22',style: TextStyle(color: Colors.grey),),
                                ],)
                              ],),),
                              SizedBox(height: 5,),
                              Container(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 60,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                Center(child: Text('出发地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                SizedBox(width: 5,), Text('天津大学北洋园校区',style: TextStyle(fontSize: 15,),),
                              ],),),
                              SizedBox(height: 4,),
                              Container(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 60,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                Center(child: Text('目的地',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                SizedBox(width: 5,), Text('天津大学卫津路校区',style: TextStyle(fontSize: 15,),),
                              ],),),
                              SizedBox(height: 4,),
                              Container(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 75,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                Center(child: Text('拼车时间',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                SizedBox(width: 5,), Text('2022年1月25日 16:30',style: TextStyle(fontSize: 15,),),
                              ],),),
                              SizedBox(height: 4,),
                              Container(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 40,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                Center(child: Text('状态',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                SizedBox(width: 5,), Text('当前（1/3）人',style: TextStyle(fontSize: 15,),),
                              ],),),
                              SizedBox(height: 4,),
                              Container(height: 24,width: width-50,child: Row(children: <Widget>[
                                Container(height: 24,width: 40,decoration: BoxDecoration(color: Color(0xFFA49BB5),borderRadius: BorderRadius.all(Radius.circular(5)),),child:
                                Center(child: Text('描述',style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                SizedBox(width: 5,), Container(width: width-100,height: 24,child: Text('本人男本人女本人男本人女本人男本人女本人男本人女本人男本人男本人男本人女本人男本人女本人男本人女本人男本人女本人男本人男',style:
                                TextStyle(fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                              ],),),
                            ],),),),
                          ),
                            Positioned(right:25, bottom:15,child: Text('剩余0时3分06秒',style: TextStyle(color: Color(0xFFBF544A)),))
                          ],

                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],),
          )
        ],),
      ),
    );
  }
}
