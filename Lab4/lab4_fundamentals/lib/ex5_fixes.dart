import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Ex5()));

class Ex5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 5: Fixes')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Text('Danh sách phim:'),
              Expanded(
                child: ListView(
                  children: [Text('Phim A'), Text('Phim B')],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}