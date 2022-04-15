import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screen/map.dart';
import 'package:busproject/Register/login.dart';


class Register extends StatefulWidget {
  static const id = 'Register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String _username, _firstname, _lastname, _email, _password, _street;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9AE5D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF9AE5D),
              borderRadius: const BorderRadius.only(),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Text(
                    'Bus Station',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff03071E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.3,
              decoration: BoxDecoration(
                color: Color(0xff03071E),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(420),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 350),
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF9AE5D)),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Fields(
                        type: TextInputType.name,
                        star: false,
                        onChanged: (String value) {
                          _username = value;
                        },
                        name: 'user name',
                      ),

                      Fields(
                        type: TextInputType.name,
                        star: false,
                        onChanged: (String value) {
                          _firstname = value;
                        },
                        name: 'first name',
                      ),

                      Fields(
                        type: TextInputType.name,
                        star: false,
                        onChanged: (String value) {
                          _lastname = value;
                        },
                        name: 'last name',
                      ),

                      Fields(
                        type: TextInputType.emailAddress,
                        star: false,
                        onChanged: (String value) {
                          _email = value;
                        },
                        name: 'email',
                      ),

                      Fields(
                        type: TextInputType.name,
                        star: true,
                        onChanged: (String value) {
                          _password = value;
                        },
                        name: 'password',
                      ),

                      Fields(
                        onChanged: (String value) {
                          _street = value;
                        }, 
                        name: 'street', 
                        type: TextInputType.name, 
                        star: false
                        ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     style: TextStyle(color: Colors.white),
                      //     keyboardType: TextInputType.name,
                      //     decoration: const InputDecoration(
                      //       hintText: 'User Name',
                      //       hintStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     onChanged: (String value) {
                      //       _username = value;
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     style: TextStyle(color: Colors.white),
                      //     keyboardType: TextInputType.emailAddress,
                      //     decoration: const InputDecoration(
                      //       hintText: 'Email',
                      //       hintStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     onChanged: (value) {
                      //       setState(
                      //         () {
                      //           _email = value.trim();
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     style: TextStyle(color: Colors.white),
                      //     obscureText: true,
                      //     decoration: const InputDecoration(
                      //       hintText: 'Password',
                      //       hintStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     onChanged: (value) {
                      //       setState(
                      //         () {
                      //           _password = value.trim();
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     style: TextStyle(color: Colors.white),
                      //     keyboardType: TextInputType.name,
                      //     decoration: const InputDecoration(
                      //       hintText: 'first name',
                      //       hintStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     onChanged: (String value) {
                      //       _firstname = value;
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     style: TextStyle(color: Colors.white),
                      //     keyboardType: TextInputType.name,
                      //     decoration: const InputDecoration(
                      //       hintText: 'last name',
                      //       hintStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     onChanged: (String value) {
                      //       _lastname = value;
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     style: TextStyle(color: Colors.white),
                      //     keyboardType: TextInputType.name,
                      //     decoration: const InputDecoration(
                      //       hintText: 'street',
                      //       hintStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     onChanged: (String value) {
                      //       _street = value;
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffF9AE5D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(width: 2, color: Color(0xff03071E)),
                          minimumSize: Size.fromHeight(60),
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff03071E),
                          ),
                        ),
                        onPressed: () async {
                          await _auth
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then(
                            (value) async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(value.user!.uid)
                                  .set({
                                'name': _username,
                                'first': _firstname,
                                'last': _lastname,
                                'street': _street,
                                'role': false,
                              });

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserChooseLocation()));
                            },
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(width: 2, color: Color(0xff03071E)),
                          minimumSize: Size.fromHeight(60),
                        ),
                        child: Text(
                          'Regester',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff03071E),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Fields extends StatelessWidget {
  Fields(
      {Key? key,
      required this.onChanged,
      required this.name,
      required this.type,
      required this.star})
      : super(key: key);

  
  final Function(String) onChanged;
  final String name;
  final TextInputType type;
  final bool star;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        keyboardType: type,
        obscureText: star,
        decoration: InputDecoration(
          hintText: (' please insert your $name '),
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
