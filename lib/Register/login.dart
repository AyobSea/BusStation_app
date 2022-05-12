import 'package:busproject/style/style.dart';
import 'package:busproject/adminside/admin_home.dart';
import 'package:busproject/screen/chooseScreen/map.dart';
import 'package:busproject/screen/home_screen.dart';
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

  
   static String showError(String errorCode) {
     switch (errorCode) {
       case 'ERROR_EMAIL_ALREADY_IN_USE':
         return "This e-mail address is already in use, please use a different e-mail address.";

       case 'ERROR_INVALID_EMAIL':
         return "The email address is badly formatted.";

       case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
         return "The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.";

       case 'ERROR_WRONG_PASSWORD':
         return "E-mail address or password is incorrect.";

       default:
         return "An error has occurred";
     }
   }

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
                              // padding: EdgeInsets.all(50),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 30),
                      LoginFields(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
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
                            child: Text('LOGIN', style: bText),
                            onPressed: () {
                              try {
                                _auth
                                    .signInWithEmailAndPassword(
                                        email: _email, password: _password)
                                    .then(
                                  (_) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserChooseLocation()));
                                  },
                                );
                              } catch (e) {
                                print(showError);
                              }
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
                              child: Text('Regester', style: bText),
                              onPressed: () {
                                showSheet();
                                // Navigator.pushNamed(context, Register.id);
                              }),
                          const SizedBox(height: 20),
                          // TextButton(
                          //     onPressed: () {
                          //       showSheet();
                          //       // Navigator.of(context).push(MaterialPageRoute(
                          //       //     builder: (context) => ManagePage()));
                          //     },
                          //     child:
                          //         const Text('do u have an account ? Register'))
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
          .push(MaterialPageRoute(builder: (context) => AdminHomePage()));
    } else {
      return Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
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
        color: busclay,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Register',
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
  // final GlobalKey<FormState> _key = GlobalKey(FormState)();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 300),
          child: Form(
            child: TextFormField(
              validator: (value) {},
              style: TextStyle(color: Colors.white),
              keyboardType: type,
              obscureText: star,
              decoration: InputDecoration(
                // errorText: 'wrong user name or password',
          
                prefixIcon: icon,
                // focusColor: Colors.white,
                hintText: (' Enter $name '),
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
