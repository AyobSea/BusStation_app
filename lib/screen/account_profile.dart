import 'package:busproject/Register/login.dart';
import 'package:busproject/Register/register_styles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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

  //       Reference ref =
  //         firebaseStorage.ref(_auth?.uid).child("dp");
  //       ref.putFile(image).whenComplete(() {
  //       print("Pic Uploaded Successfully!");
  //       setState(() {
  //         _uploading = false;
  //       });
  //       // refreshing the UI when photo updated
  //       getUploadedPic();
  //     });
  //   } catch (e) {
  //     print(e);
  //   }

  // final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
  // final firebaseStorageRef = FirebaseStorage.instance
  //       .ref()
  //       .child('images/$imageName');

  // final uploadTask = firebaseStorageRef.putFile(file);
  // final taskSnapshot = await uploadTask.onComplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: busBackground,
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
                    padding: EdgeInsets.only(top: 90, left: 160),
                    child: CircleAvatar(
                      child: Stack(
                        children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white70,
                            child: Icon(Icons.camera),
                          ),
                        ),
                      ]),
                      radius: 50,
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
                          primary: Colors.red, // <-- Button color
                          onPrimary: Colors.black, // <-- Splash color
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
                    type: 'User Name',
                  ),
                  Divider(color: Colors.black),
                  UserDataField(
                    data: userData['first'],
                    type: 'First',
                  ),
                  Divider(color: Colors.black),
                  UserDataField(
                    data: userData['last'],
                    type: 'Last',
                  ),
                  Divider(color: Colors.black),
                  UserDataField(
                    data: userData['street'],
                    type: 'Street',
                  ),
                  Container(
                      width: 230,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Edit Profile',
                          style: bText,
                        ),
                        style: firstButton,
                      )),
                ],
              ),
            ]);
            // Container(
            //   height: 180,
            //   decoration: BoxDecoration(
            //     color: busblackBlue,
            //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(180), bottomRight: Radius.circular(180))
            //   ),
            // ),

            // return Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Column(
            //     children: [
            //       SizedBox(height: 100),
            //       Stack(children: [
            //         ElevatedButton(
            //             onPressed: () {
            //               _signOut();

            //               Navigator.pushReplacement(
            //                 context,
            //                 MaterialPageRoute<void>(
            //                   builder: (BuildContext context) =>
            //                       const LoginScreen(),
            //                 ),
            //               );
            //             },
            //             child: Text('')),
            //         SizedBox(
            //           height: 620,
            //           child: Padding(
            //             padding: EdgeInsets.only(top: 70),
            //             child: Card(
            //               color: busblackBlue,
            //               child: Padding(
            //                 padding: const EdgeInsets.only(top: 300),
            //                 child: Column(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceEvenly,
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   // mainAxisSize: MainAxisSize.min,

            //                   children: [
            //                     // SizedBox(height: 100, width: 300),
            //                     UserDataField(
            //                       data: userData['name'],
            //                       type: 'Username',
            //                     ),
            //                     Divider(color: Colors.white),
            //                     UserDataField(
            //                       data: userData['first'],
            //                       type: 'first',
            //                     ),
            //                     Divider(color: Colors.white),
            //                     UserDataField(
            //                       data: userData['last'],
            //                       type: 'last',
            //                     ),
            //                     Divider(color: Colors.white),
            //                     UserDataField(
            //                       data: userData['street'],
            //                       type: 'street',
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(top: 20, left: 120),
            //           child: CircleAvatar(
            //             radius: 50,
            //             backgroundColor: Colors.grey,
            //           ),
            //         ),
            //         image != null
            //             ? Padding(
            //                 padding: EdgeInsets.all(0),
            //                 child: Center(
            //                   child: CircleAvatar(
            //                     backgroundColor: busyellow,
            //                     radius: 80,
            //                     child: CircleAvatar(
            //                       radius: 75,
            //                       backgroundImage: FileImage(
            //                         image!,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             : Text("No image selected"),
            //         Padding(
            //           padding: EdgeInsets.only(top: 110, left: 110),
            //           child: Center(
            //             child: ElevatedButton(
            //               onPressed: () {
            //                 uploadPic();
            //               },
            //               child: Icon(Icons.image, color: Colors.white),
            //               style: ElevatedButton.styleFrom(
            //                 shape: CircleBorder(),
            //                 padding: EdgeInsets.all(5),
            //                 primary: Colors.red, // <-- Button color
            //                 onPrimary: Colors.black, // <-- Splash color
            //               ),
            //             ),
            //           ),
            //         ),
            //       ])
            //     ],
            //   ),
            // );
          }),
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
// class MyClipper extends CustomClipper<Rect> {
//   @override
//   Rect getClip(Size size) {
//     return Rect.fromLTWH(10, 10, 200, 100);
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
//     return false;
//   }
// }

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
          padding: const EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: StyledText(
              text: '<colorwhite><bold><size>$type</size></bold></colorwhite>',
              textAlign: TextAlign.left,
              tags: {
                'bold': StyledTextTag(
                    style: TextStyle(fontWeight: FontWeight.normal)),
                'size': StyledTextTag(style: TextStyle(fontSize: 18)),
                'colorwhite':
                    StyledTextTag(style: TextStyle(color: Colors.grey)),
              },
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: StyledText(
                  text:
                      '<colorgrey><bold><size>$data</size></bold></colorgrey>',
                  textAlign: TextAlign.right,
                  tags: {
                    'bold': StyledTextTag(
                        style: TextStyle(fontWeight: FontWeight.normal)),
                    'size': StyledTextTag(style: TextStyle(fontSize: 16)),
                    'colorgrey':
                        StyledTextTag(style: TextStyle(color: Colors.black)),
                  },
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 30),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    //     async {
                    //   await FirebaseFirestore.instance
                    //       .collection('users')
                    //       .doc(user!.uid)
                    //       .update({
                    //     'name': _username,
                    //     'first': _firstname,
                    //     'last': _lastname,
                    //     'street': _street,
                    //     'role': false,
                    //   });

                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const UserChooseLocation()
                    //       )
                    //       );
                    // },
                    child: Text('Edit')),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}