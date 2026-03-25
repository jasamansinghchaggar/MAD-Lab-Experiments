import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FileStoragePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FileStoragePage extends StatefulWidget {
  const FileStoragePage({super.key});
  @override
  State<FileStoragePage> createState() => _FileStoragePageState();
}

class _FileStoragePageState extends State<FileStoragePage> {
  String fileData = "No Data";

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/data.txt";
  }

  Future<void> writeData() async {
    final path = await getFilePath();
    File file = File(path);
    await file.writeAsString("Flutter File Storage Example");
  }

  Future<void> readData() async {
    final path = await getFilePath();
    File file = File(path);
    if (await file.exists()) {
      String text = await file.readAsString();
      setState(() {
        fileData = text;
      });
    } else {
      setState(() {
        fileData = "File not found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Storage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fileData),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: writeData,
              child: const Text("Write Data"),
            ),
            ElevatedButton(onPressed: readData, child: const Text("Read Data")),
          ],
        ),
      ),
    );
  }
}
