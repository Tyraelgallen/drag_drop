import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    final showdraggable = color == Colors.black;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DragTarget<Color>(
                onAccept: (data) => setState(() {
                      color = data;
                    }),
                builder: (context, _, __) => Container(
                      color: color,
                      width: 200,
                      height: 200,
                    )),
            IgnorePointer(
              ignoring: !showdraggable,
              child: Opacity(
                opacity: showdraggable ? 1 : 0,
                child: Draggable<Color>(
                  data: Colors.green,
                  feedback: Container(
                    color: Colors.orange,
                    width: 200,
                    height: 200,
                  ),
                  childWhenDragging: Container(
                    color: Colors.red,
                    width: 200,
                    height: 200,
                  ),
                  child: Container(
                    color: Colors.green,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
