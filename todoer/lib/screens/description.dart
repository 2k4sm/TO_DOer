import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  final String title, description;

  const Description(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Description")),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              title,
              style: GoogleFonts.robotoMono(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              description,
              style: GoogleFonts.comfortaa(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
