import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:magic_test/Screens/workout_data_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'model/data_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DataModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const WorkoutDataScreen(),
    );
  }
}


