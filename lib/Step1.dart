import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  List gender = ["Male", "Female", "Other"];
  String select;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  var _formkey = GlobalKey<FormState>();
  String get _name => _nameController.text;
  String get _email => _emailController.text;
  String get _mobile => _emailController.text;
  String get _password => _passwordController.text;

  bool _passwordVisible;
  void _nameEditingComplete() {
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _passwordEditingComplete() {
    FocusScope.of(context).requestFocus(_mobileFocusNode);
  }

  Future _createUser() async {
    try {
      final auth = FirebaseAuth.instance;
      final res = auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException catch (e) {}
  }

  Future _addData() async {
    FirebaseAuth getFireAuthInstance() => FirebaseAuth.instance;
    FirebaseFirestore getFirestoreInstance() => FirebaseFirestore.instance;
    User getCurrentUser() => getFireAuthInstance().currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("users")
        .doc(getCurrentUser().uid)
        .set({"name": _name, "dob": selectedDate, "email": _email}).then((_) {
      print("success!");
    });
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.black,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(
        children: [
          Card(
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: Colors.black),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.teal,
                        key: ValueKey("name"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        decoration: InputDecoration(),
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _nameEditingComplete,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Email Address',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: Colors.black),
                      child: TextFormField(
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
                        decoration: InputDecoration(),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _emailEditingComplete,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Password',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: Colors.black),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.teal,
                        key: ValueKey("password"),
                        validator: (value) {
                          if (value.isEmpty || value.length <= 7) {
                            return 'Please enter a Strong Password';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _passwordEditingComplete,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Mobile number',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: Colors.black),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.teal,
                        key: ValueKey("mobile number"),
                        validator: (value) {
                          if (value.length != 10) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                        controller: _mobileController,
                        focusNode: _mobileFocusNode,
                        decoration: InputDecoration(),
                        autocorrect: false,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Gender',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        addRadioButton(0, 'Male'),
                        addRadioButton(1, 'Female'),
                        addRadioButton(2, 'Others'),
                      ],
                    ),
                    Text(
                      'DOB',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 33,
                            ),
                            onPressed: () {
                              _selectDate(context);
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 55,
            width: 250,
            child: RaisedButton(
              onPressed: () {
                if (_formkey.currentState.validate() == true) {
                  _submit();
                  _createUser();
                  _addData();
                }
              },
              child: Text(
                'Save and Continue',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _submit() {}
