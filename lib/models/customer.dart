class Customer {
  String? id;
  String? name;
  String? username;
  String? password;
  String? phoneNumber;
  int? startTime;
  int? lastOnline;
  int? totalTime;
  int? totalCost;
  int? currentCost;
  bool? isActive;
  String? onlineInCs;
  String? onlineComputer;
  String? imageUrl;

  Customer({
    this.id,
    this.name,
    this.phoneNumber,
    this.startTime,
    this.totalTime,
    this.totalCost,
    this.isActive,
    this.username,
    this.password,
    this.lastOnline,
    this.onlineInCs,
    this.onlineComputer,
    this.imageUrl,
    this.currentCost,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    username=json['username']??'';
    password=json['password']??'';
    phoneNumber = json['phoneNumber'] ?? '';
    startTime = json['startTime'] ?? 0;
    totalTime = json['totalTime'] ?? 0;
    totalCost = json['totalCost'] ?? 0;
    isActive = json['isActive'] ?? false;
    lastOnline=json['lastOnline']??0;
    onlineInCs=json['onlineInCs']??"";
    onlineComputer=json['onlineComputer']??"";
    imageUrl=json['imageUrl']??"";
    currentCost=json['currentCost']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username']=this.username;
    data['password']=this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['startTime'] = this.startTime;
    data['totalTime'] = this.totalTime;
    data['totalCost'] = this.totalCost;
    data['isActive'] = this.isActive;
    data['lastOnline']=this.lastOnline;
    data['onlineInCs']=this.onlineInCs;
    data['onlineComputer']=this.onlineComputer;
    data['imageUrl']=this.imageUrl;
    data['currentCost']=this.currentCost;
    return data;
  }
}
