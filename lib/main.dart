import 'package:flutter/material.dart';
import 'package:messfees/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messfees/screens/landingPage.dart';
import 'package:messfees/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:messfees/screens/authenticate/authenticate.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FeesApp());
}

class FeesApp extends StatefulWidget {
  const FeesApp({Key? key}) : super(key: key);

  @override
  _FeesAppState createState() => _FeesAppState();
}

class _FeesAppState extends State<FeesApp> {
  @override
  Widget build(BuildContext context) {
   return StreamProvider<CurrentUser?>.value(
     value: AuthService().user,
     initialData: null,

     child: MaterialApp(
        home: AuthenticationWrapper(),
      ),
   );
  }
}
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);
    if(user == null)
      return Authenticate();
    else
      return LandingPage();
  }
}
