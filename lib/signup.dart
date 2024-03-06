import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                    'Signup',
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
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((val) {
                            print('Successfully signed up!');
                            Navigator.pop(context);
                          }).catchError((err) {
                            print('Failed to sign up');
                          });
                        },
                        child: Text('Sign up'))),
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
