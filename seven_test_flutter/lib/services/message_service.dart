import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageService {
  final String baseUrl;

  MessageService({required this.baseUrl});

  Future<List<dynamic>> getMessagesByConversationId(
      String conversationId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/messages/$conversationId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<int> addMessageInConversation(
      String conversationId, String body, int timestamp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages/$conversationId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'body': body,
        'timestamp': timestamp,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Failed to send message');
    }
  }

  Future<void> deleteMessage(String messageId) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/message/$messageId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete message');
    }
  }
}
