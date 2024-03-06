import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_helper.dart';

class TodoItemAddPage extends StatefulWidget {
  const TodoItemAddPage({super.key});

  @override
  State<TodoItemAddPage> createState() => _TodoItemAddPageState();
}

class _TodoItemAddPageState extends State<TodoItemAddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Todo Item Add'),
      ),
      body: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.only(top: 20, bottom: 20),
          //   child: Text(
          //     'Login',
          //     style: TextStyle(
          //       fontSize: 30,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
            child: TextField(
              controller: titleController,
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'TItle'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
            child: TextField(
              controller: descriptionController,
              obscureText: false,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Description'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 65,
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                print(titleController.text);
                print(descriptionController.text);

                if (!checkUserValid()) return;

                FirebaseFirestore.instance
                    .collection(FIRESTORE_COLLECTION_TODO)
                    .add({
                  'owner': FirebaseAuth.instance.currentUser?.email ?? '',
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'created_at': DateTime.now().toString(),
                  'modified_at': DateTime.now().toString(),
                }).then((value) {
                  print('Successfully added todo item.');
                  Navigator.pop(context);
                }).catchError((error) {
                  print('Failed to add todo item.');
                  print(error.toString());
                });
              },
              child: Text('Add Todo Item'),
            ),
          ),
        ],
      ),
    );
  }
}
