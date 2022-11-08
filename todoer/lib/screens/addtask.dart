import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController discController = TextEditingController();

  addtaskTofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    String uid = user!.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': discController.text,
      'time': time.toString(),
      'timestamp': Timestamp.now(),
      'checkbox': false,
    });
    Fluttertoast.showToast(msg: 'Task Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purpleAccent,
        appBar: AppBar(
          title: Text("New Task"),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              
              Container(
                  child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: TextField(
                controller: discController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 400,
                  height: (50),
                  child: SizedBox(
                    height: 300,
                    width: 500,
                    child: ElevatedButton(
                      child: Text(
                        'Add Task',
                        style: GoogleFonts.comfortaa(),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.amberAccent),
                      onPressed: () {
                        addtaskTofirebase();
                      },
                    ),
                  )),
            ],
          ),
        ));
  }
}
