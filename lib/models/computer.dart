class Computer {
  int? id;
  String? name;
  bool? status;// có đang hoạt động hay không
  bool? isActive;// Có sử dụng được hay không
  int? installTime;
  int? startTime;
  int? usedTime;
  int? timeOut;
  String? user;

  Computer({
    this.id,
    this.name,
    this.status,
    this.isActive,
    this.installTime,
    this.startTime,
    this.usedTime,
    this.timeOut,
    this.user,
  });

  Computer.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name=json['name']??"";
    status=json['status']??false;
    isActive=json['isActive']??true;
    installTime=json['installTime']??0;
    startTime=json['startTime']??0;
    usedTime=json['usedTime']??0;
    timeOut=json['timeOut']??0;
    user=json['user']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['isActive'] = this.isActive;
    data['installTime'] = this.installTime;
    data['startTime'] = this.startTime;
    data['usedTime'] = this.usedTime;
    data['timeOut'] = this.timeOut;
    data['user'] = this.user;

    return data;
  }
}
