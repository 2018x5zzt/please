import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:please/Information_ui/New_Xiaoxi.dart';
import 'package:please/gerenzhongxin.dart';
import 'package:please/shouye.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RootState();
  }
}

class _RootState extends State<RootPage> {
  DateTime? lastPopTime;
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Transform.scale(scale: 1,child: const ImageIcon(AssetImage("assets/png/首页.png")),),
      label: "首页",
    ),
    BottomNavigationBarItem(
      icon: Transform.scale(scale: 1,child: const ImageIcon(AssetImage("assets/png/站内消息.png")),),
      label: "消息",
    ),
    BottomNavigationBarItem(
      icon: Transform.scale(scale: 1,child: const ImageIcon(AssetImage("assets/png/我的2.png")),),
      label: "个人中心",
    ),
  ];

  int currentIndex = 0;

  final pages = [ShouYe(),NewXiaoxi(),geRenZhongXin.geRen_zhongXin()];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
          onTap: (index) {
            _changePage(index);
          },
        ),
        body: pages[currentIndex],

      ),
      onWillPop: () async {
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime!) >
                const Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          Fluttertoast.showToast(msg: '再按一次退出!');
          return false;
        } else {
          lastPopTime = DateTime.now();
          return await SystemChannels.platform
              .invokeMethod('SystemNavigator.pop');
        }
      },
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
