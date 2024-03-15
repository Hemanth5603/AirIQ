import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/controllers/user.dart';
import 'package:hackoverflow_mobile/views/form.dart';
import 'package:hackoverflow_mobile/views/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  UserController userController = Get.put(UserController());

  var code = "";

  int start = 60;

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: sw,
                  height: sh * 0.4,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 236, 236, 236).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/background/login.png"),
                      width: sw * 0.7,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 239, 239, 239),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Center(
                          child: Icon(Icons.arrow_back_ios,size: 20,),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Login with Email/Password",
                      style: TextStyle(
                          fontFamily: 'metro',
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 45,
                      width: sw,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 7,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: sh * 0.1,
                            width: sw * 0.7,
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                textAlignVertical: TextAlignVertical.bottom,
                                controller: userController.emailController,
                                style: const TextStyle(fontFamily: 'man-r'),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 45,
                      width: sw,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 7,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: sh * 0.1,
                            width: sw * 0.7,
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.bottom,
                                controller: userController.passwordController,
                                style: const TextStyle(fontFamily: 'man-r'),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 50,
                        width: sw * 0.89,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Constants.getColor(77),
                                width: 2),
                            color: Constants.getColor(77),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await userController.signInWithEmailAndPassword(userController.emailController.text, userController.passwordController.text);
                      Get.to(RespiratoryForm(), transition: Transition.downToUp,duration: Duration(milliseconds: 300));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HorizontalOrLine(
                    label: "or",
                    height: 10,
                    sw: sw,
                  ),
                  SizedBox(height: sh * 0.05),
                  /*Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: sw * 0.23,
                      ),
                      InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image.asset(
                              'assets/icons/google.png',
                            )),
                        onTap: () => {},
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Image.asset(
                            'assets/icons/apple.png',
                          )),
                    ],
                  ),*/
                  const SizedBox(
                    height: 95,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 80),
                    child: const Column(
                      children: [
                        Text(
                          "By Continuing you agree ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Terms of Service   Privacy Policy ",
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    super.key,
    required this.label,
    required this.height,
    required this.sw,
  });

  final String label;
  final double height;
  final double sw;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
          width: 100,
          margin: const EdgeInsets.only(left: 50, right: 15.0),
          child: Divider(
            color: Colors.grey.shade500,
            height: height,
          )),
      Text(
        label,
        style: const TextStyle(
            color: Color.fromARGB(255, 131, 131, 131),
            fontWeight: FontWeight.bold),
      ),
      Container(
          width: 100,
          margin: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Divider(
            color: Colors.grey.shade500,
            height: height,
          ))
    ]);
  }
}