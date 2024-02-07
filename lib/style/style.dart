import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height / 5);
    path.cubicTo(
        size.width / 2,
        0, // Control point 1
        size.width,
        0, // Control point 2
        size.width,
        size.height / 5); // End point

    path.cubicTo(
        size.width,
        2 * size.height / 3, // Control point 3
        size.width / 2,
        size.height, // Control point 4
        size.width / 2,
        size.height); // End point

    path.cubicTo(
        size.width / 2,
        size.height, // Control point 5
        0,
        2 * size.height / 3, // Control point 6
        0,
        size.height / 5); // End point

    path.cubicTo(
        0,
        0, // Control point 7
        size.width / 2,
        0, // Control point 8
        size.width / 2,
        size.height / 5); // End point

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HeartShapedButton extends StatelessWidget {
  final Function()? onPressed;

  const HeartShapedButton({super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      // () {
      //   // Add your button onPressed logic here
      // },
      style: OutlinedButton.styleFrom(
          // backgroundColor: Colors.red.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
          padding: const EdgeInsets.all(42.0),
          side: const BorderSide(
            color: Colors.transparent, // Set the outline color
          ),
          elevation: 13),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(100, 100),
              painter: HeartPainter(),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Submit",
                style:
                    GoogleFonts.greatVibes(color: Colors.white, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red // Set the fill color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(size.width / 2, size.height / 5);
    path.cubicTo(
      size.width / 2,
      0,
      size.width,
      0,
      size.width,
      size.height / 5,
    );
    path.cubicTo(
      size.width,
      2 * size.height / 3,
      size.width / 2,
      size.height,
      size.width / 2,
      size.height,
    );
    path.cubicTo(
      size.width / 2,
      size.height,
      0,
      2 * size.height / 3,
      0,
      size.height / 5,
    );
    path.cubicTo(
      0,
      0,
      size.width / 2,
      0,
      size.width / 2,
      size.height / 5,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
