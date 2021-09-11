import 'package:firebase_auth/firebase_auth.dart';
import 'package:messfees/models/user.dart';
import 'package:messfees/services/database.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String signedInUserId = '';

  CurrentUser? _userFromFirebaseUser(User? user) {

    // return user != null ? CurrentUser(uid: user.uid) : null;
    if(user != null) {
      signedInUserId = user.uid;
      return CurrentUser(uid: user.uid);
    }
    else {
      return null;
    }
  }
   //Passing it to the database
  //auth change user stream
  Stream<CurrentUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

Future registerWithEmailAndPassword(String name, String email,String password) async {
  try{
    UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;
    signedInUserId = user!.uid;
    await DatabaseService(uid: signedInUserId).updateUserData(name);
    return _userFromFirebaseUser(user);
  } catch(e) {
    print(e.toString());
    return null;
  }
}

  //Sign In With Email and Password
Future signInWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      signedInUserId = user!.uid;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
}

  //Sign Out
Future signOut() async {
    try{
      return await _auth.signOut();
  } catch(e) {
      print(e.toString());
      return null;
    }
}
}