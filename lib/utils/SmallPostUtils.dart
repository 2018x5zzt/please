class BaseData{
  int? id;
  String? nickname;
  String? gender;
  String? qq;
  String? wechat;
  String? pwd;
  String? major;
  String? campus;
  String? heading;
  static BaseData fromJson(Map<String,dynamic> rootdata){
    Map<String,dynamic> data=rootdata["data"];
    BaseData baseData = BaseData();
    baseData.id=data["id"];
    baseData.nickname=data["nickname"];
    baseData.gender=data["gender"];
    baseData.qq=data["qq"];
    baseData.wechat=data["wechat"];
    baseData.pwd=data["pwd"];
    baseData.major=data["major"];
    baseData.campus=data["campus"];
    baseData.heading=data["heading"];
    return baseData;
  }
}