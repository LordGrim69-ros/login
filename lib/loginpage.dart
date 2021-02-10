import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lendigi/RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _password1FocusNode = FocusNode();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool _passwordVisible;
  final snackBar = SnackBar(content: Text('Email is already registered'));
  String hello;
  int please;

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print('error: $e');
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_password1FocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/Group 3.png"),
              alignment: Alignment.bottomRight),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Group2.png'),
                  alignment: Alignment.topLeft),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  SizedBox(
                    child: Image.asset('assets/2.png'),
                    height: 300,
                    width: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.teal,
                            key: ValueKey("email"),
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              contentPadding: const EdgeInsets.all(8.0),
                              errorBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelText: 'Email or Phone',
                              errorStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: _emailEditingComplete,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.030,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.teal,
                            key: ValueKey("password1"),
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Please enter atleast 7 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              contentPadding: const EdgeInsets.all(8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelText: 'Password',
                              errorStyle: TextStyle(
                                color: Colors.red,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            controller: _passwordController,
                            focusNode: _password1FocusNode,
                            textInputAction: TextInputAction.done,
                            obscureText: !_passwordVisible,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            width: 135,
                            height: 42,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Colors.teal,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState.validate() ==
                                      true) {
                                    _loginUser();
                                  }
                                }),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          FlatButton(
                            child: Text(
                              'New user?',
                              style: TextStyle(color: Colors.teal),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RegisterPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
