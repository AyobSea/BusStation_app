import 'package:busproject/Register/login.dart';
import 'package:busproject/style/style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_text/styled_text.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
// import 'dart:math';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late String _username, _firstname, _lastname, _email, _password, _street;
  final _auth = FirebaseAuth.instance.currentUser;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  File? image;
  String photoUrl = "";

  uploadPic() async {
    try {
      setState(() {});
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (file != null) {
        image = File(file.path);
      } else {
        setState(() {});
      }
      Reference ref =
          firebaseStorage.ref(_auth?.uid).child('image').child('image.png');

      ref.putFile(image!).whenComplete(() {
        print("Pic Uploaded Successfully!");
        setState(() {});
        // refreshing the UI when photo updated
        getUploadedPic();
      });
    } catch (e) {
      print(e);
    }
  }

  getUploadedPic() async {
    photoUrl = await firebaseStorage
        .ref('${_auth?.uid}/image/image.png')
        .getDownloadURL()
        .whenComplete(() => print("URL UPLOADED AT: $photoUrl"));
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: busbottom,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_auth?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final userData = (snapshot.data!.data() as Map<String, dynamic>);

            return Column(children: [
              Stack(
                children: [
                  ClipPath(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: busclay,
                    ),
                    clipper: WaveClipper1(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 80, left: 128),
                    child: CircleAvatar(
                      child: Stack(
                        children: [
                                   Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white70,
                            child: Icon(Icons.person, size: 80),
                          ),
                        ),
                      ]),
                      radius: 75,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  image != null
                      ? SizedBox(
                          height: 310,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: busBackground,
                              radius: 80,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: FileImage(
                                  image!,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text("No image selected"),
                  Padding(
                    padding: EdgeInsets.only(top: 110, left: 150),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          uploadPic();
                        },
                        child: Icon(Icons.image, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(5),
                          primary: busblackBlue,
                          onPrimary: Colors.black, 
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  UserDataField(
                    data: userData['name'],
                    type: 'user name',
                  ),
                  Divider(color: Colors.black),
                  UserDataField(
                    data: userData['first'],
                    type: 'first',
                  ),
                  Divider(color: Colors.black),
                  UserDataField(
                    data: userData['last'],
                    type: 'last',
                  ),
                  Divider(color: Colors.black),
                  UserDataField(
                    data: userData['street'],
                    type: 'street',
                  ),
                   Container(
                      width: 230,
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                           const LoginScreen()
                           ));
                        },
                        child: Text(
                          'Logout', style: bText,
                                    ),
                        style: firstButton, 
                      )),
                ],
              ),
            ]
            );
             }
             ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class UserDataField extends StatelessWidget {
  const UserDataField({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  final String type;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(type, style: GoogleFonts.alef(
              fontSize: 18,
              color: test
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(data, style: GoogleFonts.alef(
              fontSize: 20
            )),
          ),
        ),
      ],
    ));
  }
}
