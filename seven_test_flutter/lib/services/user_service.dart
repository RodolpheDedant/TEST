import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final String baseUrl;

  UserService({required this.baseUrl});

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
      // } else if (response.statusCode == 504) {
      //   throw Exception('protu');
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<dynamic> getUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 504) {
      throw Exception('protu');
    } else {
      throw Exception('Failed to load user');
    }
  }
}
