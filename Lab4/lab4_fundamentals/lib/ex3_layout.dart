import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Ex3()));

class Ex3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 3: Layout')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Trái'), Text('Phải')],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [Text('Phim Avatar'), Text('Phim Joker')],
              ),
            )
          ],
        ),
      ),
    );
  }
}