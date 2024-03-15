import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hackoverflow_mobile/controllers/user.dart';
import 'package:hackoverflow_mobile/views/home.dart';

class RespiratoryForm extends StatefulWidget {
  const RespiratoryForm({super.key});

  @override
  State<RespiratoryForm> createState() => _RespiratoryFormState();
}

class _RespiratoryFormState extends State<RespiratoryForm> {
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());
  String oxygen = "Yes";
  String equivpment = "Yes";
  String breathness = "Low";
  String smooking = "No";
  String intrestSmoking = "Yes"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Questionare',style: TextStyle(fontFamily: 'man-sb',fontSize: 22),),
        backgroundColor: const Color.fromARGB(255, 0, 127, 115),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
                    onPressed: () async{
                    await userController.updateHealth(oxygen, equivpment, breathness, smooking,intrestSmoking);
                    Get.to(Home(), transition: Transition.downToUp, duration: Duration(milliseconds: 300));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 127, 115),
                      // foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Answer these questions to help us personalize your results.",
                  style: TextStyle(fontSize: 20,fontFamily: 'man-sb',),
                ),
                SizedBox(height: 8,),
                const Text(
                  "Don't worry, we keep your personal data safe!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 97, 97, 97),
                    fontFamily: 'man-l'
                  ),
                ),
                SizedBox(height: 50,),
                TextFormField(
                  controller: userController.healthConditions,
                  decoration: InputDecoration(
                    labelText: 'Respiratory Health Conditions',
                    labelStyle: TextStyle(fontFamily: 'man-r'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your respiratory health conditions';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Do you use oxygen or peak flow meter?',
                    labelStyle: TextStyle(fontFamily: 'man-r'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  value: 'No',
                  items: const [
                    DropdownMenuItem(
                      value: 'No',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: 'Yes',
                      child: Text('Yes'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      oxygen = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Do you use home respiratory equipment?',
                    labelStyle: TextStyle(fontFamily: 'man-r'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  value: 'No',
                  items: const [
                    DropdownMenuItem(
                      value: 'No',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: 'Yes',
                      child: Text('Yes'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      equivpment = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: userController.medicationController,
                  decoration: InputDecoration(
                    labelText: 'Current medications, herbs, or supplements?',
                    labelStyle: TextStyle(fontFamily: 'man-r'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your medications, herbs, or supplements';
                      
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Breathlessness level',
                    labelStyle: TextStyle(fontFamily: 'man-r'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  value: 'No',
                  items: const [
                    DropdownMenuItem(
                      value: 'No',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: 'Mild',
                      child: Text('Mild'),
                    ),
                    DropdownMenuItem(
                      value: 'Moderate',
                      child: Text('Moderate'),
                    ),
                    DropdownMenuItem(
                      value: 'Severe',
                      child: Text('Severe'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      breathness = value!;
                    });
                    
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Smoking/Vaping status',
                    labelStyle: TextStyle(fontFamily: 'man-r'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  value: 'No',
                  items: const [
                    DropdownMenuItem(
                      value: 'No',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: 'Cigarettes',
                      child: Text('Cigarettes'),
                    ),
                    DropdownMenuItem(
                      value: 'E-cigarettes',
                      child: Text('E-cigarettes'),
                    ),
                    DropdownMenuItem(
                      value: 'Other tobacco products',
                      child: Text('Other tobacco products'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      smooking = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Interest in quitting smoking/vaping?',
                    labelStyle: TextStyle(fontFamily: 'man-r'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  value: 'No',
                  items: const [
                    DropdownMenuItem(
                      value: 'No',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: 'Maybe',
                      child: Text('Maybe'),
                    ),
                    DropdownMenuItem(
                      value: 'Yes',
                      child: Text('Yes'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      intrestSmoking = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}