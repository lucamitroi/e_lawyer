import 'dart:convert';

register_response_model registerResponseJson(String str) =>
    register_response_model.fromJson(json.decode(str));

class register_response_model {
  String? message;
  Data? data;

  register_response_model({required this.message, required this.data});

  register_response_model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? surname;
  String? email;
  String? password;
  String? role;

  Data({this.name, this.surname, this.email, this.password, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    surname = json['Surname'];
    email = json['Email'];
    password = json['Password'];
    role = json['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Surname'] = this.surname;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Role'] = this.role;
    return data;
  }
}
