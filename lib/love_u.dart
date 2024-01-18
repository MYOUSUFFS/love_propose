import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoveU extends StatefulWidget {
  const LoveU({super.key, this.title, this.message, this.sno});
  final String? title;
  final String? message;
  final String? sno;

  @override
  State<LoveU> createState() => _LoveUState();
}

class _LoveUState extends State<LoveU> with SingleTickerProviderStateMixin {
  double top = 92;
  double? right;

  double? maxTop;
  double? maxRight;

  setUp(BuildContext context) {
    var _random = Random();
    int _genTop = _random.nextInt(maxTop!.toInt());
    int _genRight = _random.nextInt(maxRight!.toInt());

    top = _genTop.toDouble();
    right = _genRight.toDouble();

    setState(() {});
  }

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
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..forward();
  late Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  @override
  void dispose() {
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullHight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    maxTop = fullHight - 90;
    maxRight = fullWidth - 130;
    return Scaffold(
        drawer: Icon(Icons.menu),
        body: Container(
          width: fullWidth,
          child: Stack(
            children: [
              Container(
                height: fullHight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "${widget.title}" != "null" ||
                                "${widget.title}".isNotEmpty
                            ? "${utf8.fuse(base64).decode("${widget.title}")}"
                            : "Do you love me?",
                        style: GoogleFonts.greatVibes(
                          fontSize: 60,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () => changeTheValue(),
                        child: Text(widget.sno == "1" ? "Yes" : "No"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          minimumSize: Size(150, 50),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                          "(If you click this button you can see my message)"),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset('image/propose.png'),
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
                    constraints: BoxConstraints(maxWidth: 380),
                    child: ScaleTransition(
                      alignment: Alignment.bottomCenter,
                      scale: animation,
                      child: Text(
                        "${widget.message}" != "null" ||
                                "${widget.message}".isNotEmpty
                            ? "${utf8.fuse(base64).decode("${widget.message}")}"
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
              Positioned(
                top: top,
                right: right,
                left: right == null ? 190 : null,
                child: MouseRegion(
                  onHover: (event) => setUp(context),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(widget.sno == "0" ? "Yes" : "No"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.pink,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
