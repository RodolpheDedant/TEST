import 'package:flutter/material.dart';
import 'package:seven_test_flutter/services/user_service.dart';
import 'package:seven_test_flutter/services/conversation_service.dart';
import 'conversations.dart';

class UserListPage extends StatefulWidget {
  final UserService userService;

  const UserListPage({Key? key, required this.userService}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<dynamic>> _userList;
  ConversationService conversationService =
      ConversationService(baseUrl: "localhost:3000");

  @override
  void initState() {
    super.initState();
    _userList = widget.userService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('User List'),
      // ),
      body: FutureBuilder<List<dynamic>>(
        future: _userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<dynamic> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  title: Text(user['nickname']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationListPage(
                          userId: user['id'].toString(),
                          conversationService: conversationService,
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
