import 'package:busproject/Register/login.dart';
import 'package:busproject/Register/register.dart';
import 'package:busproject/adminside/admin_add_location.dart';
import 'package:busproject/screen/buses.dart';
import 'package:busproject/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: kPurpleColor,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCFcARJQfGotolbdpBhfQHzZtkX6BQVCdo",
      appId: "1:590702206091:android:1986099c13ad91a587c88e",
      messagingSenderId: "590702206091",
      projectId: "busstation-64958",
    ),
  );
  runApp(const BusStation());
}

class BusStation extends StatelessWidget {
  const BusStation({Key? key}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: LoginScreen.id,
      routes: {

        // LoginScreen.id : (context) => LoginScreen(),
        Buses.id : (context) =>   Buses(),
        Register.id: (context) => Register(),
        HomeScreen.id: (context) => HomeScreen(),
        AdminAddLocation.id: (context) => AdminAddLocation(),
        // StationMap.id: (context) => StationMap(),

        
      },
      title: 'Login App',
      home:  Scaffold(

        body: LoginScreen()
        
         ),
    );
  }
}
