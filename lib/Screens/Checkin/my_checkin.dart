import 'dart:async';
import 'dart:io';
// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mymaid/Screens/Checkin/components/my_checkin_view.dart';
// import 'package:flutter_mymaid/Screens/Home/components/launcher.dart';
import 'package:flutter_mymaid/componants/background.dart';
import 'package:flutter_mymaid/Screens/Menu/appbar.dart';
import 'package:flutter_mymaid/constants.dart';
import 'package:intl/intl.dart';

import '../Qrcode/qrview.dart';

class Mycheck extends StatefulWidget {
  static const routeName = '/checkpoint';
  const Mycheck({Key? key}) : super(key: key);

  @override
  State<Mycheck> createState() => _MycheckState();
}

class _MycheckState extends State<Mycheck> with SingleTickerProviderStateMixin {
  // final TextEditingController newTodoController = TextEditingController();
  // DateTime
  String formattedDates = DateFormat('yyyyMMdd').format(DateTime.now());
  // document id
  List<String> docLists = [];
  List<String> todoActiveIDs = [];
  List<String> checklistsdocIDs = [];
  //  List<String> checklistsdocIDs = [];
  // get checklists docIDs
  Future getChecklistsDocIds() async {
    try {
      final db =
          FirebaseFirestore.instance.collection("checklists").orderBy('id');
      await db.get().then(
            (snapshot) => snapshot.docs.forEach(
              (document) {
                checklistsdocIDs.add(document.reference.id);
              },
            ),
          );
    } on SocketException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    }
  }

  // get DocIdsList
  Future getTodoLists(int id) async {
    try {
      todoActiveIDs = [];
      final user = FirebaseAuth.instance.currentUser;
      final db = FirebaseFirestore.instance.collection("todolists");
      // ignore: non_constant_identifier_names
      int Sid = 0;
      for (var i = 1; i <= 20; i++) {
        final todolists =
            db.doc(user?.uid).collection('$formattedDates-$id').doc('$i');
        final docSnap = await todolists.get();
        final todolistsId = docSnap.data();

        if (todolistsId != null) {
          if (todolistsId['active'] == true) {
            if (Sid != id) {
              todoActiveIDs.add('${todolistsId['checklistid']}');
              Sid = id;
            }
          }
        }
      }
      return '$todoActiveIDs';
    } on SocketException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        // appBar: const BuildAppBar(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Check List", //  (sqlite) + firebase firestore
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: Background(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: getChecklistsDocIds(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: checklistsdocIDs.length,
                          itemBuilder: (context, index) {
                            Widget card; // สร้างเป็นตัวแปร
                            card = Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildbody(context, checklistsdocIDs[index]),
                                  ],
                                ));
                            return card;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<DocumentSnapshot> buildbody(
      BuildContext context, String lists) {
    final checklists =
        FirebaseFirestore.instance.collection("checklists").doc(lists);
    return FutureBuilder<DocumentSnapshot>(
      future: checklists.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ListTile(
            trailing: IconButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Qrview()),
                )
              },
              icon: const Icon(
                Icons.qr_code_scanner_outlined,
                size: 25,
                color: kTextColor,
              ),
            ),
            leading: IconButton(
              onPressed: () => {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: kTabsColor,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('รายละเอียด จุดเช็คอิน',
                                        style: TextStyle(
                                            fontSize: kDefaultFont,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const Text('ชื่อ: ',
                                            style: TextStyle(
                                                fontSize: kDefaultFont)),
                                        Text('${data['title']}',
                                            style: const TextStyle(
                                                fontSize: kDefaultFont)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text('รายละเอียด: ',
                                            style: TextStyle(
                                                fontSize: kDefaultFont)),
                                        Text('${data['subtitle']}',
                                            style: const TextStyle(
                                                fontSize: kDefaultFont)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text('สถานะ: ',
                                            style: TextStyle(
                                                fontSize:
                                                    kDefaultFont)), //, fontWeight: FontWeight.bold
                                        Text(
                                            data['active']
                                                ? 'เปิดใช้งาน'
                                                : 'ปืดใช้งาน',
                                            style: const TextStyle(
                                                fontSize: kDefaultFont)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const Text('Modal BottomSheet'),
                            // ElevatedButton(
                            //   child: const Text('Close BottomSheet'),
                            //   onPressed: () => Navigator.pop(context),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              },
              icon: _checkIcon(data['id']),
            ),
            title: Text('${data['title']}',
                style: const TextStyle(fontSize: 16, color: kTextColor)),
            subtitle: Text('${data['subtitle']}',
                style: const TextStyle(fontSize: 16)),
            onTap: () {
              // newTodoController.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MycheckView(data['id'])),
              );
            },
          );
        }
        return const Text('Loading..');
      },
    );
  }

  Widget _checkIcon(int id) {
    return FutureBuilder(
      future: getTodoLists(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Icon(
              Icons.location_pin,
              size: 30,
            );
          } else {
            List<String> ss = snapshot.data.split(',');
            for (int n = 0; n < ss.length; n++) {
              ss[n] = ss[n]
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(' ', '');
              if (ss[n] == '$id') {
                return const Icon(
                  Icons.location_pin,
                  color: Colors.green,
                  size: 30,
                );
              }
            }
          }
        }
        return const Icon(
          Icons.location_pin,
          size: 30,
        );
      },
    );
  }
}
