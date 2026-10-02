import 'package:flutter/material.dart';

import 'ex1_core_widgets.dart';
import 'ex2_input_controls.dart';
import 'ex3_layout.dart';
import 'ex4_app_structure.dart';
import 'ex5_fixes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Builder(
          builder: (BuildContext innerContext) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Lab 4 - Flutter UI Fundamentals'),
                actions: [
                  Switch(
                      value: isDark,
                      onChanged: (val) => setState(() => isDark = val)
                  ),
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildMenuBtn(innerContext, 'Exercise 1 - Core Widgets Demo', Ex1()),
                  _buildMenuBtn(innerContext, 'Exercise 2 - Input Controls Demo', Ex2()),
                  _buildMenuBtn(innerContext, 'Exercise 3 - Layout Demo', Ex3()),
                  _buildMenuBtn(innerContext, 'Exercise 4 - App Structure & Theme', Ex4App()),
                  _buildMenuBtn(innerContext, 'Exercise 5 - Common UI Fixes', Ex5()),
                ],
              ),
            );
          }
      ),
    );
  }

  Widget _buildMenuBtn(BuildContext context, String title, Widget screen) {
    return Card(
      elevation: 0,
      color: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen)
          );
        },
      ),
    );
  }
}