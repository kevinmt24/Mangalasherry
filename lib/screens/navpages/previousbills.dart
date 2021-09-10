import 'package:flutter/material.dart';
import 'package:messfees/services/card.dart';

class PreviousBillsPage extends StatefulWidget {
  const PreviousBillsPage({Key? key}) : super(key: key);

  @override
  _PreviousBillsPageState createState() => _PreviousBillsPageState();
}

class _PreviousBillsPageState extends State<PreviousBillsPage> {
  @override
  Widget build(BuildContext context) {
    return CardClass();
  }
}
