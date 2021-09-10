import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messfees/services/auth.dart';
import 'package:messfees/screens/loading.dart';



class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage({ required this.toggleView });

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
              label: Text('Login',style: TextStyle(color: Colors.black)),
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
                        'Sign In here',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
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
                  SizedBox(height: 20),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          child: Text('Login'),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            dynamic result = await _auth.registerWithEmailAndPassword(nameController.text,
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
