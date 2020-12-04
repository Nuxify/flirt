class Record {
  bool success;
  String message;
  String id;
  String data;
  String createdAt;

  Record({this.success, this.message, this.id, this.data, this.createdAt});

  Record.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    id = json['data']['id'];
    data = json['data']['data'];
    createdAt = json['data']['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data']['id'] = this.id;
    data['data']['data'] = this.data;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
