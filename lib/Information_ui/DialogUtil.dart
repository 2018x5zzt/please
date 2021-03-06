import 'package:flutter/material.dart';
class BaseDialog extends StatefulWidget {
  final String title;
  final String content;
  final bool cancelAble;
  final Function confirmCallback; // 点击确定按钮回调
  final Function cancelCallback; // 点击取消按钮
  final Function dismissCallback; // 弹窗关闭回调

  BaseDialog(
      {Key? key, this.title = "",
        this.content = "",
        this.cancelAble = true,
        required this.confirmCallback,
        required this.cancelCallback,
        required this.dismissCallback}) : super(key: key);

  @override
  _BaseDialogState createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    // 设置弹框的宽度为屏幕宽度的86%
    var _dialogWidth = MediaQuery.of(context).size.width * 0.86;

    // 构建弹框内容
    Container _dialogContent = Container(
      decoration: const ShapeDecoration(
        color: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
      ),
      child: Column(
        // 主轴对齐方向
        mainAxisAlignment: MainAxisAlignment.center,
        // 另一个轴对齐方向
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              widget.title == "" ? "标题" : widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w300),
            ),
          ),
          // 内容
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 12, 0, 0),
            child: Text(
              widget.content == "" ? "内容" : widget.content,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          // 按钮
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: _clickCancel,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(146, 26, 0, 0),
                  child: Text(
                    "取消",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _clickConfirm,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(52, 26, 0, 0),
                  child: Text(
                    "确定",
                    style: TextStyle(
                      color: Color.fromRGBO(233, 87, 14, 1),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );

    // 构建弹框布局
    return WillPopScope(
        child: GestureDetector(
          onTap: () => {widget.cancelAble ? _dismissDialog() : null},
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              //保证控件居中效果
              child: SizedBox(
                // 设置弹框宽度
                width: _dialogWidth,
                height: 186.0,
                child: _dialogContent,
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return widget.cancelAble;
        });
  }

  /// 点击隐藏dialog
  _dismissDialog() {
    if (widget.dismissCallback != 'null') {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  /// 点击取消
  void _clickCancel() {
    if (widget.confirmCallback != null) {
      widget.confirmCallback();
    }
    _dismissDialog();
  }

  /// 点击确定
  void _clickConfirm() {
    if (widget.confirmCallback != null) {
      widget.confirmCallback();
    }
    _dismissDialog();
  }
}
