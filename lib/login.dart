import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bootstrap_todo_app/todo_item_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Container(),
          ),
          Expanded(
            flex: 25,
            child: Image(
              image: NetworkImage(
                  'https://www.kadencewp.com/wp-content/uploads/2020/10/alogo-2.png'),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 40,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 65,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          print(emailController.text);
                          print(passwordController.text);

                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((val) {
                            print('Successfully logged in!');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TodoItemListPage()));
                          }).catchError((err) {
                            print('Failed to log in');
                          });
                        },
                        child: Text('Log in'))),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
