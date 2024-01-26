import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:love_propose/style.dart';
import 'package:myself/myself.dart';

class CreateLink extends StatefulWidget {
  const CreateLink({super.key});

  @override
  State<CreateLink> createState() => _CreateLinkState();
}

class _CreateLinkState extends State<CreateLink> {
  bool isYesSelected = true;
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  List<bool> isSelectedList = [true, false, false, false];

  static ButtonStyle unselectedBtn = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.pink,
    minimumSize: const Size(150, 50),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  static ButtonStyle selectedBtn = ElevatedButton.styleFrom(
    minimumSize: const Size(150, 50),
    backgroundColor: Colors.pink,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  void handleSubmit(BuildContext context) {
    MySelfColor()
        .printHex("#000000", 'Yes/No Selected: ${isYesSelected ? '1' : '0'}');
    MySelfColor().printHex("#000000", 'Text Field 1: ${textController1.text}');
    MySelfColor().printHex("#000000", 'Text Field 2: ${textController2.text}');

    // try {
    final Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encode(String text) => stringToBase64.encode(text);

    int selectedOptionIndex = isSelectedList.indexOf(true);
    MySelfColor().printHex(
        "#000000", 'Selected Option: Option ${selectedOptionIndex + 1}');
    (context).goNamed('message', queryParameters: {
      "sno": "${isYesSelected ? 1 : 0}",
      "title": encode(textController1.text),
      "message": encode(textController2.text)
    });
  }

  final hight = const SizedBox(height: 15);
  final width = const SizedBox(width: 15);

  titleFn(String title) => Text(
        title,
        style: GoogleFonts.greatVibes(
          fontSize: 24,
          // fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your proposal',
          style: GoogleFonts.greatVibes(fontSize: 32),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: const BoxConstraints(maxWidth: 660, minWidth: 340),
          child: ListView(
            children: [
              titleFn("What you want from your person?"),
              hight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isYesSelected = true;
                      });
                    },
                    style: isYesSelected ? selectedBtn : unselectedBtn,
                    child: const Text('Yes'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isYesSelected = false;
                      });
                    },
                    style: !isYesSelected ? selectedBtn : unselectedBtn,
                    child: const Text('No'),
                  ),
                ],
              ),
              hight,
              titleFn("Enter your question?"),
              hight,
              TextField(
                controller: textController1,
                decoration: InputDecoration(
                  // labelText: 'Text Field 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              hight,
              titleFn("Your secrite message"),
              hight,
              TextField(
                controller: textController2,
                decoration: InputDecoration(
                  // labelText: 'Text Field 2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              hight,
              titleFn("Some option image's for you"),
              hight,
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  for (int i = 0; i < isSelectedList.length; i++)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          for (int j = 0; j < isSelectedList.length; j++) {
                            isSelectedList[j] = (i == j);
                          }
                        });
                      },
                      style: isSelectedList[i] ? selectedBtn : unselectedBtn,
                      child: Text('Option ${i + 1}'),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              HeartShapedButton(
                onPressed: () => handleSubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
