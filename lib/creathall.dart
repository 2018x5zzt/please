
import 'package:flutter/material.dart';
import 'package:please/hall_tz.dart';
import 'package:please/hall_zm.dart';

class CreateHall extends StatefulWidget {
  const CreateHall({Key? key}) : super(key: key);

  @override
  _CreateHallState createState() => _CreateHallState();
}

class _CreateHallState extends State<CreateHall> {
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Transform.scale(scale: 1,child: const ImageIcon(AssetImage("assets/png/tiezidating.png")),),
      label: "帖子大厅",
    ),
    BottomNavigationBarItem(
      icon: Transform.scale(scale: 1,child: const ImageIcon(AssetImage("assets/png/zhaomudating.png")),),
      label: "招募大厅",
    ),
  ];

  int current_Index = 0;

  final pages = [CallHall(),PostHall()];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: current_Index,
        onTap: (index) {
          _changePage(index);
        },
        selectedItemColor: Color(0xFF7D7291),
        unselectedItemColor: const Color(0xffb3acc1),
      ),

      body:pages[current_Index],

    );
  }
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != current_Index) {
      setState(() {
        current_Index = index;
      });
    }
  }
}
