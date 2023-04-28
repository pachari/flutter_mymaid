import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../../../componants/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(kDefaultPedding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPedding / 2),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(kDefaultPedding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPedding / 2),
          TextFormField(
            controller: confirmController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Re-password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(kDefaultPedding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPedding / 2),
          ElevatedButton(
            onPressed: () {
              signUp();
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: kDefaultPedding),
          // AlreadyHaveAnAccountCheck(
          //   login: false,
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return const LoginScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  signUp() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    if (email.isNotEmpty) {
      if (password == confirmPassword && password.length >= 6) {
        _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((user) {
          // ignore: avoid_print
          print("Sign up user successful.");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              ModalRoute.withName('/'));
        }).catchError((error) {
          // ignore: avoid_print
          print(error.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${error.message}'),
            ),
          );
        });
      } else {
        // ignore: avoid_print
        print("Password and Confirm-password is not match.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and Confirm-password is not match."),
          ),
        );
      }
    } else {
      // ignore: avoid_print
      print("The email address is badly formatted.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("The email address is badly formatted."),
        ),
      );
    }
  }
}
