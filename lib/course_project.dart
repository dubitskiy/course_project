import 'package:course_project/screens/user_list_screen.dart';
import 'package:flutter/material.dart';

class CourseProject extends StatefulWidget {
  const CourseProject({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  CourseProjectState createState() {
    return CourseProjectState();
  }
}

class CourseProjectState extends State<CourseProject> {
  final _formKey = GlobalKey<FormState>();
  String? phonenumber;
  String? password;

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(color: const Color(0xFFbbbbbb), width: 2));
    const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF0079D0),
    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            onChanged: () {
              Form.of(primaryFocus!.context!)!.save();
            },
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image:
                    AssetImage("assets/pexels-polina-tankilevitch-3905884.jpg"),
                fit: BoxFit.cover,
              )),
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 80,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    child: Image.network(
                        "https://dstom4.ru/wp-content/uploads/2016/05/logo.png"),
                  ),
                  const Text(
                      "  Санкт-Петербургское государственное бюджетное учреждение здравоохранения  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9AC100),
                        backgroundColor: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      )),
                  const Divider(),
                  const SizedBox(
                    height: 60,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Введите логин '123' и пароль '111'",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                       return "Введите номер телефона";

                      }
                    },
                    keyboardType: TextInputType.text,
                    onSaved: (value) => phonenumber = value,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Телефон',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (value) => password = value!,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Пароль',
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: 154,
                    height: 42,
                    child: Builder(builder: (context) {
                      return Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () {
                            if (phonenumber == "123" && password == '111') {
                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                     //     const MainScreen()));
                              const UsersListScreen()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Ошибка ввода данных"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          },
                          child: Text('Войти'),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0079D0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38.0),
                            ),
                          ),
                        );
                      });
                    }),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
