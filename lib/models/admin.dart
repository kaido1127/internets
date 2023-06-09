class Admin {
  String? fullName;
  bool? fullTime;
  String? imageUrl;
  String? password;
  String? phone;
  String? userName;
  String? yearOld;
  String? cs;

  Admin({this.fullName,
    this.fullTime,
    this.imageUrl,
    this.password,
    this.phone,
    this.userName,
    this.yearOld,
    this.cs,});

  Admin.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName']??'';
    fullTime = json['fullTime']??true;
    imageUrl = json['imageUrl']??'';
    password = json['password']??'';
    phone = json['phone']??'';
    userName = json['userName']??'';
    yearOld = json['yearOld']??'';
    cs=json['cs']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['fullTime'] = this.fullTime;
    data['imageUrl'] = this.imageUrl;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['userName'] = this.userName;
    data['yearOld'] = this.yearOld;
    data['cs']=this.cs;
    return data;
  }
}
