/// id : 30214141
/// nickname : "yr"
/// gender : "M"
/// qq : 1840543823
/// wechat : 12345
/// pwd : 12345
/// major : "智造"
/// campus : "x"
/// heading : "yr.jpg"

class BaseData {
  BaseData({

    String id='',
    String nickname='',
    String gender='',
    String? qq,
    String? wechat,
    String pwd='',
    String? major,
    String campus='',
    String heading='',}){
    _id = id;
    _nickname = nickname;
    _gender = gender;
    _qq = qq;
    _wechat = wechat;
    _pwd = pwd;
    _major = major;
    _campus = campus;
    _heading = heading;
}

  BaseData.fromJson(Map<String,dynamic> json) {
    _id = json['id'];
    _nickname = json['nickname'];
    _gender = json['gender'];
    _qq = json['qq'];
    _wechat = json['wechat'];
    _pwd = json['pwd'];
    _major = json['major'];
    _campus = json['campus'];
    _heading = json['heading'];
  }
  late String _id;
  late String _nickname;
  late String _gender;
  String? _qq;
  String? _wechat;
  late String _pwd;
  String? _major;
  late String _campus;
  late String _heading;

  String get id => _id;
  String get nickname => _nickname;
  String get gender => _gender;
  String? get qq => _qq;
  String? get wechat => _wechat;
  String get pwd => _pwd;
  String? get major => _major;
  String get campus => _campus;
  String get heading => _heading;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nickname'] = _nickname;
    map['gender'] = _gender;
    map['qq'] = _qq;
    map['wechat'] = _wechat;
    map['pwd'] = _pwd;
    map['major'] = _major;
    map['campus'] = _campus;
    map['heading'] = _heading;
    return map;
  }

}