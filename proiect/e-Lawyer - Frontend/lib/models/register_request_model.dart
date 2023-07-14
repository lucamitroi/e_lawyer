class register_request_model {
  String? name;
  String? surname;
  String? email;
  String? password;
  String? role;

  register_request_model(
      {this.name, this.surname, this.email, this.password, this.role});

  register_request_model.fromJson(Map<String, dynamic> json) {
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
