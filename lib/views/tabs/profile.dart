import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/controllers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getProfile();
    });
    
  }
  var isLoading = false.obs;
  String name = "User";

  Future<void> getProfile() async{
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    isLoading(false);

  }
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                ),
                const Text(
                  "user@gmail.com",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
        )
      
    );
  }
}