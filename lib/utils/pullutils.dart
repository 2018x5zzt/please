import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


typedef PullRefreshCallback = Future<void> Function();


class PullToRefreshListView extends StatefulWidget {

  //item回调方法
  IndexedWidgetBuilder itemBuilder;

  //条目数
  int itemCount;

  //分割线
  Widget separatorView =  LineView(height: 4);

  //刷新回调
  PullRefreshCallback onRefresh;

  //加载更多回调
  PullRefreshCallback onMoreRefresh;

  //是否有下一页
  bool hasMore = true;

  PullToRefreshListView(
      {required this.itemBuilder,required this.itemCount,required this.onRefresh,required this.onMoreRefresh,required this.hasMore});

  PullToRefreshListView.separated(
      {required this.itemBuilder,
        required this.itemCount,required this.separatorView,required this.onRefresh,required this.onMoreRefresh,required this.hasMore});


  @override
  State<StatefulWidget> createState() {
    return ListViewState();
  }

}

class ListViewState extends State<PullToRefreshListView>{

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new ScrollController();
    _controller.addListener(() {

      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if(widget.hasMore)
          widget.onMoreRefresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.separated(
          controller: _controller,
          itemBuilder: (context, index) {
            if (index == widget.itemCount) {
              return widget.hasMore ? LoadMoreView():NoMoreView();
            } else {
              return widget.itemBuilder(context, index);
            }
          },
          separatorBuilder: (context, index) {
            return widget.separatorView;
          },
          itemCount: widget.itemCount+1),
    );
  }
}

class LoadMoreView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 20,height: 20,child: CircularProgressIndicator(strokeWidth: 2)),
          Padding(padding: EdgeInsets.all(10),child: Text("加载中",style: TextStyle(color: Colors.grey,fontSize: 13)))
        ]));
  }

}

class NoMoreView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(
        child: Padding(padding: EdgeInsets.all(2),
            child: Text("到底啦！",style: TextStyle(color: Colors.grey,fontSize: 13)))));
  }

}


class LineView extends StatelessWidget{

  double height;
  LineView({this.height = 10});

  @override
  Widget build(BuildContext context) {
    return  Container(color: Colors.grey[200],height: height);
  }

}
