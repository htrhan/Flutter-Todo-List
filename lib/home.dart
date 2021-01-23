import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todo = [];
  String addTodo = "";

  void deleteTodo(int index) {
    setState(() {
      todo.removeAt(index);
    });
  }

  Widget deleteNote(int index) {
    return AlertDialog(
      title: Text('Delete Todo'),
      content: Text('Are you sure want to delete this todo ? '),
      actions: [
        TextButton(
          onPressed: () {
            deleteTodo(index);
            Navigator.of(context).pop(true);
          },
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.green),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget buildTodo() {
    return ListView.separated(
        itemCount: todo.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 5.0,
              color: Colors.red,
            ),
        itemBuilder: (context, index) {
          if (index < todo.length) {
            return buildscreenTodo(todo[index], index);
          }
        });
  }

  Widget buildscreenTodo(String todoItem, int index) {
    return Dismissible(
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Align(
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
      key: ValueKey(todo[index].length),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        final result = await showDialog(
          context: context,
          builder: (_) => deleteNote(index),
        );
        return result;
      },
      confirmDismiss: (direction) async {
        final result = await showDialog(
          context: context,
          builder: (_) => deleteNote(index),
        );
        return result;
      },
      child: ListTile(
        title: Text(
          todoItem,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
      ),
      body: buildTodo(),
      floatingActionButton: FloatingActionButton(
        onPressed: routeCreatePage,
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }

  void routeCreatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => addNewTodo(),
      ),
    );
  }

  void newTodoHandler(String todo) {
    setState(() {
      if (todo.length > 0) {
        addTodo = todo;
      }
    });
  }

  void addTodoHandler(String text) {
    setState(() {
      if (text.length > 0) {
        todo.add(text);
      }
    });
  }

  Widget addNewTodo() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Add new todo..'),
              onChanged: (val) {
                setState(() {
                  newTodoHandler(val);
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                ),
                onPressed: () {
                  setState(() {
                    addTodoHandler(addTodo);
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
