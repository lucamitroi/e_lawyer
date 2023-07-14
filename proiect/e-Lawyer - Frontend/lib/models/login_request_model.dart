class login_request_model {
  String? email;
  String? password;

  login_request_model({required this.email, required this.password});

  login_request_model.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Email'] = this.email;
    data['Password'] = this.password;
    return data;
  }
}
