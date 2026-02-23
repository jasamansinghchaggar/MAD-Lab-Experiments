import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RSSPage(),
    );
  }
}

class RSSPage extends StatefulWidget {
  const RSSPage({super.key});

  @override
  State<StatefulWidget> createState() => _RSSPageState();
}

class _RSSPageState extends State<RSSPage> {
  String data = "loading...";

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse("https://www.w3shcools.com/xml/note.xml"),
    );

    setState(() {
      data = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RSS Feed")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(data)),
      ),
    );
  }
}
