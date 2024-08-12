import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingpong/constants.dart';
import 'package:pingpong/firebase_options.dart';
import 'package:pingpong/views/chat_view.dart';
import 'package:pingpong/views/login_view.dart';
import 'package:pingpong/views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PingPong());
}

class PingPong extends StatelessWidget {
  const PingPong({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        ChatView.id: (context) => ChatView(),
      },
      theme: ThemeData(brightness: Brightness.dark, fontFamily: kFont),
      initialRoute: LoginView.id,
    );
  }
}
