import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:firebasedemo/ButtomNavigationbarPages/page1.dart';
import 'package:firebasedemo/pages/HomePage.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class viewData extends StatefulWidget {
  final Map<String, dynamic>? document;
  const viewData({super.key, this.document, this.id});
  final String? id;

  @override
  State<viewData> createState() => _viewData();
}

// ignore: camel_case_types
class _viewData extends State<viewData> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String type = ""; //This will match to task field type
  String category = "";
  bool edit = false;
  @override
  void initState() {
    super.initState();
    String title = widget.document!["title"] ?? "Hey there";
    _titleController = TextEditingController(text: title);
    _descriptionController =
        TextEditingController(text: widget.document?["description"]);
    type = widget.document?["task"];
    category = widget.document?["Category"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 50, 230, 65),
        toolbarHeight: 35,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("Todo")
                    .doc(widget.id)
                    .delete()
                    .then((value) {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 28,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  edit = !edit;
                });
              },
              icon: Icon(
                Icons.edit,
                color: edit ? Colors.green : Colors.white,
                size: 28,
              )),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 50, 230, 65),
            Color.fromARGB(255, 50, 230, 65),
            Color.fromARGB(255, 50, 230, 65)
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    label('Task Title'),
                    const SizedBox(
                      height: 12,
                    ),
                    title(),
                    const SizedBox(
                      height: 30,
                    ),
                    label('Task Type'),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        taskSelect('Important !', 0xffff6d6e),
                        const SizedBox(
                          width: 20,
                        ),
                        taskSelect('planned', 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    label('Description'),
                    const SizedBox(
                      height: 12,
                    ),
                    description(),
                    const SizedBox(
                      height: 25,
                    ),
                    label('Category'),
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      //wrap helps for grouping the items inside category
                      children: [
                        taskSelect('Food', 0xff2664fa),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Workout', 0xff2bc8d9),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Work', 0xff6557ff),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Design', 0xff234ebd),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Run', 0xfff29732),
                        const SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    edit
                        ? button()
                        : Container(), //if user click the edit icon then visible update todo btn
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("Todo").doc(widget.id).update({
          "title": _titleController.text,
          "task": type,
          "Category": category,
          "description": _descriptionController.text
        });
        Navigator.pop((context),
            MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 9, 174, 14)),
        child: const Center(
          child: Text(
            "Update Todo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        enabled: edit,
        controller: _descriptionController,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "description...",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    //actually this is a task chip but AKA chipData
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label
            ? Colors.white
            : Color(
                color), //if user click the task type then it changes color into black
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          10,
        )),
        label: Text(
          label,
          style: TextStyle(
            color: type == label ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              category = label;
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          10,
        )),
        label: Text(
          label,
          style: TextStyle(
            color: category == label ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        enabled: edit,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 17,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Task title..",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 22,
          letterSpacing: 0.2),
    );
  }
}
