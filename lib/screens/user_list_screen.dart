import 'dart:async';
import 'dart:convert';
import 'package:course_project/screens/users_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../course_project.dart';
import '../model/user.dart';
import '../utils/constants.dart';

Future<List<User>> _fetchUsersList() async {
  final response = await http.get(Uri.parse(URL_GET_USERS_LIST));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _usersListView(data) {
  return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _userListTile(context, data[index].name, data[index].email,
            data[index].id, Icons.work);
      });
}

ListTile _userListTile(BuildContext context, String title, String subtitle,
        int id, IconData icon) =>
    ListTile(
        title: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text('$subtitle  id $id'),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => UsersData(id: id),
                //       (BuildContext context) =>UsersScreen(users: [],),
                //     (BuildContext context) =>const UsersData (id: []),
                settings: RouteSettings(
                  arguments: id,
                )),
          );
        });

Widget userListDrawer(context) => Drawer(
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
          Builder(builder: (context) {
            return const ListTile(
              title: Text(
                "Курсовой проект",
                style: TextStyle(
                  color: Color(0xFFfd8505),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
          ListTile(
              leading: const Icon(Icons.one_k),
              title: const Text("Информация о проекте"),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Андрей Дубицкий гр.ЦП_РКПд-21-05"),
                    backgroundColor: Color(0xFFfd8505),
                    duration: Duration(seconds: 6),
                  ),
                );
              }),
          Divider(),
          ListTile(
            leading: const Icon(Icons.one_k),
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

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главный экран"),
        backgroundColor: const Color(0xFFfd8505),
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
      drawer: userListDrawer(context),
      body: Center(
        child: FutureBuilder<List<User>>(
            future: futureUsersList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                usersListData = snapshot.data!;
                return _usersListView(usersListData);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
