import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart' hide Image;
import 'package:image_picker/image_picker.dart';

import 'package:tflite_flutter/tflite_flutter.dart' as tfl;



class ImageClasificationScreen extends StatefulWidget {
  const ImageClasificationScreen({super.key});

  @override
  State<ImageClasificationScreen> createState() => _ImageClasificationScreenState();
}

class _ImageClasificationScreenState extends State<ImageClasificationScreen> {
  
  bool loading = false;
  String? pickedImage;
  List<dynamic> predictions = [];
  String? label = '';
  String? confi = '0';
  Map<String, double>? _results;
  tfl.Interpreter? interpreter;
  Image? image;
  List<double>? output;

  @override
  void initState() {
    super.initState();
    loadModel();

  }

   Future<void> loadModel() async {
    interpreter = await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');
    interpreter!.allocateTensors();
  }

  //  Future<void> pickImage() async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     final imageFile = File(pickedImage.path);
  //     setState(() {
  //       image = Image.file(imageFile);
  //     });
  //     // No preprocessing needed, directly convert image to model input format
  //     final imageData = convertImageToInput(imageFile);
  //     runInference(imageData);5
  //   } else {
  //     print('No image selected.');
  //   }
  // }

  void runInference(List<double> inputData){
    interpreter!.run(inputData,output!);
    final outputList = interpreter!.getOutputTensor(0);
    String foutput = outputList.toString();
    
    if(foutput.isNotEmpty){
      print(foutput);
      print('Predicted class');
    }else{
      print("error printing");
    }
  }


  

















// loadModel() async{
//     await Tflite.loadModel(model: 'assets/model_unquant.tflite',labels: 'assets/labels.txt');  
//     var res = (await Tflite.loadModel(
//             model: "assets/mobilenet_v1_1.0_224.tflite",
//             labels: "assets/mobilenet_v1_1.0_224.txt",
//             // useGpuDelegate: true,
//           ))!; 
// }

// //   detectImage(file) async{
//     var prediction = await Tflite.runModelOnImage(
//       path: file,
//       numResults: 6,
//       threshold: 0.6,
//       imageMean: 127.5,
//       imageStd: 127.5
//     );
//     setState(() {
//       predictions = prediction!;
//     });
//   }

    /*Future<File?> getImageFrom({required ImageSource source}) async{
    final file = await ImagePicker().pickImage(source:source);
    if(file?.path != null){
      setState(() {
        pickedImage =  file?.path;
        
      });
      detectImage(pickedImage);
    }
  }*/

 
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Brain Tumor Classification",style: TextStyle(fontSize: 25)),
              SizedBox(height: 70,),
              if(pickedImage!=null)
                Container(
                  width: width * 0.7,
                  height: height * 0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(pickedImage!)),
                      fit:BoxFit.cover
                    )
                  ),
                ),
              SizedBox(height: 20,),
              InkWell(
                child: Container(
                  width: width,
                  height: height * 0.06,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black
                  ),
                  child: const Center(
                    child: Text("Camera",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ),
                onTap: (){
                  //getImageFrom(source: ImageSource.camera);
                },
              ),
              const SizedBox(height: 10,),
              InkWell(
                child: Container(
                  width: width,
                  height: height * 0.06,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black
                  ),
                  child: const Center(
                    child: Text("Gallery",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ),
                onTap: (){
                  //getImageFrom(source: ImageSource.gallery);
                  setState(() {
                    label = '';
                    confi = '0';
                  });
                },
              ),
              const SizedBox(height: 20,),
              InkWell(
                child: Container(
                  width: width * 0.7,
                  height: height * 0.06,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black
                  ),
                  child: const Center(
                    child: Text("Show results",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ),
                onTap: (){
                  setState(() {
                    label = predictions[0]['label'].toString().substring(2);
                    confi = predictions[0]['confidence'].toString().substring(0,3);
                  });
                },
              ),
              
              const SizedBox(height: 25,),

              Text("Result : "+label.toString(),style:const TextStyle(fontSize: 20),),
              const SizedBox(height: 15,),
              Text("Confidence : "+confi.toString(),style: TextStyle(fontSize: 18),),
                
            ]
          ),
        ),
      ),
    );
  }




  

}