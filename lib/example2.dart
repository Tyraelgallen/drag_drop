import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final Map<String, bool> score = {};

  final Map choices = {
    "Manzana": Colors.red,
    "Naranja": Colors.orange,
    "Pera": Colors.green,
    "Uva": Colors.purple,
    "Banana": Colors.yellow,
    "Coco": Colors.brown,
  };

  int seed = 0;

  String nombre(dynamic color) {
    if (color == Colors.red) {
      return "ROJO";
    } else if (color == Colors.orange) {
      return "NARANJA";
    } else if (color == Colors.green) {
      return "VERDE";
    } else if (color == Colors.purple) {
      return "MORADO";
    } else if (color == Colors.yellow) {
      return "AMARILLO";
    } else if (color == Colors.brown) {
      return "MARRON";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Drag & Drop"),
            Text("Score ${score.length} /6"),
          ],
        ),
        backgroundColor: Colors.pink,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: choices.keys.map((fruit) {
              return Container(
                width: 100,
                color: Colors.pink[300],
                child: Draggable<String>(
                  data: fruit,
                  feedback: Fruit(fruit: fruit),
                  childWhenDragging: const SizedBox(),
                  child: Fruit(
                    fruit: score[fruit] == true ? "" : fruit,
                  ),
                ),
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                choices.keys.map((fruit) => _buildTargetColor(fruit)).toList()
                  ..shuffle(Random(seed)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildTargetColor(fruit) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        if (score[fruit] == true) {
          return Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            height: 80,
            width: 200,
            child: const Text("Correcto!"),
          );
        } else {
          return Container(
            color: choices[fruit],
            child: Center(child: Text(nombre(choices[fruit]))),
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == fruit,
      onAccept: (data) {
        setState(() {
          score[fruit] = true;
        });

        print("correcto!");
      },
      onLeave: (data) {},
    );
  }
}

class Fruit extends StatelessWidget {
  const Fruit({super.key, required this.fruit});

  final String fruit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: const EdgeInsets.all(10),
        child: Text(
          fruit,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
