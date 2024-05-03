import 'package:flutter/material.dart';
import 'package:seven_test_flutter/services/conversation_service.dart';
import 'package:seven_test_flutter/services/message_service.dart';
import 'message.dart';

class ConversationListPage extends StatefulWidget {
  final String userId;
  final ConversationService conversationService;

  ConversationListPage(
      {required this.userId, required this.conversationService});

  @override
  _ConversationListPageState createState() => _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  late Future<List<dynamic>> _conversationList;
  MessageService messageService =
      MessageService(baseUrl: "http://localhost:3005");

  @override
  void initState() {
    super.initState();
    _conversationList =
        widget.conversationService.getConversationsByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _conversationList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<dynamic> conversations = snapshot.data!;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                var conversation = conversations[index];
                return ListTile(
                  title: Text('Conversation ${conversation['id']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageListPage(
                          conversationId: conversation['id'].toString(),
                          messageService: messageService,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
