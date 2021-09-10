import 'package:flutter/material.dart';
import 'package:messfees/services/auth.dart';
import 'package:intl/intl.dart';
import 'package:messfees/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messfees/services/monthlyfees.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String today = DateFormat('MMMMEEEEd').format(DateTime.now()).toString().replaceAll('/', '-');
  var breakfast = 40;
  var lunch = 45;
  var dinner = 50;
  bool _breakfastCheck = false;
  bool _lunchCheck = false;
  bool _dinnerCheck = false;
  var todayPrice = 0;
  @override
  Widget build(BuildContext context) {

    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseService(uid: AuthService.signedInUserId).fees,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 60),
            Center(
              child: Text(today,
                  style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 120),
            CheckboxListTile(
              title: Text('Breakfast'),
              secondary: Icon(Icons.beach_access),
              controlAffinity: ListTileControlAffinity.platform,
              activeColor: Colors.blue,
              value: _breakfastCheck,
              onChanged: (bool? value) {
                setState(() {
                  _breakfastCheck = !_breakfastCheck;
                  int a = _breakfastCheck ? 1 : 0;
                  int b = _lunchCheck ? 1 : 0;
                  int c = _dinnerCheck ? 1 : 0;
                  todayPrice = a * breakfast + b * lunch + c * dinner;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Lunch'),
              secondary: Icon(Icons.wb_sunny),
              controlAffinity: ListTileControlAffinity.platform,
              activeColor: Colors.blue,
              value: _lunchCheck,
              onChanged: (bool? value) {
                setState(() {
                  _lunchCheck = !_lunchCheck;
                  int a = _breakfastCheck ? 1 : 0;
                  int b = _lunchCheck ? 1 : 0;
                  int c = _dinnerCheck ? 1 : 0;
                  todayPrice = a * breakfast + b * lunch + c * dinner;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Dinner'),
              secondary: Icon(Icons.wb_twighlight),
              controlAffinity: ListTileControlAffinity.platform,
              activeColor: Colors.blue,
              value: _dinnerCheck,
              onChanged: (bool? value) {
                setState(() {
                  _dinnerCheck = !_dinnerCheck;
                  int a = _breakfastCheck ? 1 : 0;
                  int b = _lunchCheck ? 1 : 0;
                  int c = _dinnerCheck ? 1 : 0;
                  todayPrice = a * breakfast + b * lunch + c * dinner;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text('Select None'),
                  onTap: () {
                    setState(() {
                      _breakfastCheck = _lunchCheck = _dinnerCheck = false;
                      todayPrice = 0;
                    });
                  },
                ),
                SizedBox(width: 10),
                InkWell(
                  child: Text('Select All'),
                  onTap: () {
                    setState(() {
                      _breakfastCheck = _lunchCheck = _dinnerCheck = true;
                      todayPrice = breakfast + lunch + dinner;
                    });
                  },
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Text(todayPrice.toString()),
            ),
            SizedBox(height: 40),
                                                                            //TODO: Monthly Amount here...
            MonthlyFees(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {

                await DatabaseService(uid: AuthService.signedInUserId)
                    .submitCurrentDay(_breakfastCheck,_lunchCheck,_dinnerCheck,todayPrice);

                await DatabaseService(uid: AuthService.signedInUserId).submitMonthTotal(MonthlyFees.monthTotal.toInt());
                print('Successfully updated history collection');
              },
              child: const Text('Submit'),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
