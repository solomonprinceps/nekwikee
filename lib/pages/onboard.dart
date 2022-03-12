import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({ Key? key }) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: currentIndex);
    super.initState();
  }

  void changeIndex(int ind) {
    setState(() {
      currentIndex = ind;
    });
    _controller.animateToPage(currentIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    final String themestate = MediaQuery.of(context).platformBrightness == Brightness.light ? "light" : "dark";
    return Scaffold(
      // backgroundColor: onboardbackground,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _controller,
        children: <Widget>[
          
          Container(
            height: 100.h,
            width: double.infinity,
            color: themestate == "dark" ? darkscaffold : onboardbackground,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipPath(
                      child: Container(
                        height: 60.h,
                        width: double.infinity,
                        // color: Colors.green,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/onboard1.png'),
                            fit: BoxFit.cover,    // -> 02
                          ),
                        ),
                      ),
                      clipper: CustomClipPath2(),
                    ),
                    Container(
                      height: 25.h,
                      padding: EdgeInsets.only(top: 5.h, left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/image/badgeimg.png'),
                              const SizedBox(width: 5),
                              Text(
                                'Easier Life',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'With Kwikee Life just got easier. Financial solutions at your finger tips with several benefits.',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(246, 251, 254, 1),
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () => changeIndex(1),
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(83, 232, 139, 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed('auth/login'),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 50),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: themestate == "dark" ? white : onboardbackground,
                          fontWeight: FontWeight.w900,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),    
          
          Container(
            height: 100.h,
            width: double.infinity,
            color: themestate == "dark" ? darkscaffold : onboardbackground,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipPath(
                      child: Container(
                        height: 60.h,
                        width: double.infinity,
                        // color: Colors.green,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/onboard2.png'),
                            fit: BoxFit.cover,    // -> 02
                          ),
                        ),
                      ),
                      clipper: CustomClipPath(),
                    ),
                    Container(
                      height: 25.h,
                      padding: EdgeInsets.only(top: 5.h, left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/image/badgeimg.png'),
                              const SizedBox(width: 5),
                              Text(
                                'Smart Moves',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'Save for your immediate and long-term needs Invest for the Future Get Cash Back when you Invest.',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(246, 251, 254, 1),
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    // padding: const EdgeInsets.only(right: 20),
                    width: 100.w,
                    height: 60,
                    
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => changeIndex(0),
                          child: Container(
                            height: double.infinity,
                            width: 20.w,
                            color: themestate == "dark" ? onboardaction : white,
                            child: Center(
                              child:Icon(
                                FontAwesome.angle_left,
                                size: 20,
                                color: onboardbackground,
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => changeIndex(2),
                            child: Container(
                              // width: 80.w,
                              padding: const EdgeInsets.only(right: 20),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(83, 232, 139, 1)
                              ),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed('auth/login'),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 50),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: themestate == "dark" ? white : onboardbackground,
                          fontWeight: FontWeight.w900,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),      

          Container(
            height: 100.h,
            width: double.infinity,
            color: themestate == "dark" ? darkscaffold : onboardbackground,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipPath(
                      child: Container(
                        height: 60.h,
                        width: double.infinity,
                        // color: Colors.green,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/onboard3.png'),
                            fit: BoxFit.fitHeight,    // -> 02
                          ),
                        ),
                      ),
                      clipper: CustomClipPath2(),
                    ),
                    Container(
                      height: 25.h,
                      padding: EdgeInsets.only(top: 5.h, left: 35, right: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/image/badgeimg.png'),
                              const SizedBox(width: 5),
                              Text(
                                'Quick & Convinient',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'Access up to 500,000 in your Kwikee Wallet. Zero Interest on Weekends; more fun and cashbacks!',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(246, 251, 254, 1),
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    // padding: const EdgeInsets.only(right: 20),
                    width: double.infinity,
                    height: 60,
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => changeIndex(1),
                          child: Container(
                            height: double.infinity,
                            width: 90,
                            color: themestate == "dark" ? onboardaction : white,
                            child: Center(
                              child:Icon(
                                FontAwesome.angle_left,
                                size: 20,
                                color: onboardbackground,
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.offAllNamed('register/getnumber'),
                            child: Container(
                              padding: const EdgeInsets.only(right: 20),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(83, 232, 139, 1)
                              ),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('auth/login'),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 50),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: themestate == "dark" ? white : onboardbackground,
                          fontWeight: FontWeight.w900,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),  
          
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 55.h);
    path.lineTo(100.w,60.h);
    path.lineTo(100.w,0);
    // path.lineTo(30, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPath2 extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 60.h);
    path.lineTo(100.w,55.h);
    path.lineTo(100.w,0);
    // path.lineTo(30, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}