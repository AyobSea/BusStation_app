import 'package:busproject/Register/register_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetComments extends StatefulWidget {
  const GetComments({ Key? key }) : super(key: key);

  @override
  State<GetComments> createState() => _GetCommentsState();
}

class _GetCommentsState extends State<GetComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: busBackground,
      body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('comments').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
    
                final commentsData = (snapshot.data!.docs);
                // for (var data in stationData) {
                //  final stat = (data.data() as Map<String, dynamic>);
                //  print(stat['name']);
                // }
    
                // for (var i = 0; i < snapshot.data!.docs.length; i++) {
                //   print(snapshot.data!.docs[i]['name']);
                // }
    
                return ListView.builder(
                    itemCount: commentsData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(width: 1, color: busIcon)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                            
                                child: getCommentsData(type: 'user name:', data: commentsData[index]['name'] , ),
                              ),
                                            Padding(
                                padding: const EdgeInsets.all(10),
                            
                                child: getCommentsData(type: 'comment:', data: commentsData[index]['description'], ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                      );
                    }
                      ),
    );
  }
}

class getCommentsData extends StatelessWidget {
  const getCommentsData({
    Key? key, required this.data, required this.type,
  }) : super(key: key);

  final String data;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        Text( type,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),Text( data,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}