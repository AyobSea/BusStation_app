import 'package:busproject/Register/register_styles.dart';
import 'package:busproject/adminside/admin_home.dart';
import 'package:busproject/screen/home_screen.dart';
import 'package:busproject/screen/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';


class LoginScreen extends StatefulWidget {
  static var id;

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _username, _firstname, _lastname, _email, _password, _street;
  final _auth = FirebaseAuth.instance;

  static const id = 'Login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: busBackground,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(color: busBackground),
            child: Center(
              child: Image(image: AssetImage('images/logo2.jpg')),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.3,
              decoration: BoxDecoration(
                color: busclay,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5000),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 350),
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      
                      Row(
                        children: [
                      //     Container(
                        
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: busyellow
                      //     ),
                      //     child: Text('cfg'),
                      // ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(50),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: busBackground
                              ),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold,
                                  color: busclay
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 30),
                      LoginFields(
                        icon: Icon(Icons.person, color: Colors.white,),
                        type: TextInputType.emailAddress,
                        star: false,
                        onChanged: (String value) {
                          _email = value;
                        },
                        name: 'an email',
                      ),
                      LoginFields(
                        icon: Icon(Icons.lock, color: Colors.white),
                        type: TextInputType.name,
                        star: true,
                        onChanged: (String value) {
                          _password = value;
                        },
                        name: 'a password',
                      ),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: secondButton,
                            child: Text(
                              'LOGIN',
                              style:
                                  bText
                            ),
                            onPressed: () {
                              _auth
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then(
                                (_) {
                                  checkRole();
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => const Map()));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '────── or ──────',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              style: firstButton,
                              child: Text(
                                'Regester',
                                style:
                                    bText
                              ),
                              onPressed: () {
                                showSheet();
                                // Navigator.pushNamed(context, Register.id);
                              }),
                          const SizedBox(height: 20),
                          TextButton(
                              onPressed: () {
                                showSheet();
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ManagePage()));
                              },
                              child:
                                  const Text('do u have an account ? Register'))
                        ],
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

  checkRole() async {
    final isAdmin = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => value.data()!['role']);

    if (isAdmin) {
      return Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) =>  AdminHomePage()));
    } else {
      return Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  Future showSheet() => showSlidingBottomSheet(
    context,
      builder: (context) => SlidingSheetDialog(
          snapSpec: const SnapSpec(
            // initialSnap: 1,
            snappings: [0.2, 0.7, 1],
            // snap: false,
          ),
          headerBuilder: (context, state) {
            return Container(
              color: busIcon,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: busblackBlue
              //   )
              // ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      height: 8,
                      width: 32,
                      // color: Colors.green,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
          builder: buildSheet
          )
          );
         Widget buildSheet(context, state) => Material(
          child: Container(
        color: busclay,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Register',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: busIcon),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 26),
              child: Fields(
                fill: busbottom,
                icon: Icon(Icons.person, color: busclay),
                type: TextInputType.name,
                star: false,
                onChanged: (String value) {
                  _username = value;
                },
                name: 'a user name',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 26),
              child: Fields(
                fill: busbottom,
                icon: Icon(Icons.person, color: busclay),
                type: TextInputType.name,
                star: false,
                onChanged: (String value) {
                  _firstname = value;
                },
                name: 'your first name',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 26),
              child: Fields(
                fill: busbottom,
                icon: Icon(Icons.person, color: busclay),
                type: TextInputType.name,
                star: false,
                onChanged: (String value) {
                  _lastname = value;
                },
                name: 'your last name',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 26),
              child: Fields(
                fill: busbottom,
                icon: Icon(Icons.person, color: busclay),
                type: TextInputType.emailAddress,
                star: false,
                onChanged: (String value) {
                  _email = value;
                },
                name: 'an email',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 26),
              child: Fields(
                fill: busbottom,
                icon: Icon(Icons.lock, color: busclay),
                type: TextInputType.name,
                star: true,
                onChanged: (String value) {
                  _password = value;
                },
                name: 'password',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 26),
              child: Fields(
                fill: busbottom,
                icon: Icon(Icons.person, color: busclay),
                  onChanged: (String value) {
                    _street = value;
                  },
                  name: 'the street',
                  type: TextInputType.name,
                  star: false),
            ),
            const SizedBox(height: 25),
            Container(
              width: 360,
              child: ElevatedButton(
                style: secondButton,
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24,
                    color: busblackBlue,
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
                          builder: (context) => const UserChooseLocation()
                          )
                          );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 360,
              child: ElevatedButton(
                style: firstButton,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    color: busblackBlue,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      )
      );
}

class Fields extends StatelessWidget {
  Fields(
      {Key? key,
      required this.onChanged,
      required this.name,
      required this.type,
      required this.star, 
      required this.icon, required this.fill})
      : super(key: key);

  final Function(String) onChanged;
  final String name;
  final TextInputType type;
  final bool star;
  final Icon icon;
  final Color fill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          style: TextStyle(color: busclay),
          keyboardType: type,
          obscureText: star,
          decoration: InputDecoration(
            filled: true,
            fillColor: fill,
             prefixIcon: icon, 
            // focusColor: Colors.white,
            hintText: (' Enter $name '),
            hintStyle:  TextStyle(
                color: busclay,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: busclay),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: busclay),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}


class LoginFields extends StatelessWidget {
  LoginFields(
      {Key? key,
      required this.onChanged,
      required this.name,
      required this.type,
      required this.star, 
      required this.icon})
      : super(key: key);

  final Function(String) onChanged;
  final String name;
  final TextInputType type;
  final bool star;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 300),
          child: TextField(
            style: TextStyle(color: Colors.white),
            keyboardType: type,
            obscureText: star,
            decoration: InputDecoration(
               prefixIcon: icon, 
              // focusColor: Colors.white,
              hintText: (' Enter $name '),
              hintStyle:  TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}