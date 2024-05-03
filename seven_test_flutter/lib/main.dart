import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seven_test_flutter/services/user_service.dart';
import 'package:seven_test_flutter/user.dart';

void main() {
  GetIt locator = GetIt.instance;

  locator.registerLazySingleton<UserService>(
      () => UserService(baseUrl: 'http://127.0.0.1:3005'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Utilisation de UserService'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              UserService userService = GetIt.instance<UserService>();

              try {
                List<dynamic> users = await userService.getUsers();
                print('Utilisateurs récupérés: $users');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserListPage(
                      userService: userService,
                    ),
                  ),
                );
              } catch (e) {
                print('Erreur lors de la récupération des utilisateurs: $e');
              }
            },
            child: Text('Obtenir les utilisateurs'),
          ),
        ),
      ),
    );
  }
}
