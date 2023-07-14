import 'dart:convert';

import 'package:first_app/models/login_request_model.dart';
import 'package:first_app/models/complaint_request_model.dart';
import 'package:first_app/models/login_response_model.dart';
import 'package:first_app/models/register_response_model.dart';
import 'package:first_app/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:first_app/globals.dart' as globals;

import '../models/complaint_response_model.dart';
import '../models/register_request_model.dart';

class APIService {
  static var client = http.Client();

  static Future<String> login(login_request_model model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    globals.userID = "";
    var url = Uri.parse("https://e-lawyer-server.onrender.com/user/login/");

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      String jsonString = response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      String tokenString = jsonMap['token'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenString);
      globals.userID = decodedToken['userId'];

      String userData = await APIService.getUserProfile();
      Map<String, dynamic> jsonMapRole = await json.decode(userData);
      String userRole = await jsonMapRole['Role'];

      return userRole;
    } else {
      return "";
    }
  }

  static Future<String> getUserProfile() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(
        "https://e-lawyer-server.onrender.com/user/${globals.userID}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<String> getAllUserProfile() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse("https://e-lawyer-server.onrender.com/user");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<String> getComplaintDetails(String complaintID) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(
        "https://e-lawyer-server.onrender.com/complaint/id/${complaintID}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<String> getUserComplaintDetails(String userID) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(
        "https://e-lawyer-server.onrender.com/complaint/userid/${userID}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<String> patchUserProfile(String type, String content) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final body = {type: content};
    var url = Uri.parse(
        "https://e-lawyer-server.onrender.com/user/${globals.userID}");

    var response = await client.patch(url,
        headers: requestHeaders, body: jsonEncode(body));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> patchComplaint(
      String type, String content, String complaintID) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final body = {type: content};
    var url = Uri.parse(
        "https://e-lawyer-server.onrender.com/complaint/${complaintID}");

    var response =
        await client.put(url, headers: requestHeaders, body: jsonEncode(body));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> deleteComplaint(String complaintID) async {
    var url = Uri.parse(
        "https://e-lawyer-server.onrender.com/complaint/${complaintID}");

    var response = await client.delete(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> getUserComplaints() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(
        "https://e-lawyer-server.onrender.com/complaint/userid/${globals.userID}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<register_response_model> register(
      register_request_model model, BuildContext context) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("https://e-lawyer-server.onrender.com/user/signup/");

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    return registerResponseJson(response.body);
  }

  static Future<complaint_response_model> postComplaint(
      complaint_request_model model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("https://e-lawyer-server.onrender.com/complaint/");

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print(response.body);
    return complaintResponseJson(response.body);
  }
}
