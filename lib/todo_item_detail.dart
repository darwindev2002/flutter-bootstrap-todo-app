import 'package:flutter/material.dart';

class TodoItemDetailPage extends StatefulWidget {
  var todoItem;

  TodoItemDetailPage({super.key, this.todoItem});

  @override
  State<TodoItemDetailPage> createState() => _TodoItemDetailPageState();
}

class _TodoItemDetailPageState extends State<TodoItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Todo Item Detail'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.todoItem.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.todoItem.description,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
