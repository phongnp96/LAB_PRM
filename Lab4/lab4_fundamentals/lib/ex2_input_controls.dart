import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Ex2()));

class Ex2 extends StatefulWidget {
  @override _Ex2State createState() => _Ex2State();
}

class _Ex2State extends State<Ex2> {
  double val = 50;
  bool sw = true;
  int rad = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 2: Inputs')),
      body: Column(
        children: [
          Slider(value: val, max: 100, onChanged: (v) => setState(() => val = v)),
          SwitchListTile(title: Text('Active?'), value: sw, onChanged: (v) => setState(() => sw = v)),
          RadioListTile(title: Text('Action Movie'), value: 1, groupValue: rad, onChanged: (v) => setState(() => rad = v!)),
          ElevatedButton(
            onPressed: () => showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100)),
            child: Text('Mở Date Picker'),
          )
        ],
      ),
    );
  }
}