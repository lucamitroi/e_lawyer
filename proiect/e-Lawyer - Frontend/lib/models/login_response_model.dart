import 'dart:convert';

login_response_model loginResponseJson(String str) =>
    login_response_model.fromJson(json.decode(str));

class login_response_model {
  String? message;
  Data? data;

  login_response_model({required this.message, required this.data});

  login_response_model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? surname;
  String? email;
  String? password;

  Data({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    surname = json['Surname'];
    email = json['Email'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Surname'] = this.surname;
    data['Email'] = this.email;
    data['Password'] = this.password;
    return data;
  }
}
