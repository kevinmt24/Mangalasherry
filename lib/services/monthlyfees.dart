import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MonthlyFees extends StatefulWidget {
  static num monthTotal = 0;
  const MonthlyFees({Key? key}) : super(key: key);
  @override
  _MonthlyFeesState createState() => _MonthlyFeesState();
}

class _MonthlyFeesState extends State<MonthlyFees> {


  @override
  Widget build(BuildContext context)  {
    num sum = 0;
    final brews = Provider.of<QuerySnapshot?>(context);
    if(brews != null) {
      for(var doc in brews.docs){
        sum += doc.get("amount");
      }
      MonthlyFees.monthTotal = sum;
    }
    else
      sum = 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DateFormat.MMMM().format(DateTime.now()).toString()+" Fees",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,wordSpacing: 2.0)),
          Text(sum.toString(),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,wordSpacing: 2.0))
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
