// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUser extends StatelessWidget {
  final String documentId;
  const GetUser({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference lists =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: lists.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['title']}' + ' ' + '${data['subtitle']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600));
        }
        return const Text('Loading..');
      },
    );
  }
}
