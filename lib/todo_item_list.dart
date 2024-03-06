import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_todo_app/todo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bootstrap_todo_app/todo_item_detail.dart';

import 'firebase_helper.dart';

class TodoItemListPage extends StatefulWidget {
  const TodoItemListPage({super.key});

  @override
  State<TodoItemListPage> createState() => _TodoItemListPageState();
}

class _TodoItemListPageState extends State<TodoItemListPage> {
  var todos = <TodoItem>[];

  _TodoItemListPageState() {
    if (!checkUserValid()) return;
    FirebaseFirestore.instance
        .collection(FIRESTORE_COLLECTION_TODO)
        .orderBy('modified_at', descending: true)
        .snapshots()
        .listen((event) {
      print('');
      todos = [];
      event.docs.forEach((element) {
        if (!element.data().keys.contains('title')) {
          element.data()['title'] = '';
        }
        if (!element.data().keys.contains('description')) {
          element.data()['description'] = '';
        }
        print(element.data());
        todos.add(TodoItem(
            title: element.data()['title'] ?? '',
            description: element.data()['description'] ?? ''));
        setState(() {});
      });
    }).onError((err) => print('Listen failed: $err'));
  }

  void refreshTodoList() {
    if (!checkUserValid()) return;

    FirebaseFirestore.instance
        .collection('todo-items')
        .where('owner', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .orderBy('modified_at', descending: true)
        .get()
        .then((querySnapshot) {
      todos = [];
      querySnapshot.docs.forEach((element) {
        print(element);
        if (!element.data().keys.contains('title')) {
          element.data()['title'] = '';
        }
        if (!element.data().keys.contains('description')) {
          element.data()['description'] = '';
        }
        print(element.data());
        todos.add(TodoItem(
            title: element.data()['title'] ?? '',
            description: element.data()['description'] ?? ''));
        print("Successfully loaded all todo items.");
      });
      setState(() {});
    }).catchError((error) {
      print('Failed to load all the the todos.');
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Todo Item List'),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  // contentPadding: EdgeInsets.all(8),
                  tileColor: Colors.amber[500],
                  title: Text(
                    '${todos[index].title}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${todos[index].description}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TodoItemDetailPage(todoItem: todos[index])));
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refreshTodoList();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
