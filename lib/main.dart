import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do you love me!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoveU(),
    );
  }
}

class LoveU extends StatefulWidget {
  const LoveU({super.key});

  @override
  State<LoveU> createState() => _LoveUState();
}

class _LoveUState extends State<LoveU> with SingleTickerProviderStateMixin {
  double top = 78;
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
    animationController.dispose();
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Will you marry me?",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () => changeTheValue(),
                        child: Text("No"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.pink,
                          minimumSize: Size(150, 50),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
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
                        "Congratulations you are doing good job.",
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
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50),
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
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
