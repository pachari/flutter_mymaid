import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screens/Login/login_screen.dart';
import 'package:flutter_mymaid/Screens/Home/components/launcher.dart';

class CheckUserState extends StatefulWidget {
  const CheckUserState({super.key});

  @override
  State<CheckUserState> createState() => _CheckUserStateState();
}

class _CheckUserStateState extends State<CheckUserState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return  Launcher(0);
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
