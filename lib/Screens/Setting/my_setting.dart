import 'package:flutter/material.dart';
import '../../responsive.dart';
import '../../componants/background.dart';
import '../../constants.dart';
import '../../Screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

// final FirebaseAuth _auth = FirebaseAuth.instance;
final user = FirebaseAuth.instance.currentUser;

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 1000,
                    child: buildContainerAvatar(),
                  ),
                  SizedBox(
                    width: 1000,
                    child: buildContainerMenuLanguage(context),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Settings",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 5),
              child: buildContainerAvatar(),
            ),
            buildContainerMenuLanguage(context),
          ],
        ),
      ),
    );
  }
}

Widget buildContainerMenuLanguage(context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
            //   child: Container(
            //     height: 55,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(16),
            //       color: kPrimaryColor,
            //     ),
            //     child: const ListTile(
            //       title: Text(
            //         "Settings",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //             color: Color.fromARGB(255, 255, 255, 255)),
            //       ),
            //     ),
            //   ),
            // ),
            // buildCards(context, 'Dark mode', Icons.arrow_forward_ios_rounded,
            //     Icons.nightlight, 1),
            buildCards(context, 'Logout', Icons.arrow_forward_ios_rounded,
                Icons.logout_sharp, 2),
          ],
        ),
      ),
    ],
  );
}

void signOut(BuildContext context) {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      ModalRoute.withName('/'));
}

Widget buildContainerAvatar() {
  var email = user?.email.toString();
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          const CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage("assets/images/woman.png"),
            backgroundColor: Color.fromARGB(123, 0, 0, 0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(email!, //"Pacharri.pha@tkschemical.co.th",
                style: const TextStyle(fontSize: 16, color: kTextColor)),
          ),
        ],
      ),
    ),
  );
}

Widget buildCards(context, title, iconsfrist, icons, tabs) {
  return InkWell(
    child: Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kTextColor)),
        leading: Icon(icons),
        // trailing: Icon(
        //   iconsfrist,
        //   size: 20,
        // ),
        onTap: () {
          if (tabs == 1) {
            signOut(context);
          } else {
            signOut(context);
          }
        },
      ),
    ),
  );
}
