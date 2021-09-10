import 'package:flutter/material.dart';
import 'package:messfees/services/auth.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text(
          'Sign out',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          await _auth.signOut();
        },
      ),
    );
  }
}
