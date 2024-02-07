import 'dart:math';

import 'package:flutter/material.dart';

class TurkishBtn extends StatefulWidget {
  const TurkishBtn(
      {super.key,
      this.top = 120,
      this.left = 190,
      required this.btnStyle,
      required this.movingBtnIs,
      required this.fn, required this.yesOrNo});
  final double top;
  final double left;
  final ButtonStyle btnStyle;
  final bool movingBtnIs;
  final void Function()? fn;
  final String yesOrNo;

  @override
  State<TurkishBtn> createState() => _TurkishBtnState();
}

class _TurkishBtnState extends State<TurkishBtn> {
  late double top;
  late double left;

  double? maxTop;
  double? maxleft;

  @override
  void initState() {
    top = widget.top;
    left = widget.left;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fullHight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    maxTop = fullHight - 90;
    maxleft = fullWidth - 130;
    return Positioned(
      top: top,
      left: left,
      child: Listener(
        onPointerDown: (event) {
          updateColor(event);
        },
        onPointerMove: (event) {
          updateColor(event);
        },
        child: Container(
          color: Colors.transparent,
          child: MouseRegion(
            onHover: (event) => setUp(context),
            child: Container(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: widget.movingBtnIs ? null : widget.fn,
                style: widget.btnStyle,
                child: Text(widget.yesOrNo),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateColor(PointerEvent event) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var localPosition = renderBox.globalToLocal(event.position);
    if (localPosition.dx >= 0 &&
        localPosition.dx <= 200 &&
        localPosition.dy >= 0 &&
        localPosition.dy <= 120) {
      setUp(context);
    }
  }

  setUp(BuildContext context) {
    if (widget.movingBtnIs) {
      Random random = Random();
      int genTop = random.nextInt(maxTop!.toInt());
      int genleft = random.nextInt(maxleft!.toInt());

      top = genTop.toDouble();
      left = genleft.toDouble();

      setState(() {});
    }
  }

  void touchUpdate(DragUpdateDetails details) {
    double dx = details.globalPosition.dx.floorToDouble();
    double dy = details.globalPosition.dy.floorToDouble();

    details.localPosition.distance;

    if ((dx.abs() <= top) &&
        (dy.abs() > top - 50) &&
        (dx.abs() <= left) &&
        (dy.abs() > left - 50)) {
      setUp(context);
    }

    debugPrint("$dx $dy");
    // setState(() {});
  }
}
