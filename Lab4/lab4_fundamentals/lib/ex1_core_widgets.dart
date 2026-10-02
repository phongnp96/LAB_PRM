import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Ex1()));

class Ex1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 1: Core Widgets')),
      body: Column(
        children: [
          Text('Welcome to Flutter UI', style: TextStyle(fontSize: 24)),
          Icon(Icons.movie, size: 50, color: Colors.blue),
          Image.network('https://picsum.photos/200/100'),
          Card(
            child: ListTile(leading: Icon(Icons.star), title: Text('Movie Item')),
          ),
        ],
      ),
    );
  }
}