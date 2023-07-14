import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.county,
    required this.city,
    required this.name,
    required this.adress,
    required this.phone,
  });

  String county;
  String city;
  String name;
  String adress;
  String phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        county: json["County"],
        city: json["City"],
        name: json["Name"],
        adress: json["Adress"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toJson() => {
        "County": county,
        "City": city,
        "Name": name,
        "Adress": adress,
        "Phone": phone,
      };
}
