import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import '../../../componants/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:flutter_mymaid/Screens/Home/components/launcher.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: kDefaultPedding * 1),
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
              // autofocus: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPedding),
              child: TextFormField(
                controller: passwordController,
                scrollPadding:
                    const EdgeInsets.symmetric(vertical: kDefaultPedding),
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
            ),
            const SizedBox(height: 5),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () {
                  signIn();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const Launcher();
                  //     },
                  //   ),
                  // );
                },
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
            ),
            const SizedBox(height: kDefaultPedding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    try {
      user = await _auth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(), //"pachari_pm@hotmail.com", //
        password: passwordController.text.trim(), //"Mm1234", //
      )
          .then((user) {
        // ignore: avoid_print
        print("signed in ${user.user}");
        checkAuth(context); // add here
      }).catchError((error) {
        // ignore: avoid_print
        print(error.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${error.message}'),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: avoid_print
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // ignore: avoid_print
        print('Wrong password provided for that user.');
      }
    }
  }

  Future checkAuth(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    // Firebase user = await _auth.currentUser;
    if (user != null) {
      // ignore: avoid_print
      print("Already singed-in with");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  Launcher(0)));
      });
    }
  }
}
