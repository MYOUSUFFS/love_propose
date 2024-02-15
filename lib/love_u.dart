import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:love_propose/style/image.dart';
import 'package:love_propose/widget/turkish_btn.dart';

Widget passData(String? data) {
  if (data != null) {
    final decodeData = utf8.fuse(base64).decode("$data");
    print(decodeData);
    final parsedData = Uri.splitQueryString(decodeData);
    return LoveU(
      title: parsedData['title'],
      message: parsedData['message'],
      sno: parsedData['sno'],
      image: int.parse(parsedData['option'] ?? "0"),
    );
  } else {
    return Scaffold(body: Center(child: Text("Error")));
  }
}

class LoveU extends StatefulWidget {
  LoveU({super.key, this.title, this.message, this.sno, required this.image});
  final String? title;
  final String? message;
  final String? sno;
  final int image;

  @override
  State<LoveU> createState() => _LoveUState();
}

class _LoveUState extends State<LoveU> with SingleTickerProviderStateMixin {
  bool correctChoice = false;

  changeTheValue() {
    correctChoice = true;
    Future.delayed(Duration(seconds: 5), () {
      correctChoice = false;
      setState(() {});
    });
    setState(() {});
  }

  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 2))
        ..forward();
  late Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Icon(Icons.menu),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    constraints:
                        const BoxConstraints(minHeight: 100, maxHeight: 500),
                    child: Image.asset(Images.listOfAllBGImages[widget.image]),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      padding: EdgeInsets.all(16),
                      child: AutoSizeText(
                        "${widget.title}" != "null" &&
                                "${widget.title}".isNotEmpty
                            ? utf8.fuse(base64).decode("${widget.title}")
                            : "Do you love me?",
                        style: GoogleFonts.greatVibes(fontSize: 60),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(height: 60),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                          "(If you click this button you can see my message)"),
                    )
                  ],
                ),
                if (correctChoice) ...[
                  Align(
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      'image/enjoy.json',
                      repeat: false,
                    ),
                  ),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 380),
                      child: ScaleTransition(
                        alignment: Alignment.bottomCenter,
                        scale: animation,
                        child: Text(
                          "${widget.message}" != "null" &&
                                  "${widget.message}".isNotEmpty
                              ? utf8.fuse(base64).decode("${widget.message}")
                              : "Just Missuuu!!!",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
                TurkishBtn(
                  top: 122,
                  left: 8,
                  fn: changeTheValue,
                  movingBtnIs: widget.sno == "0" ? true : false,
                  btnStyle: btnStyle1,
                  yesOrNo: 'Yes',
                ),
                TurkishBtn(
                  fn: changeTheValue,
                  movingBtnIs: widget.sno == "1" ? true : false,
                  btnStyle: btnStyle2,
                  yesOrNo: 'No',
                ),
              ],
            ),
          ),
        ));
  }
}

ButtonStyle btnStyle1 = ElevatedButton.styleFrom(
  backgroundColor: Colors.pink,
  foregroundColor: Colors.white,
  disabledBackgroundColor: Colors.pink,
  disabledForegroundColor: Colors.white,
  minimumSize: Size(150, 50),
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);

ButtonStyle btnStyle2 = ElevatedButton.styleFrom(
  enableFeedback: false,
  minimumSize: Size(150, 50),
  backgroundColor: Colors.pink.shade900,
  foregroundColor: Colors.white,
  disabledBackgroundColor: Colors.pink.shade900,
  disabledForegroundColor: Colors.white,
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);
