// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mymaid/constants.dart';
import 'package:flutter_mymaid/Screens/todos_page/page_todo.dart';

class GetChecklists extends StatelessWidget {
  final String documentId;
  const GetChecklists({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final checklists = db.collection("checklists").doc(documentId);
    return FutureBuilder<DocumentSnapshot>(
      future: checklists.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          //return Text('${data['title']}' + ' ' + '${data['subtitle']}', style: const TextStyle(fontSize: 16, color: kTextColor));
          return ListTile(
            trailing: IconButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodosPage(data['id']),
                  ),
                )
              },
              icon: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 15,
                color: kTextColor,
              ),
            ),
            title: Text('${data['title']}' + ' ' + '${data['subtitle']}',
                style: const TextStyle(fontSize: 16, color: kTextColor)),
            // GetChecklists(
            //   documentId: docIDs[index],
            // ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodosPage(data['id']),
                ),
              );
            },
          );
        }
        return const Text('Loading..');
      },
    );
  }
  
}
