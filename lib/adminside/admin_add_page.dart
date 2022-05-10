import 'package:busproject/style/style.dart';
import 'package:busproject/adminside/add_member.dart';
import 'package:busproject/adminside/admin_add_location.dart';
import 'package:flutter/material.dart';

class NavigatorToLocation extends StatelessWidget {
  const NavigatorToLocation({Key? key}) : super(key: key);

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
                      border: Border.all(width: 2, color: busExpand)
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
                          child: Text('Add New Station')),
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
                      border: Border.all(width: 2, color: busExpand)
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddNewAdmin()));
                },
                child: Text('Add New Admin')),
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
}
