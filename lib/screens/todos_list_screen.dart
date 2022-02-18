import 'dart:async';
import 'dart:convert';


import 'package:course_project/model/todos.dart';
import 'package:course_project/screens/users_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../course_project.dart';
import '../model/user.dart';
import '../utils/constants.dart';

Future<List<Todos>> _fetchTodosList() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=1'));
 // final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todos) => Todos.fromJson(todos)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _todoListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _todoListTile(data[index].title, data[index].completed);
      });
}

CheckboxListTile _todoListTile(String title, bool completed) => CheckboxListTile(
    value: completed,
  onChanged: (value) {
//setState(() {
completed = value!;
},
  controlAffinity: ListTileControlAffinity.leading,
//ListTile(
  title: Text(title,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
 // subtitle: Text(title),
 );

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({Key? key}) : super(key: key);

  @override
  _TodosListScreenState createState() => _TodosListScreenState();
}

class _TodosListScreenState extends State<TodosListScreen> {
  late Future<List<Todos>> futureTodosList;
  late List<Todos> todosListData;

  @override
  void initState() {
    super.initState();
    futureTodosList = _fetchTodosList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачи'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const CourseProject(
                      title: '',
                    ),
                  ),
                );
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      drawer: userDataDrawer(context),

      body: Center(
        child: FutureBuilder<List<Todos>>(
            future: futureTodosList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                todosListData = snapshot.data!;
                return _todoListView(todosListData);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })
      ),
    );

  }
}
