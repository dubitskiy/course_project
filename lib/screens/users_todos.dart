import 'dart:async';
import 'dart:convert';

import 'package:course_project/model/todos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<Todos>> fetchTodos() async {

  final response = await http
  //    .get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=1'));
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));


  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todos) => Todos.fromJson(todos)).toList();
   // return Todos.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}








ListView usersTodosList(data, userId, title, id, completed, ) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return usersTodosList (context, data[index].userId, data[index].title, data[index].id, data[index].completed);
      }); 
}

ListTile usersTodosTile (BuildContext context, String title, bool completed) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
    ),

    );




class UsersTodos extends StatefulWidget {
  const UsersTodos({Key? key}) : super(key: key);

  @override
  _UsersTodosState createState() => _UsersTodosState();
}

class _UsersTodosState extends State<UsersTodos> {
  late Future<Todos> futureTodos;

  @override
  void initState() {
    super.initState();
   // futureTodos = fetchTodos() as Future<Todos>;
    futureTodos = fetchTodos() as Future<Todos>;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: 'Задачи',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Задачи'),
        ),
        body: Center(
          child: FutureBuilder<Todos>(
            future: futureTodos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {



                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
