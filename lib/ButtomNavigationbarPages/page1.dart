import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/pages/TodoCard.dart';
import 'package:firebasedemo/pages/view_data.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  Page1({super.key});
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 230, 65),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: StreamBuilder(
            //we don't have to refresh again and again when we are using stream builder.it automatically give new state when we use stream builder.
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                      snapshot.data?.docs[index].data() as Map<String,
                          dynamic>; //converting json file(snapshot.data.docs) into dart file by using Map<String,...>
                  print(document["Category"]);
                  switch (document["Category"]) {
                    case "Work":
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.red;
                      break;
                    case "Workout":
                      iconData = Icons.alarm;
                      iconColor = Colors.teal;
                      break;
                    case "Food":
                      iconData = Icons.local_grocery_store;
                      iconColor = Colors.blue;
                      break;
                    default:
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.red;
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => viewData(
                            document: document,
                            id: snapshot.data?.docs[index].id,
                          ),
                        ),
                      );
                    },
                    child: TodoCard(
                      title: document["title"] ?? "Hey there",
                      check: true,
                      iconBgColor: Colors.white,
                      iconColor: iconColor,
                      iconData: iconData,
                      time: '3:00 pm',
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
