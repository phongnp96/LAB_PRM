import 'package:flutter/material.dart';

void main() => runApp(Ex4App());

class Ex4App extends StatefulWidget {
  @override _Ex4AppState createState() => _Ex4AppState();
}

class _Ex4AppState extends State<Ex4App> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exercise 4: Theme'),
          actions: [
            Switch(value: isDark, onChanged: (v) => setState(() => isDark = v))
          ],
        ),
        body: Center(child: Text('Bật tắt công tắc góc phải để đổi màu')),
        floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
      ),
    );
  }
}