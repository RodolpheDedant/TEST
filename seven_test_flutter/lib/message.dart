import 'package:flutter/material.dart';
import 'package:seven_test_flutter/services/message_service.dart';

class MessageListPage extends StatefulWidget {
  final String conversationId;
  final MessageService messageService;

  MessageListPage({required this.conversationId, required this.messageService});

  @override
  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  late Future<List<dynamic>> _messageList;

  @override
  void initState() {
    super.initState();
    _messageList = widget.messageService
        .getMessagesByConversationId(widget.conversationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _messageList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<dynamic> messages = snapshot.data!;
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return ListTile(
                  title: Text(message['body']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
