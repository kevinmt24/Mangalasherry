import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  String currentDay = DateFormat('yMd').format(DateTime.now()).toString().replaceAll('/', '-');
  String currentMonth = DateFormat('yM').format(DateTime.now()).toString().replaceAll('/','-');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');


  Future<void> updateUserData(String? name) async {
    return await userCollection.doc(uid).set({
      'name':name,
      'uid':uid,
    });
  }
  Future<void>submitCurrentDay(bool breakfast,bool lunch,bool dinner, int todayPrice) async {
    return await userCollection.doc(uid).collection('currentMonth').doc(currentDay).set({
      'amount':todayPrice,
      'breakfast':breakfast,
      'lunch':lunch,
      'dinner':dinner,
      'date': 'Aug 24',
    });
  }

  //Getting fees data
  Stream<QuerySnapshot> get fees {
    return userCollection.doc(uid).collection('currentMonth').snapshots();
  }

  Future<void>submitMonthTotal(int monthTotal) async {
    return await userCollection.doc(uid).collection('history').doc(currentMonth).set({
      'amount': monthTotal,
      'month' : currentMonth,
    });
  }
}