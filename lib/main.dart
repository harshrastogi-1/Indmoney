import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> suggestionBishop = [];
  List<int> suggestionRook = [];
  bool isRook = true;
  Random random = Random();
  List<int> value = [0, 1]; //{bishop && rook}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              itemCount: 81,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 9;
                int col = index % 9;

                return Container(
                  alignment: Alignment.center,
                  color:
                      suggestionBishop.contains(index) &&
                              suggestionRook.contains(index)
                          ? Colors.red
                          : suggestionBishop.contains(index) ||
                              value.first == index
                          ? Colors.blue
                          : suggestionRook.contains(index) ||
                              value.last == index
                          ? Colors.yellow
                          : Colors.grey.shade300,
                  child: Text(
                    value.last == index
                        ? "E"
                        : value.first == index
                        ? "B"
                        : " ",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                );
              },
            ),

            ElevatedButton(
              onPressed: () {
                int first = random.nextInt(81);
                int second;
                do {
                  second = random.nextInt(81);
                } while (second == first);
                value[0] = first;
                value[1] = second;
                suggestionRook.clear();
                suggestionBishop.clear();
                showSuggestion(value.first, [
                  [1, 1],
                  [-1, -1],
                  [-1, 1],
                  [1, -1],
                ], false);
                showSuggestion(value.last, [
                  [0, 1],
                  [0, -1],
                  [1, 0],
                  [-1, 0],
                ], true);
              },
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }

  showSuggestion(int index, List<List<int>> directions, bool isRook) {
    int r = index ~/ 9;
    int c = index % 9;
    for (var dir in directions) {
      int nr = r + dir[0];
      int nc = c + dir[1];
      while (nr >= 0 && nr < 9 && nc >= 0 && nc < 9) {
        int index = nr * 9 + nc;
        isRook ? suggestionRook.add(index) : suggestionBishop.add(index);
        nr += dir[0];
        nc += dir[1];
      }
    }
    setState(() {});
  }
}
