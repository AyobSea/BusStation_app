// import 'package:busproject/useless/dummies.dart';
import 'package:busproject/Register/register_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Buses extends StatefulWidget {
  const Buses({Key? key}) : super(key: key);
  static const id = 'Buses';
  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  List<String> itemNum = ['one', 'two'];
  String selected = 'please select';

  // Data data = Data();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: busBackground,
        body: SlidingSheet(
      elevation: 8,
      cornerRadius: 16,
      snapSpec: const SnapSpec(

        snap: true,

        snappings: [0.4, 0.7, 1.0],

        positioning: SnapPositioning.relativeToAvailableSpace,
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
                          color: Colors.white
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
      // The body widget will be displayed under the SlidingSheet
      // and a parallax effect can be applied to it.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  SizedBox(height: 60),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('station')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        final List<String> dropdownValues = [];

                        for (var docs in snapshot.data!.docs) {
                          dropdownValues.add(
                              (docs.data() as Map<String, dynamic>)['name']);
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(right: 120), child: Align(alignment: Alignment.centerLeft, child: Text('From : ', style: TextStyle(fontSize: 19),))),
                                    selectStation(
                                        selected: selected,
                                        dropdownValues: dropdownValues),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(right: 120), child: Align(alignment: Alignment.centerRight, child: Text('To :', style: TextStyle(fontSize: 19),))),
                                    selectStation(
                                        selected: selected,
                                        dropdownValues: dropdownValues),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            selectDate(
                                selected: selected,
                                dropdownValues: dropdownValues),
                          ],
                        );
                      }),
                  // TextButton(
                  //   onPressed: () {
                  //     DatePicker.showDatePicker(context,
                  //         showTitleActions: true,
                  //         minTime: DateTime(2018, 3, 5),
                  //         maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                  //       print('change $date');
                  //     }, onConfirm: (date) {
                  //       print('confirm $date');
                  //     }, currentTime: DateTime.now(), locale: LocaleType.ar);
                  //   },
                  //   child: Text(
                  //     'show date time picker (ar)',
                  //     style: TextStyle(color: Colors.blue),
                  //   ),
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),
      
      builder: (context, state) {
        // This is the content of the sheet that will get
        // scrolled, if the content is bigger than the available
        // height of the sheet.
        return Container(
          color: Color(0xffFFF7EE),
          height: 500,
          child: Center(
            child: Text('This is the content of the sheet'),
          ),
        );
      },
    ),
    
        );
  }
}

// compomnent

class selectStation extends StatelessWidget {
  const selectStation({
    Key? key,
    required this.selected,
    required this.dropdownValues,
  }) : super(key: key);

  final String selected;
  final List<String> dropdownValues;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 90,
        width: 170,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffDFE0DF),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
          ),
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          icon: Icon(Icons.arrow_downward, color: Colors.black, size: 20),
          hint: Text(selected, style: TextStyle(fontSize: 14),),
          // value: selected,
          items: dropdownValues.map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: (String? newValue) {
            // setState(() {
            //   selected = newValue!;
            // });
          },
        ),
      ),
    );
  }
}


class selectDate extends StatelessWidget {
  const selectDate({
    Key? key,
    required this.selected,
    required this.dropdownValues,
  }) : super(key: key);

  final String selected;
  final List<String> dropdownValues;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 90,
        width: 360,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffDADDE2),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
          ),
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          icon: Icon(Icons.arrow_downward, color: Colors.black, size: 20),
          hint: Text(selected, style: TextStyle(fontSize: 14),),
          // value: selected,
          items: dropdownValues.map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: (String? newValue) {
            // setState(() {
            //   selected = newValue!;
            // });
          },
        ),
      ),
    );
  }
}