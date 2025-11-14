import 'package:flutter/material.dart';
import 'services/back4app_service.dart';
import 'widgets/task_tile.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tasks = [];
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  Future<void> loadTasks() async {
    final data = await Back4AppService.fetchTasks();
    setState(() => tasks = data);
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void openTaskDialog({String? id, String? title, String? description}) {
    titleCtrl.text = title ?? "";
    descCtrl.text = description ?? "";

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(id == null ? "Add Task" : "Update Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              if (id == null) {
                await Back4AppService.addTask(titleCtrl.text, descCtrl.text);
              } else {
                await Back4AppService.updateTask(
                    id, titleCtrl.text, descCtrl.text);
              }
              Navigator.pop(ctx);
              loadTasks();
            },
            child: Text(id == null ? "Add" : "Update"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Back4AppService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTaskDialog(),
        child: const Icon(Icons.add),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text("No tasks available"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                final task = tasks[i];
                return TaskTile(
                  title: task.get("title"),
                  description: task.get("description"),
                  onDelete: () async {
                    await Back4AppService.deleteTask(task.objectId);
                    loadTasks();
                  },
                  onEdit: () {
                    openTaskDialog(
                      id: task.objectId,
                      title: task.get("title"),
                      description: task.get("description"),
                    );
                  },
                );
              },
            ),
    );
  }
}
