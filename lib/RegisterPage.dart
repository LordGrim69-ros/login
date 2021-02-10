import 'package:flutter/material.dart';
import 'package:lendigi/Step1.dart';

import 'Step2.dart';
import 'Step3.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final snackBar = SnackBar(content: Text('Email is already registered'));
  int number;

  @override
  void initState() {
    number=0;

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
                    height: 65,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                number=1;
                              });
                            },
                            child: Text('Step 1',style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: number==1|| number ==0? Colors.red : Colors.teal,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                              height: 5,
                              width: 55,
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                number=2;
                              });
                            },
                            child: Text('Step 2',style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: number==2? Colors.red : Colors.teal,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            height: 5,
                            width: 55,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                number=3;
                              });
                            },
                            child: Text('Step 3',style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: number==3? Colors.red : Colors.teal,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            height: 5,
                            width: 55,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if(number==1 || number == 0)
                    Step1(),
                  if(number == 2)
                    Step2(),
                  if(number==3)
                    Step3(),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
