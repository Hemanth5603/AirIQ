import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/controllers/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.getColor(77)
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.1,
                ),
                CircleAvatar(
                  radius: w * 0.2,
                  backgroundColor: Color.fromARGB(255, 171, 226, 173),
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                 Text(
                  userController.nameController.text,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                ),
                const Text(
                  "maddijitendra33@gmail.com",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(color:  Constants.getColor(77)),
          child: const Text(
            "LogOut",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}