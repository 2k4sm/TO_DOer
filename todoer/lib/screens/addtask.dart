import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purpleAccent,
        appBar: AppBar(title: Text("New Task")),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                  child: TextField(
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
                      onPressed: () {},
                    ),
                  )),
            ],
          ),
        ));
  }
}
