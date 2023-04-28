// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:my_flutter_application_1/page/my_login_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    // var email = user?.email.toString();

    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              "T.K.S. Chemical (Thailand) Co., Ltd.",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              "email!",
              style: TextStyle(color: Colors.black),
            ),
            // currentAccountPicture: CircleAvatar(
            //     backgroundImage: AssetImage("assets/images/logo4.png")),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //   image: AssetImage("assets/images/bg-menu.png"),
            //   fit: BoxFit.fill,
            // )),
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.home,
          //     size: 20,
          //     color: Color.fromARGB(255, 0, 0, 0),
          //   ),
          //   title: const Text(
          //     "Home",
          //     style:
          //         TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
          //   ),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const Home()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.history,
          //     size: 25,
          //     color: Color.fromARGB(255, 83, 82, 82),
          //   ),
          //   title: const Text(
          //     "Check in",
          //     style: TextStyle(
          //         fontSize: 20, color: Color.fromARGB(255, 83, 82, 82)),
          //   ),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => Mycheck(user)));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.history,
          //     size: 25,
          //     color: Color.fromARGB(255, 83, 82, 82),
          //   ),
          //   title: const Text(
          //     "History",
          //     style: TextStyle(
          //         fontSize: 20, color: Color.fromARGB(255, 83, 82, 82)),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => CalendarScreen(user)));
          //   },
          // ),
          ListTile(
            leading: const Icon(
              Icons.output,
              size: 20,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: const Text(
              "Logout",
              style:
                  TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            onTap: () {
              // signOut(context);
            },
          )
        ],
      ),
    );
  }

  // void signOut(BuildContext context) {
  //   // final FirebaseAuth auth = FirebaseAuth.instance;
  //   // auth.signOut();
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const MyLoginPage()),
  //       ModalRoute.withName('/'));
  // }
}
