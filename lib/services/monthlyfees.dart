import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyFees extends StatefulWidget {
  static num monthTotal = 0;
  const MonthlyFees({Key? key}) : super(key: key);
  @override
  _MonthlyFeesState createState() => _MonthlyFeesState();
}

class _MonthlyFeesState extends State<MonthlyFees> {


  @override
  Widget build(BuildContext context) {
    num sum = MonthlyFees.monthTotal;
    final brews = Provider.of<QuerySnapshot>(context);
    for(var doc in brews.docs){
       sum += doc.get("amount");
    }
    print(sum);


    return Center(
      child: Text(sum.toString()),
    );
  }
}
