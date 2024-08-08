import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    late var message;
    message = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${message.notification?.title}'),
          Text('${message.notification?.body}'),
          Text('${message.data}'),
        ],
      )),
    );
  }
}
