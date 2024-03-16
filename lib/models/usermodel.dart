import 'package:get/get.dart';
class UserModel extends GetxController{
  String? uid;
  String? name;
  String? email;

  UserModel({
    required this.uid,
    required this.name,
    required this.email
  });
}