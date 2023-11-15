import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const TextField(
            decoration: InputDecoration(hintText: "Title"),
          ),
          const TextField(
            decoration: InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: const Text("Submit"))
        ],
      ),
    );
  }
}
