import 'package:busproject/Register/login.dart';
import 'package:busproject/screen/chooseScreen/map.dart';
import 'package:busproject/style/style.dart';
import 'package:busproject/adminside/add_member.dart';
import 'package:busproject/adminside/admin_add_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class AdminAddStationandMember extends StatefulWidget {
  const AdminAddStationandMember({ Key? key }) : super(key: key);

  @override
  State<AdminAddStationandMember> createState() => _AdminAddStationandMemberState();
}

class _AdminAddStationandMemberState extends State<AdminAddStationandMember> {

  
  late String _username, _firstname, _lastname, _email, _password, _street;
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 255,
              width: 360,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        // Radius.circular(18)
                      ),
                      border: Border.all(width: 2, color: busblackBlue)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        // Radius.circular(18)
                      ),
                      child: Image.asset('images/Bus-Stop-scaled.jpg'),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 180,
                      height: 30,
                      child: ElevatedButton(
                          style: secondButton,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const AdminAddLocation()));
                          },
                          child: Text('Add New Station', style: TextStyle(color: busblackBlue),)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              width: 360,
              child: Column(
                
                children: [
                  Container(
                    
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        // Radius.circular(18)
                      ),
                      border: Border.all(width: 2, color: busblackBlue)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        // Radius.circular(18)
                      ),
                      child: Image.asset('images/Bus-Stop-scaled.jpg'),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 180,
                      height: 30,
                      child: 
            ElevatedButton(
                style: secondButton,
                onPressed: () {
                  showSheet();
                },
                child: Text('Add New Admin', style: TextStyle(color: busblackBlue))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
    Future showSheet() => showSlidingBottomSheet(context,
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
          builder: buildSheet));
  Widget buildSheet(context, state) => Material(
          child: Container(
        color: busBackground,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add new Admin',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: busIcon),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 26),
              child: Fields(
                fill: busWhite,
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
                fill: busWhite,
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
                fill: busWhite,
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
                fill: busWhite,
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
                fill: busWhite,
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
                  fill: busWhite,
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
                          builder: (context) => const UserChooseLocation()));
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
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ));
}

class Fields extends StatelessWidget {
  Fields(
      {Key? key,
      required this.onChanged,
      required this.name,
      required this.type,
      required this.star,
      required this.icon,
      required this.fill})
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
            hintStyle: TextStyle(
                color: busclay, fontSize: 16, fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: busclay),
            ),
            focusedBorder: OutlineInputBorder(
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
