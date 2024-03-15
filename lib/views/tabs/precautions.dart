import 'package:flutter/material.dart';

class PrecautionsPage extends StatefulWidget {
  const PrecautionsPage({super.key});

  @override
  State<PrecautionsPage> createState() => _PrecautionsPageState();
}

class _PrecautionsPageState extends State<PrecautionsPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(),

      )
    );
  }
}