import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTask extends StatefulWidget {
  final Map? todo;
  const AddTask({super.key, this.todo});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (widget.todo != null) {
      isEdit = true;
      // final title = todo['title'];
      // final description = todo['description'];

      // titleController.text = title;
      // descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Todo" : "Add Task"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Text(isEdit ? "Update" : "Submit"),
            ),
          )
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //get the date=a from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    //submit data to the server
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body), // Correction ici
      headers: {"Content-Type": "application/json"},
    );

    //show message success or fail based on status
    if (response.statusCode == 201) {
      showSuccessMessage("Tache ajouté avec success");
      titleController.text = "";
      descriptionController.text = "";
    } else {
      showErrorMessage("Erreur lors de l'ajoout");
    }
  }

  Future<void> updateData() async {
    //get the date=a from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    //submit data to the server
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body), // Correction ici
      headers: {"Content-Type": "application/json"},
    );

    //show message success or fail based on status
    if (response.statusCode == 201) {
      showSuccessMessage("Tache ajouté avec success");
      titleController.text = "";
      descriptionController.text = "";
    } else {
      showErrorMessage("Erreur lors de l'ajoout");
    }
  }

  void showSuccessMessage(String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void showErrorMessage(String message) {
    final snackbar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
