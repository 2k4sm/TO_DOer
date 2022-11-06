import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoer/screens/addtask.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("TO_DOer")),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: SizedBox(
          height: 50,
          width: 100,
          child: FloatingActionButton(
              shape: StadiumBorder(),
              child: Text('New Task'),
              //Icon(CupertinoIcons.add_circled),
              backgroundColor: Colors.brown,
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTask()));
              })),
        ));
  }
}
