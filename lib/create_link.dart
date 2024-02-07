import 'dart:convert';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:love_propose/style.dart';

class CreateLink extends StatefulWidget {
  const CreateLink({super.key});

  @override
  State<CreateLink> createState() => _CreateLinkState();
}

class _CreateLinkState extends State<CreateLink> {
  bool isYesSelected = true;
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  String? generatedLink;

  List<bool> isSelectedList = [true, false, false, false];

  final ScrollController scroll = ScrollController();

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
    final Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encode(String text) => stringToBase64.encode(text);
    generatedLink =
        "http://localhost:50975/#/message?sno=${isYesSelected ? 1 : 0}&title=${encode(textController1.text)}&message=${encode(textController2.text)}";

    setState(() {});
    scroll.jumpTo(scroll.position.maxScrollExtent + 70);
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
          color: Colors.transparent,
          child: ListView(
            controller: scroll,
            children: [
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
              hight,
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
              HeartShapedButton(
                onPressed: () => handleSubmit(context),
              ),
              if (generatedLink != null)
                ListTile(
                  title:
                      Text("$generatedLink", overflow: TextOverflow.ellipsis),
                  // trailing: const Icon(Icons.copy),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: "$generatedLink"),
                            );
                          },
                          child: Text("Copy"),
                        ),
                        width,
                        ElevatedButton(
                          onPressed: () {
                            js.context.callMethod("open", ["$generatedLink"]);
                          },
                          child: Text("Go to  check"),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
