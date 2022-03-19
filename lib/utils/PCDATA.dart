///{"id":5,"postTime":"2022-02-28","content":"22334\n","posterId":"3021210045",
///"startLocation":"12","destination":"21","posterName":"r","year":2022,"month":2,
///"day":18,"hour":8,"minute":32,"teamId":1,"flag":0}

/// id : 5
/// postTime : 2022-02-28
/// content : 22334\n
/// posterId : "3021210045"
/// startLocation : "12"
/// destination : 21
/// posterName : r
/// year : 2022
/// month : "2"
/// day : "18"
/// hour : "8"
/// minute : "32"
/// teamId : "1"
/// flag : "0"

class PcData {
  PcData({

    String id='',
    String postTime='',
    String? content,
    String posterId = '',
    String startLocation='',
    String destination='',
    String posterName='',
    String year = '',
    String month = '',
    String day = '',
    String hour = '',
    String minute = '',
    String teamId = '',
    String flag='',}){
    _id = id;
    _postTime = postTime;
    _content = content;
    _posterId = posterId;
    _startLocation = startLocation;
    _destination = destination;
    _posterName = posterName;
    _year = year;
    _month = month;
    _day = day;
    _hour = hour;
    _minute = minute;
    _teamId = teamId;
    _flag = flag;
  }

  PcData.fromJson(Map<String,dynamic> json) {
    _id = json['id'];
    _postTime = json['postTime'];
    _content = json['content'];
    _posterId = json['posterId'];
    _startLocation = json['startLocation'];
    _destination = json['destination'];
    _posterName = json['posterName'];
    _year = json['year'];
    _month = json['month'];
    _day = json['day'];
    _hour = json['hour'];
    _minute = json['minute'];
    _teamId = json['teamId'];
    _flag = json['flag'];
  }
  late String _id;
  late String _postTime;
  String? _content;
  late String _posterId;
  late String _startLocation;
  late String _destination;
  late String _posterName;
  late String _year;
  late String _month;
  late String _day ;
  late String _hour ;
  late String _minute ;
  late String _teamId;
  late String _flag;



  String get id => _id;
  String get postTime => _postTime;
  String? get content => _content;
  String get posterId => _posterId;
  String get startLocation => _startLocation;
  String get destination => _destination;
  String get posterName => _posterName;
  String get year => _year;
  String get month => _month;
  String get day => _day;
  String get hour => _hour;
  String get minute => _minute;
  String get teamId => _teamId;
  String get flag => _flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['postTime'] = _postTime;
    map['content'] = _content;
    map['posterId'] = _posterId;
    map['startLocation'] = _startLocation;
    map['destination'] = _destination;
    map['posterName'] = _posterName;
    map['year'] = _year;
    map['month'] = _month;
    map['day'] = _day;
    map['hour'] = _hour;
    map['minute'] = _minute;
    map['teamId'] = _teamId;
    map['flag'] = _flag;

    return map;
  }

}