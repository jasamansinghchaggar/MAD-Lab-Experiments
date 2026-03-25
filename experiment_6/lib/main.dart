import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() {
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: DBPage());
  }
}

class DBPage extends StatefulWidget {
  const DBPage({super.key});
  @override
  State<DBPage> createState() => _DBPageState();
}

class _DBPageState extends State<DBPage> {
  late Database db;
  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'student.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite Demo')),
      body: const Center(child: Text('Database Created Successfully')),
    );
  }
}
