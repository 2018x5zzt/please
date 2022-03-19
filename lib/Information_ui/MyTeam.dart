import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../UserId_global.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({Key? key}) : super(key: key);

  @override
  _MyTeamState createState() => _MyTeamState();
}
Future <void> Teamaboutme() async{
  Dio dio = Dio();
  String  url = "http://$ST_url/teams/myTeam/$UserId_Global";
  Response response = await dio.get(url);
  print(response);

}
class _MyTeamState extends State<MyTeam> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return FutureBuilder(
      future: Teamaboutme(),
        builder:(BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text('我的队伍',style: TextStyle(color: Colors.black),),
                centerTitle: true,
                leading: IconButton(
                  icon: const ImageIcon(AssetImage('assets/png/返回.png'),color: Colors.black,),
                  onPressed: (){Navigator.of(context).pop();},
                ),
              ),
              body: Container(child: Center(child: Text('守护全世界最好的嘉然小姐'),),),
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
