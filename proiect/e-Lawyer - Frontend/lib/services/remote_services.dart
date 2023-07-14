import 'package:first_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<UserModel>?> getPost() async {
    var client = http.Client();

    var uri = Uri.parse("https://e-lawyer-server.onrender.com/police");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userModelFromJson(json);
    }
    return null;
  }
}
