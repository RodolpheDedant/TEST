import 'package:http/http.dart' as http;
import 'dart:convert';

class ConversationService {
  final String baseUrl;

  ConversationService({required this.baseUrl});

  Future<List<dynamic>> getConversationsByUserId(String userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/conversations/$userId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<int> addConversation(String userId, int recipientId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/conversations/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'recipientId': recipientId,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Failed to create conversation');
    }
  }

  Future<void> deleteConversationById(String conversationId) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/conversation/$conversationId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete conversation');
    }
  }
}
