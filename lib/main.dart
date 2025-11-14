import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'services/back4app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Back4AppService.initializeParse();
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
