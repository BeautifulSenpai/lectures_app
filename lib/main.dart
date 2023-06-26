import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lectures App123',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List lectures = [];

  @override
  void initState() {
    super.initState();
    fetchLectures();
  }

  Future<void> fetchLectures() async {
    final response = await http.get(Uri.parse('http://localhost:5000/lectures'));
    if (response.statusCode == 200) {
      setState(() {
        lectures = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lectures[index]['title']),
            subtitle: Text(lectures[index]['description']),
          );
        },
      ),
    );
  }
}
