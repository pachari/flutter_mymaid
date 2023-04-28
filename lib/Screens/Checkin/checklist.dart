// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_mymaid/componants/background.dart';
import 'package:flutter_mymaid/constants.dart';
import 'package:flutter_mymaid/Screens/Checkin/components/getchecklist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetChecklist extends StatelessWidget {
  const GetChecklist({super.key});

  @override
  Widget build(BuildContext context) {
// document id
    List<String> docIDs = [];
// get docIDs
    Future getDocIds() async {
      await FirebaseFirestore.instance
          .collection("checklists")
          .orderBy("id")
          .get()
          .then(
            (snapshot) => snapshot.docs.forEach(
              (document) {
                // ignore: avoid_print
                print(document.reference);
                docIDs.add(document.reference.id);
              },
            ),
          );
    }

    return DefaultTabController(
      length: 4, //choices.length,
      child: Scaffold(
        // appBar: const BuildAppBar(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "สถานที่ (firebase)",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: Background(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: getDocIds(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: docIDs.length,
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
                                ), // การเยื้องขอบ
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GetChecklists(
                                          documentId: docIDs[index],
                                        ),
                                      // ListTile(
                                      //   // leading: const Icon(
                                      //   //   Icons.home_work_outlined,
                                      //   //   color: kTextColor,
                                      //   //   size: 20,
                                      //   // ),
                                      //   trailing: IconButton(
                                      //     onPressed: () => {
                                      //       Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               const TodosPage(1),
                                      //         ),
                                      //       )
                                      //     },
                                      //     icon: const Icon(
                                      //       Icons.arrow_forward_ios_sharp,
                                      //       size: 15,
                                      //       color: kTextColor,
                                      //     ), //_viewIcon(1),//check.status
                                      //   ),
                                      //   title: GetChecklists(
                                      //     documentId: docIDs[index],
                                      //   ),
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const TodosPage(1),
                                      //       ), // Qrview const TodosPage()),  MycheckView(name: '${check.id}')
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  ),
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
}
