import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gemini = Gemini.instance;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        child: Container(
          width: w,
          height: h * 0.6,
          color: Colors.blue,
        ),
        onTap: ()async {
          await gemini.text("Write a story about a magic backpack.")
            .then((value) => print( value?.output )) /// or value?.content?.parts?.last.text
            .catchError((e) => print(e));
        },
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}