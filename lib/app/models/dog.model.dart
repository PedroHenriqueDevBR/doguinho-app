class DogModel {
  String _message;
  String _status;

  DogModel({String message, String status}) {
    this._message = message;
    this._status = status;
  }

  String get message => _message;

  set message(String message) => _message = message;

  String get status => _status;

  set status(String status) => _status = status;

  DogModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['status'] = this._status;
    return data;
  }
}
