import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:love_propose/widget/turkish_btn.dart';

class LoveU extends StatefulWidget {
  const LoveU({super.key, this.title, this.message, this.sno});
  final String? title;
  final String? message;
  final String? sno;

  @override
  State<LoveU> createState() => _LoveUState();
}

class _LoveUState extends State<LoveU> with SingleTickerProviderStateMixin {
  bool correctChoice = false;

  changeTheValue() {
    correctChoice = true;
    Future.delayed(const Duration(seconds: 5), () {
      correctChoice = false;
      setState(() {});
    });
    setState(() {});
  }

  late AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..forward();
  late Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Icon(Icons.menu),
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
                    child: Image.asset('image/propose.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      padding: const EdgeInsets.all(16),
                      child: AutoSizeText(
                        "${widget.title}" != "null" &&
                                "${widget.title}".isNotEmpty
                            ? utf8.fuse(base64).decode("${widget.title}")
                            : "Do you love me?",
                        style: GoogleFonts.greatVibes(fontSize: 60),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () => changeTheValue(),
                        style: btnStyle1,
                        child: Text(widget.sno == "1" ? "Yes" : "No"),
                      ),
                    ),
                    const Padding(
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
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
                // TurkishBtn(
                //   sno: widget.sno,
                //   top: 122,
                //   left: 8,
                // ),
                TurkishBtn(sno: widget.sno),
              ],
            ),
          ),
        ));
  }
}
