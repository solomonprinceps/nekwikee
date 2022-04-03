import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';

class Notification extends StatefulWidget {
  const Notification({ Key? key }) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  AuthController auth = Get.find<AuthController>();
  List? notificationList = [];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // getloanoffer(data: {"loan_id": Get.arguments});
      loadnotification();
    });
    super.initState();
  }

  loadnotification() async {
    context.loaderOverlay.show();
    await auth.notificateList().then((value) {
      context.loaderOverlay.hide();
      // print(value["notifications"]["data"]);
      setState(() {
        notificationList = value["notifications"]["data"];
      });
      print(notificationList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.offAndToNamed("home"),
          child: Container(
            width: 75,
            height: 75,
            alignment: Alignment.center,
            // color: black,
            child: Icon(
              FontAwesome.angle_left,
              size: 30,
              color: CustomTheme.presntstate ? white : primary,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 33),
            Row(
              children: [
                Icon(
                  FontAwesome.bell,
                  color: success,
                  size: 20.0,
                  textDirection: TextDirection.ltr,
                  semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                ),  
                SizedBox(width: 15),
                Text(
                  "Notification",
                  style: TextStyle(
                    color: primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w500
                  )
                )
              ],
            ),
            SizedBox(height: 15),
            Visibility(
              visible: notificationList!.isNotEmpty,
              child: SizedBox(
                width: 100.w,
                height: 70.h,
                child: ListView.builder(
                  itemCount: notificationList?.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                  // return new Text(notificationList[index]);
                    // if (index == 0) {
                    //   return Badge(
                    //     animationDuration: Duration(milliseconds: 300),
                    //     animationType: BadgeAnimationType.slide,
                    //     badgeColor: success,
                    //     badgeContent: Container(
                    //       color: success,
                    //       height: 10,
                    //       width: 10,
                    //     ),
                    //     child: Container(
                    //       height: 100,
                    //       width: 90.w,
                    //       decoration: BoxDecoration(
                    //         color: CustomTheme.presntstate ? HexColor("#212845") : Color.fromRGBO(238, 238, 238, 0.67),
                    //         borderRadius: BorderRadius.circular(5)
                    //       ),
                    //       padding: EdgeInsets.all(10),
                    //       margin: EdgeInsets.only(bottom: 15),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             height: 47,
                    //             width: 47,
                    //             child: Icon(
                    //               Ionicons.mail,
                    //               color: white,
                    //             ),
                    //             decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: primary
                    //             ),
                    //           ),
                    //           SizedBox(width: 20),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 notificationList![index]["title"],
                    //                 style: TextStyle(
                    //                   color: CustomTheme.presntstate ? white : primary,
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w600
                    //                 ),
                    //               ),
                    //               SizedBox(height: 6),
                    //               Container(
                    //                 width: 154,
                    //                 child: Text(
                    //                   notificationList![index]["message"],
                    //                   softWrap: true,
                    //                   overflow: TextOverflow.clip,
                    //                   maxLines: 4,
                    //                   style: TextStyle(
                    //                     color: CustomTheme.presntstate ? white : primary,
                    //                     fontSize: 11,
                    //                     fontWeight: FontWeight.w200
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   );
                    // } 
                    return Stack(
                      children: [
                        SizedBox(height: 120),

                        Container(
                          height: 100,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: CustomTheme.presntstate ? HexColor("#212845") :Color.fromRGBO(238, 238, 238, 0.67),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 47,
                                width: 47,
                                child: Icon(
                                  Ionicons.mail,
                                  color: white,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primary
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    notificationList![index]["title"],
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? white : primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: 154,
                                    child: Text(
                                      notificationList![index]["message"],
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      maxLines: 4,
                                      style: TextStyle(
                                        color: CustomTheme.presntstate ? white : primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w200
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: index == 0,
                          child: Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#42D579")
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                )
              ),
            ),
              // child: ListView(
              //   children: [
                  // Badge(
                  //   animationDuration: Duration(milliseconds: 300),
                  //   animationType: BadgeAnimationType.slide,
                  //   badgeColor: success,
                  //   badgeContent: Container(
                  //     color: success,
                  //     height: 10,
                  //     width: 10,
                  //   ),
                  //   child: Container(
                  //     height: 100,
                  //     width: 100.w,
                  //     decoration: BoxDecoration(
                  //       color: Color.fromRGBO(238, 238, 238, 0.67),
                  //       borderRadius: BorderRadius.circular(5)
                  //     ),
                  //     padding: EdgeInsets.all(15),
                  //     margin: EdgeInsets.only(bottom: 15),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           height: 47,
                  //           width: 47,
                  //           child: Icon(
                  //             Ionicons.mail,
                  //             color: white,
                  //           ),
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: primary
                  //           ),
                  //         ),
                  //         SizedBox(width: 20),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Loan Approved",
                  //               style: TextStyle(
                  //                 color: primary,
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w600
                  //               ),
                  //             ),
                  //             SizedBox(height: 6),
                  //             Container(
                  //               width: 154,
                  //               child: Text(
                  //                 "Reach your goals quicker and easier with savings and investment with Kwikee",
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.clip,
                  //                 maxLines: 4,
                  //                 style: TextStyle(
                  //                   color: primary,
                  //                   fontSize: 11,
                  //                   fontWeight: FontWeight.w200
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
              //     Badge(
              //       animationDuration: Duration(milliseconds: 300),
              //       animationType: BadgeAnimationType.slide,
              //       badgeColor: success,
              //       badgeContent: Container(
              //         color: success,
              //         height: 10,
              //         width: 10,
              //       ),
              //       child: Container(
              //         height: 100,
              //         width: 100.w,
              //         decoration: BoxDecoration(
              //           color: Color.fromRGBO(238, 238, 238, 0.67),
              //           borderRadius: BorderRadius.circular(5)
              //         ),
              //         padding: EdgeInsets.all(15),
              //         margin: EdgeInsets.only(bottom: 15),
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               height: 47,
              //               width: 47,
              //               child: Icon(
              //                 Ionicons.mail,
              //                 color: white,
              //               ),
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: primary
              //               ),
              //             ),
              //             SizedBox(width: 20),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Loan Approved",
              //                   style: TextStyle(
              //                     color: primary,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w600
              //                   ),
              //                 ),
              //                 SizedBox(height: 6),
              //                 Container(
              //                   width: 154,
              //                   child: Text(
              //                     "Reach your goals quicker and easier with savings and investment with Kwikee",
              //                     softWrap: true,
              //                     overflow: TextOverflow.clip,
              //                     maxLines: 4,
              //                     style: TextStyle(
              //                       color: primary,
              //                       fontSize: 11,
              //                       fontWeight: FontWeight.w200
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
                  
                  
              //   ],
              // ),
            
          ],
        ),
      ),
    );
  }
}