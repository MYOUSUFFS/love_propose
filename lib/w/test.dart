import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myself/myself.dart';

class GestureDetectorPage extends StatelessWidget {
  const GestureDetectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        height: double.infinity,
        child: const MainContent(),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  GlobalKey key = GlobalKey();

  String dragDirection = '';
  String startDXPoint = '50';
  String startDYPoint = '50';
  String? dXPoint;
  String? dYPoint;
  String? velocity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStartHandler,
      onVerticalDragStart: _onVerticalDragStartHandler,
      onHorizontalDragUpdate: _onDragUpdateHandler,
      onVerticalDragUpdate: _onDragUpdateHandler,
      onHorizontalDragEnd: _onDragEnd,
      onVerticalDragEnd: _onDragEnd,
      dragStartBehavior: DragStartBehavior.start, // default
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Positioned(
              left: double.parse(startDXPoint),
              top: double.parse(startDYPoint),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Draggable',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _onHorizontalDragStartHandler(DragStartDetails details) {
    MySelfColor().printHex("000000", "_onHorizontalDragStartHandler");
    setState(() {
      dragDirection = "HORIZONTAL";
      startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  /// Track starting point of a vertical gesture
  void _onVerticalDragStartHandler(DragStartDetails details) {
    MySelfColor().printHex("000000", "_onVerticalDragStartHandler");

    setState(() {
      dragDirection = "VERTICAL";
      startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  void _onDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      dragDirection = "UPDATING";
      startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  /// What should be done at the end of the gesture ?
  void _onDragEnd(DragEndDetails details) {
    double result = details.velocity.pixelsPerSecond.dx.abs().floorToDouble();
    setState(() {
      velocity = '$result';
    });
  }
}

class MyContainerScreen extends StatelessWidget {
  const MyContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Container Example'),
      ),
      body: const MyContainer(),
    );
  }
}

class MyContainer extends StatefulWidget {
  const MyContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  bool isInsideContainer = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        updateColor(event);
      },
      onPointerMove: (event) {
        updateColor(event);
      },
      child: Container(
        width: 80,
        height: 20,
        color: isInsideContainer ? Colors.green : Colors.blue,
        child: const Center(
          child: Text(
            'Drag me!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void updateColor(PointerEvent event) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var localPosition = renderBox.globalToLocal(event.position);
    if (localPosition.dx >= 0 &&
        localPosition.dx <= 80 &&
        localPosition.dy >= 0 &&
        localPosition.dy <= 20) {
      setState(() {
        isInsideContainer = true;
      });
    } else {
      setState(() {
        isInsideContainer = false;
      });
    }
  }
}
