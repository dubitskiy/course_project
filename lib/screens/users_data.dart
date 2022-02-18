import 'dart:async';
import 'dart:convert';

import 'package:course_project/screens/todos_list_screen.dart';
import 'package:course_project/model//user.dart';
import 'package:course_project/model//address.dart';
import 'package:course_project/screens/user_list_screen.dart';
import 'package:course_project/screens/users_todos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../course_project.dart';

Future<User> fetchUsers() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Widget userDataDrawer(context) => Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.white10,
        ),
        child: Container(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(50.0))),
                  child: Image.network(
                      "https://dstom4.ru/wp-content/uploads/2016/05/logo.png"),
                ),
                const Text(
                    "Санкт-Петербургское государственное бюджетное учреждение здравоохранения",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9AC100),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    )),
              ]),
        ),
      ),
    //  Builder(builder: (context) {
    //    return const ListTile(
        const ListTile(
          title: Text(
            "Курсовой проект",
            style: TextStyle(
              color: Color(0xFFfd8505),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    //  }),


      ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text("Назад"),
       //  title: Text(snapshot.data!.address.street),
          onTap: () {
            Navigator.of(context).pop();
          }),
      Divider(),
      ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text("Выход"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const CourseProject(
                  title: '',
                )),
          );
        },
      ),
    ],
  ),
);


class UsersData extends StatefulWidget {
  const UsersData({Key? key, required id}) : super(key: key);

  @override
  _UsersDataState createState() => _UsersDataState();
}

class _UsersDataState extends State<UsersData> {
  late Future<User> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override

  Widget build(BuildContext context) {

//    final id  = ModalRoute.of(context)!.settings.arguments as User;
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Информация'),
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
          child: FutureBuilder<User>(
            future: futureUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return   ListView(
                  children:  <Widget>[

                    ListTile(
                      leading: Icon(Icons.photo_album),
                      title: Text(snapshot.data!.name),
                    ),
                    ListTile(
                      leading: const Icon(Icons.accessibility),
                      title: Text(snapshot.data!.username),
                      subtitle: const Text('username'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(snapshot.data!.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(snapshot.data!.phone),
                    ),

                     ListTile(
                      title: const Text("Задачи пользователя"),
                       leading: const Icon(Icons.exit_to_app),
                       tileColor: Colors.lightBlue,
                        textColor: Colors.white,
                       shape: RoundedRectangleBorder(
                        // side: BorderSide(color: Colors.yellow, width: 3),
                         borderRadius: BorderRadius.circular(90),
                       ),
                       //ShapeBorder (),
                      //visualDensity: ,
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                           (BuildContext context) => TodosListScreen(),

                            //settings: RouteSettings(
                             // arguments: id ,)

                        ),);

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.apartment),
                      trailing: Text(snapshot.data!.address.suite),
                      title: Text(snapshot.data!.address.city),
                      subtitle: Text(snapshot.data!.address.street),
                    ),
                  ],
                );
               // return Text(snapshot.data!.username);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
