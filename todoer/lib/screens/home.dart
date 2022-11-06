import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoer/screens/addtask.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';

  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TO_DOer"),
          elevation: 0,
        ),
        body: Container(
          // ignore: sort_child_properties_last
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .doc(uid)
                .collection('mytasks')
                .snapshots(),
            builder: ((context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                final documents = snapshots.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Text(
                                      documents[index]['title'],
                                      style:
                                          GoogleFonts.comfortaa(fontSize: 16),
                                    ))
                              ]),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
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
