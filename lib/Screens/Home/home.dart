import 'package:flutter/material.dart';
import 'package:flutter_mymaid/Screens/Checkin/checklist.dart';
// import 'package:flutter_mymaid/Screens/Getuser/getuser.dart';
import '../../responsive.dart';
import '../../componants/background.dart';
// import '../Checkin/my_checkin.dart';
import '../Login/components/login_screen_top_image.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

final user = FirebaseAuth.instance.currentUser;

// // document id
// List<String> docIDs = [];
// // get docIDs
// Future getDocIds() async {
//   await FirebaseFirestore.instance.collection('checklists').get().then(
//         // ignore: avoid_function_literals_in_foreach_calls
//         (snapshot) => snapshot.docs.forEach(
//           (document) {
//             // ignore: avoid_print
//             print(document.reference);
//             docIDs.add(document.reference.id);
//           },
//         ),
//       );
// }

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Builder(builder: (BuildContext context) {
        // เรียกใช้งาน TabController
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          // ตรวจจับการทำงาน
          if (!tabController.indexIsChanging) {
            // มีการเปลี่ยน tab
            // กำหนดคำสั่งตรงนี้
            // tabController.animateTo(3); ไปยัง tab ที่กำหนด
            // tabController.index ค่า index ที่เปลี่ยน
            // tabController.previousIndex ค่า index ก่อนเปลี่ยน
            // print(tabController.index);
            // print(tabController.previousIndex);
          }
        });
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
                        child: buildContainerbodyHello(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        // child: SizedBox(
                        //     width: 1000,
                        //     child: Expanded(
                        //         child: FutureBuilder(
                        //       future: getDocIds(),
                        //       builder: (context, snapshot) {
                        //         return ListView.builder(
                        //           itemCount: docIDs.length,
                        //             itemBuilder: (context, index) {
                        //           return  ListTile(title: Text(docIDs[index]));
                        //         });
                        //       },
                        //     ))
                        child: buildContainerbodyTaskSummary(context, 100, 200),
                        // ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const LoginScreenTopImage(),
            buildContainerbodyHello(),
            buildContainerbodyTaskSummaryMobile(context, 80, 130),
          ],
        ),
      ),
    );
  }
}

Widget buildContainerbodyHello() {
  var email = user?.email.toString();

  return InkWell(
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 0.0),
      // padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            title: const Text(
              "Hello,",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            subtitle: Text(
              email!,
              style: const TextStyle(
                color: Color.fromARGB(255, 58, 57, 57),
                fontSize: 20,
              ),
            ),
            // onTap: () {
            //   const GetChecklist();
            // },
          ),
        ],
      ),
    ),
  );
}

Widget buildContainerbodyTaskSummary(context, int height, int width) {
  return InkWell(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 2, 7, 93),
              Color.fromARGB(255, 2, 7, 93),
            ]),
          ),
          child: ListTile(
            title: Text(
              "Task Summary".toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildContainerbAll(context, height, width),
              buildContainerbPending(context, height, width),
              buildContainerbVisiting(context, height, width),
              buildContainerbDone(context, height, width),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildContainerbodyTaskSummaryMobile(context, int height, int width) {
  return InkWell(
    child: Padding(
      padding: const EdgeInsets.all(kDefaultPedding),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const GetChecklist();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(elevation: 0),
            child: Text(
              "Task Summary".toUpperCase(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: buildContainerbAll(context, height, width),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: buildContainerbPending(context, height, width),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: buildContainerbVisiting(context, height, width),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: buildContainerbDone(context, height, width),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildContainerbAll(context, int height, int width) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: height * 1,
      width: width * 1,
      decoration: BoxDecoration(
        color: const Color.fromARGB(251, 237, 214, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      padding: const EdgeInsets.all(1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "All".toUpperCase(),
            style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(250, 107, 0, 146)),
          ),
          const Text(
            "4",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(250, 107, 0, 146)),
          ),
        ],
      ),
    ),
  );
}

Widget buildContainerbPending(context, int height, int width) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const Mycheck()));
      // const snackBar = SnackBar(content: Text('Pending'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child: Container(
      height: height * 1,
      width: width * 1,
      decoration: BoxDecoration(
        color: const Color.fromARGB(28, 56, 103, 244),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      padding: const EdgeInsets.all(1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Pending".toUpperCase(),
            style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 56, 103, 244)),
          ),
          const Text(
            "3",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 56, 103, 244)),
          ),
        ],
      ),
    ),
  );
}

Widget buildContainerbVisiting(context, int height, int width) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const Mycheck()));
      // const snackBar = SnackBar(content: Text('Pending'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child: Container(
      height: height * 1,
      width: width * 1,
      decoration: BoxDecoration(
        color: const Color.fromARGB(28, 244, 69, 56),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      padding: const EdgeInsets.all(1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Visiting".toUpperCase(),
            style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 244, 69, 56)),
          ),
          const Text(
            "2",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 244, 69, 56)),
          ),
        ],
      ),
    ),
  );
}

Widget buildContainerbDone(context, int height, int width) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const Mycheck()));
      // const snackBar = SnackBar(content: Text('Done'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child: Container(
      height: height * 1,
      width: width * 1,
      decoration: BoxDecoration(
        color: const Color.fromARGB(28, 22, 185, 0),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      padding: const EdgeInsets.all(1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Done".toUpperCase(),
            style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(195, 13, 108, 0)),
          ),
          const Text(
            "1",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(195, 12, 106, 0)),
          ),
        ],
      ),
    ),
  );
}
