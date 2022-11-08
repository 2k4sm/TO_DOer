import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoer/screens/addtask.dart';
import 'package:todoer/screens/description.dart';

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
          centerTitle: true,
          title: Text("TO_DOer"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout_rounded))
          ],
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
                    var time = documents[index]['timestamp'].toDate();
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      title: documents[index]['title'],
                                      description: documents[index]
                                          ['description'],
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (p0) async {
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(uid)
                                    .collection('mytasks')
                                    .doc(documents[index]['time'])
                                    .delete();
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.all(15),
                              borderRadius: BorderRadius.circular(15),
                            )
                          ]),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            //height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blueGrey,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Checkbox(
                                        value: documents[index].get('checkbox'),
                                        onChanged: (p0) async {
                                          await FirebaseFirestore.instance
                                              .collection('tasks')
                                              .doc(uid)
                                              .collection('mytasks')
                                              .doc(documents[index]['time'])
                                              .update({
                                            'checkbox': !documents[index]
                                                .get('checkbox')
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 25),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              maxWidth: 200,
                                            ),
                                            child: Text(
                                              documents[index]['title'],
                                              style: TextStyle(
                                                  fontFamily: 'comfortaa',
                                                  fontSize: 20,
                                                  decoration: documents[index]
                                                          .get('checkbox')
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none),

                                              //GoogleFonts.comfortaa(fontSize: 17),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 25),
                                        child: Text(DateFormat.yMd()
                                            .add_jm()
                                            .format(time)),
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.yellowAccent,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: SizedBox(
          height: 50,
          width: 100,
          child: FloatingActionButton(
              elevation: 5,
              shape: StadiumBorder(),
              child: Icon(Icons.add_box_outlined),
              //Icon(CupertinoIcons.add_circled),
              backgroundColor: Colors.blueAccent,
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTask()));
              })),
        ));
  }
}
