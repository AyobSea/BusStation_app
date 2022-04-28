
import 'package:busproject/Register/register_styles.dart';
import 'package:busproject/adminside/admin_add_location.dart';
import 'package:busproject/screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late String _username, _firstname, _lastname, _email, _password, _street;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: busblackBlue,
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: firstButton,
                onPressed: () {
                  Navigator.pushNamed(context, AdminAddLocation.id);
                },
                child: Text(
                  'Add A new Station',
                  style: bText,
                )),
            SizedBox(height: 20),
            ElevatedButton(
                style: secondButton,
                onPressed: () {
                  showSheet();
                },
                child: Text(
                  'Add Admin Account',
                  style: bText,
                )),
            SizedBox(height: 20),
            ElevatedButton(
                style: secondButton,
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                child: Text(
                  'Navigate to user page',
                  style: bText,
                )),
          ],
        ),
      ),
    );
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
                  'Crate a new admin account',
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
                          builder: (context) => const AdminHomePage()
                          )
                          );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
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