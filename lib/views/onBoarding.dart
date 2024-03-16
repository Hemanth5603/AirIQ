import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackoverflow_mobile/views/login.dart';
import 'package:hackoverflow_mobile/views/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late Image image1;
  late Image image2;

  @override
  void initState() {
    image1 = Image.asset("assets/background/polluted1.jpg");
    image2 = Image.asset("assets/background/lady.jpg");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("called");
    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: pageController,
          //physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.start,
          scrollDirection: Axis.horizontal,
          children: [
            appOnboarding(sh, sw, image1.image),
            additionalOnboarding(sh, sw, image2.image),
          ],
        ),
        Positioned(
          bottom: sh * 0.10,
          left: sw / 2 - 25,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 2,
            effect: SwapEffect(
              activeDotColor: const Color.fromARGB(255, 255, 255, 255),
              dotColor: Colors.grey.shade400,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ),
        Positioned(
            bottom: 15,
            left: sw / 10 - 10,
            child: Container(
              height: 50,
              width: sw - 50,
              //margin:EdgeInsets.only(left: 10,right: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black),
              child: InkWell(
                onTap: () {
                  Get.to(() => const SignUpPage(),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 400));
                },
                child: const Center(
                    child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ))
      ]),
    );
  }
}

Widget appOnboarding(h, w, path) {
  const appName = "AirIQ";
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: path,
          fit: BoxFit.cover,
        )),
      ),
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
              Color.fromARGB(0, 0, 0, 0),
              Color.fromARGB(134, 0, 0, 0),
            ],
                stops: [
              0.0,
              .9
            ])),
      ),
      Positioned(
        top: h * 0.61,
        left: 10,
        child: SizedBox(
          width: w - 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("icons/icon.png"),
              const Text(
                appName,
                style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontFamily: 'man-sb',
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "know your air",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'man-r',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Keep track of what you're breathing around you, how it may affect your health",
                style: TextStyle(fontSize: 14, color: Colors.white,fontFamily: 'man-l',),
                
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget additionalOnboarding(h, w, path) {
  const appName = "AirIQ";
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: path,
          fit: BoxFit.cover,
        )),
      ),
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
              Color.fromARGB(0, 0, 0, 0),
              Color.fromARGB(134, 0, 0, 0),
            ],
                stops: [
              0.0,
              .9
            ])),
      ),
      Positioned(
        top: h * 0.61,
        left: 10,
        child: SizedBox(
          width: w - 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("icons/icon.png"),
              const Text(
                appName,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: 'man-sb',
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "breath better",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,fontFamily: 'man-sb',),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Fulfill all your respiratory needs form N95s and nebulizers to online doctor appointments",
                style: TextStyle(fontSize: 14, color: Colors.white,fontFamily: 'man-l'),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}