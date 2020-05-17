import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:review_my_school/Register.dart';

import 'Auth.dart';
import 'Loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  final AuthService _auth = AuthService();
  String password = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.red,
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Login'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Stack(children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Enter a valid E-mail" : null,
                              decoration: InputDecoration(
                                  hintText: "Enter your E-mail",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0))),
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Enter password" : null,
                              decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0))),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 15.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.pink[400],
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result =
                                          await _auth.loginWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error =
                                              'Please providr a valid email and password';
                                        });
                                      }
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 15.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.teal,
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () async {},
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Forgot Password ?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                            child: Container(
                              height: 270.0,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset('images/school.jpg'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          );
  }
}
