import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messfees/services/auth.dart';

class PreviousBillsPage extends StatefulWidget {
  const PreviousBillsPage({Key? key}) : super(key: key);

  @override
  _PreviousBillsPageState createState() => _PreviousBillsPageState();
}

class _PreviousBillsPageState extends State<PreviousBillsPage> {


  @override
  Widget build(BuildContext context) {
     Map<String,String> monthsInYear = {
      '1': "January", '2': "February", '3': "March", '4': "April",
      '5': "May", '6': "June", '7': "July", '8': "August",
      '9': "September", '10': "October", '11': "November", '12': "December"
    };
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(AuthService.signedInUserId)
              .collection('history')
              .orderBy('month', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            print(snapshot.data!.docs);
            return ListView(
              children: snapshot.data!.docs.map((document) {

                var parts = document['month'].split("-");
                String? formattedMonth = monthsInYear[parts[0]];
                String formattedYear = parts[1];

                return Container(
                  height: 65  ,
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 40, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formattedMonth.toString()+"  "+ formattedYear),
                          Text(document['amount'].toString()),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
