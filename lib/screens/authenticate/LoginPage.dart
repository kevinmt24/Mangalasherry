import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messfees/services/auth.dart';
import 'package:messfees/screens/loading.dart';


class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({ required this.toggleView });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController  emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text('Mangalassery'),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register',style: TextStyle(color: Colors.black),),
              onPressed: () => widget.toggleView(),
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key : _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 80),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO: Complete Forgot Password method
                    },
                    child: Text('Forgot Password'),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: Text('Login'),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic result = await _auth.signInWithEmailAndPassword(
                              emailController.text, passwordController.text);
                          if(result == null)
                            setState(() {
                              isLoading = false;
                              error = 'Could not Sign In';
                            });
                        }
                      )),
                  SizedBox(height: 20),
                  Text(
                    error,
                    style: TextStyle(color:Colors.red,fontSize: 14),
                  )
                ],
              ),
            )));
  }
}
