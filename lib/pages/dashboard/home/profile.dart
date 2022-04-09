import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:kwikee1/services/datstruct.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool? showsettings = true;
  bool? showtransactions = false;
  bool? nexturl = false;
  int? notify = 0;
  bool isChecked = false;
  bool loading = false;
  bool themestate = CustomTheme.presntstate;
  bool? allowauth = false;
  AuthController auth = Get.put(AuthController());
  final ScrollController _scrollController = ScrollController();
  CustomTheme theme = CustomTheme();
  dynamic dashboards;
  List transactions = [];
  List others = [];
  List lite = [];
  List displaylist = [];

  void logout() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.remove('user');
    authstorage.remove('accessToken');
    authstorage.remove('fingeremail');
    authstorage.remove('fingerpassword');
    authstorage.remove('firstmail');
    authstorage.remove("allowauth");
    authstorage.remove("liteshow");
    Get.offAllNamed("newsplash");
  }

  changebio(bool statedata) async {
    
    if (mounted) {
      setState(() {
        allowauth = true;
      });
    }
   
  }

  getstateallow() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    bool? boolstate = authstorage.getBool("allowauth");
    // if (mounted) {
    //   if (boolstate! != false) {
    //     setState(() {
    //       allowauth = boolstate;
    //     });
    //     return;
    //   }
    // }
    
    setState(() {
      allowauth = boolstate;
    });
    print("boolstate");
    print(boolstate);
  }

  sortsaving() {
    final lit = [];
    final other = [];
    transactions.forEach((v) {
      if (v?["product_mode"] == "3") {
        lit.add(v);
      }
      if (v?["product_mode"] == "2" || v?["product_mode"] == "1") {
        other.add(v);
      }
    });
    setState(() {
      lite = lit.reversed.toList();
    });
    setState(() {
      others = other.reversed.toList();
    });
    print(lite);
    print(other);
  }

  listransaction() async {
    setState(() {
      loading = true;
    });
    
    final Map data = {};
    await auth.listransaction(data: data).then((value) {
      setState(() {
        loading = false;
      });
      if (value?["status"] == "error") {
        snackbar(message: "Error", header: value["message"], bcolor: error);
      }
      if(value?["status"] == "success") {
        setState(() {
          transactions = value["transactions"]["data"];
          displaylist = value["transactions"]["data"];
        });  
        print(transactions);
        print('asm');
      }

      sortsaving();

    });
  }



  listloadmore() async {
    // setState(() {
    //   loading = true;
    // });
    if (nexturl!) {
      snackbar(message: "", header: "No more transactions", bcolor: error);
      return;
    }
    context.loaderOverlay.show();
    // print("auth.pagenumber.value * 2");
    // print(auth.pagenumber.value);
    // print(auth.pagenumber.value * 2);
    auth.pagenumber.value = auth.pagenumber.value * 2;
    final Map data = {
      "page_size": (auth.pagenumber).toString()
    };
    auth.loading.value = true;
    await auth.listransaction(data: data).then((value) {
      context.loaderOverlay.hide();
      auth.loading.value = false;
      // setState(() {
      //   loading = false;
      // });
      if (value?["status"] == "error") {
        snackbar(message: "Error", header: value["message"], bcolor: error);
      }
      if(value?["status"] == "success") {
        setState(() {
          transactions = value["transactions"]["data"];
          displaylist = value["transactions"]["data"];
        });  
        // 
        if (value["next_page_url"] == null) {
          setState(() {
            nexturl = true;
          });
        }
        print(value["next_page_url"]);
        print("next url");
      }

      sortsaving();

    });
  }

  Future loadashboard() async {
    setState(() {
      loading = true;
    });
    await auth.dashbaord().then((value) {
      setState(() {
        loading = false;
        notify = 0;
      });
      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error", bcolor: error);
        return;
      }
      setState(() {
        dashboards = value;
      });
      auth.updateuserobj(value["user"]);

      if (value?["loans"] != null) {
        print(value?["loans"]["transactions"]);
        print('asm');
        setState(() {
          transactions = value?["user"]["transactions"].reversed.toList();
          displaylist = transactions;
        });
      }
      sortsaving();
    }).catchError((err) {
      setState(() {
        loading = false;
      });
      print(err);
    });
  }

  // loadmore() async {
  //   saver.listdata["page_number"] = saver.pagenumber.value.toString();
  //   await saver.listsavingsmore().then((value) {
  //     // print();
  //     if (value?["status"] == "error") {
  //       snackbar(message: value?["message"], header: "Error", bcolor: error);
  //       return;
  //     }
  //     if (value?["status"] == "success") {
  //       // snackbar(message: value?["message"], header: "success", bcolor: success);
  //       saver.loadsaving(value?["savers"]["data"]);
  //       return;
  //     }
  //   }).catchError((err) {
  //     print(err);
  //   });
  // }

  @override
  void initState() {
    // getstateallow();
    auth.getallow();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && auth.loading.value == false) {
        setState(() {
          notify = 0;
        });
        listloadmore();
        // print("andkc");
      }
    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Text("cnimkc")
    // );
    return Scaffold(
      body: Column(
      children: [
        Container(
          width: double.infinity,
          height: 191,
          padding: const EdgeInsets.only(
              left: 30, right: 30, top: 10, bottom: 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: const Alignment(-2, 1.8),
            end: const Alignment(-1, 4),
            colors: [
              HexColor("#91D8F7"),
              HexColor("#3E4095"),
            ],
          )),
          // ignore: prefer_const_constructors
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Row(
                children: [
                  Obx(
                    () => CachedNetworkImage(
                      imageUrl:
                      auth.userdata["passport"].toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            // borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                        Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            // borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                    ),
                  ),
                  
                  const SizedBox(width: 15),
                  // ignore: prefer_const_constructors
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HELLO",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 200,
                            alignment: Alignment.centerLeft,
                            child: Obx(() => Text(
                              " ${makecapitalize(auth.userdata["firstname"].toString().toLowerCase())} ${makecapitalize(auth.userdata["lastname"].toString().toLowerCase())}",
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),
                            )),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            // width: double.infinity,
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 17),
                  height: 125,
                  decoration: BoxDecoration(
                    color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showsettings = true;
                              showtransactions = false;
                            });
                          },
                          child: Column(
                            children: [
                              Card(
                                // shadowColor: HexColor("#00000014"),
                                child: Container(
                                  height: 63,
                                  width: 63,
                                  decoration: BoxDecoration(
                                    color: CustomTheme.presntstate ? 
                                    showsettings! ? HexColor("#5162AB") : HexColor("#353E64") : 
                                    showsettings! ? primary : HexColor("#F6F6F6"),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Icon(
                                    FontAwesome.gear,
                                    size: 34,
                                    color: showsettings!
                                      ? white
                                      : HexColor("#827F7F"),
                                  ),
                                  // width: double.infinity
                                ),
                              ),
                              // const SizedBox(height: 10),
                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: CustomTheme.presntstate ? 
                                  showsettings! ? HexColor("#F6FBFE") : HexColor("#CBD1D8") : 
                                  showsettings! ? primary : HexColor("#827F7F"),
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showsettings = false;
                              showtransactions = true;
                              notify = 0;
                            });
                            auth.alloaded.value = false;
                            listransaction();
                          },
                          child: Column(
                            children: [
                              Card(
                                // shadowColor: HexColor("#00000014"),
                                child: Container(
                                  height: 63,
                                  width: 63,
                                  padding: const EdgeInsets.all(17),
                                  decoration: BoxDecoration(
                                    color: CustomTheme.presntstate ? 
                                    showtransactions! ? HexColor("#5162AB") : HexColor("#353E64") : 
                                    showtransactions! ? primary : HexColor("#F6F6F6"),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/image/nountransaction.svg',
                                    semanticsLabel: 'Transactions',
                                    color: CustomTheme.presntstate ? 
                                    showtransactions! ? white : HexColor("#212845") : 
                                    showtransactions! ? white : HexColor("#827F7F"),
                                    // color: white,
                                  ),
                                  // child: Icon(
                                  //   FontAwesome.money,
                                  //   size: 34,
                                    // color: CustomTheme.presntstate ? 
                                    // showtransactions! ? white : HexColor("#212845") : 
                                    // showtransactions! ? white : HexColor("#827F7F"),
                                  //   // color: showtransactions!
                                  //   //     ? white
                                  //   //     : HexColor("#827F7F"),
                                  // ),
                                  // width: double.infinity
                                ),
                              ),
                              // const SizedBox(height: 10),
                              Text(
                                "Transactions",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: CustomTheme.presntstate ? 
                                  showtransactions! ? HexColor("#F6FBFE") : HexColor("#CBD1D8") : 
                                  showtransactions! ? primary : HexColor("#827F7F"),
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Card(
                              // shadowColor: HexColor("#00000014"),
                              child: Container(
                                height: 63,
                                width: 63,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: CustomTheme.presntstate ? HexColor("#353E64") : HexColor("#F6F6F6"),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                // child: Icon(
                                //   FontAwesome.file_pdf_o,
                                //   size: 34,
                                //   color: HexColor("#827F7F"),
                                // ),
                                child: SvgPicture.asset(
                                  'assets/image/loandocument.svg',
                                  semanticsLabel: 'Loan document',
                                  color: CustomTheme.presntstate ? HexColor("#827F7F") : HexColor("#827F7F")
                                  // color: white,
                                ),
                                // width: double.infinity
                              ),
                            ),
                            // const SizedBox(height: 10),
                            Text(
                              "Loan Document",
                              style: TextStyle(
                                fontSize: 11,
                                color: CustomTheme.presntstate ? HexColor("#CBD1D8") : HexColor("#827F7F"),
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        )
                      ]
                  ),
                ),
                const SizedBox(height: 30),
                Visibility(
                  visible: showsettings!,
                  child: Expanded(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        children: [
                          
                          GestureDetector(
                            onTap: () => Get.toNamed("profile/changepass"),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              height: 47,
                              decoration: BoxDecoration(
                                color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/image/changepassword.svg',
                                    semanticsLabel: 'Change Password',
                                    color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                  ),
                                 
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                    // fit: BoxFit.contain,
                                    child: Text(
                                      'Change Password',
                                      style: TextStyle(
                                        color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                                )
                                ],
                              ),
                            ),
                          ),
                    
                          GestureDetector(
                            onTap: () => Get.toNamed("/profile/changepin"),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              height: 47,
                              decoration: BoxDecoration(
                                color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesome.lock,
                                    size: 18,
                                    color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      // fit: BoxFit.contain,
                                      child: Text(
                                        'Change Pin',
                                        style: TextStyle(
                                          color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () => Get.toNamed("/terms"),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              height: 47,
                              decoration: BoxDecoration(
                                color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.terminal,
                                    size: 18,
                                    color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      // fit: BoxFit.contain,
                                      child: Text(
                                        'Terms and conditions',
                                        style: TextStyle(
                                          color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            // padding: const EdgeInsets.all(10),
                            height: 47,
                            decoration: BoxDecoration(
                              color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              children: [
                                Switch(
                                  activeColor: CustomTheme.presntstate ? primary : white,
                                    inactiveThumbColor: CustomTheme.presntstate ? primary : white,
                                    activeTrackColor: CustomTheme.presntstate ? primary.withOpacity(0.2) : white,
                                    inactiveTrackColor: CustomTheme.presntstate ? primary.withOpacity(0.2) : white,
                                    value: themestate,
                                  onChanged: (bool val)  {
                                    currentTheme.toggleTheme(CustomTheme.presntstate);
                                    setState(() {
                                      themestate = val;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Container(
                                  padding: const EdgeInsets.only(left: 3),
                                  // fit: BoxFit.contain,
                                  child: Text(
                                    'Change Theme',
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            // padding: const EdgeInsets.all(10),
                            height: 47,
                            decoration: BoxDecoration(
                              color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              children: [
                                Obx(
                                  () =>
                                  Switch(
                                    activeColor: CustomTheme.presntstate ? success : success,
                                    inactiveThumbColor: CustomTheme.presntstate ? primary : white,
                                    activeTrackColor: CustomTheme.presntstate ? primary.withOpacity(0.2) : white,
                                    inactiveTrackColor: CustomTheme.presntstate ? primary.withOpacity(0.2) : white,
                                    value: auth.allowbio.value,
                                    // value: true,
                                    // onChanged: (val) => changebio(!val)
                                    onChanged: (val) {
                                      // auth.allowbio.value = !val;
                                      auth.changeStatus();
                                      print("state ${auth.allowbio.value} then $val");
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                  padding: const EdgeInsets.only(left: 3),
                                  // fit: BoxFit.contain,
                                  child:  Obx(
                                    () => Text(
                                      auth.allowbio.value ? 'Enable Finger Print / Face ID' : "Enable Finger Print / Face ID",
                                      style: TextStyle(
                                        color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                                  
                                ))
                              ],
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () => logout(),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              height: 47,
                              decoration: BoxDecoration(
                                color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/image/logoutnoun.svg',
                                    semanticsLabel: 'Logout Noun',
                                    color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    // fit: BoxFit.contain,
                                    child: Text(
                                      'Sign Out',
                                      style: TextStyle(
                                        color: CustomTheme.presntstate ? HexColor("#F6FBFE") : HexColor("#827F7F"),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                    
                          
                    
                    
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: showtransactions! && loading,
                  child: Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: showtransactions! && !loading,
                  child: Expanded(
                    child: SizedBox(
                        // margin: const EdgeInsets.only(top: 10),
                      child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  notify = 0;
                                  displaylist = transactions;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "ALL ACTIVITIES",
                                  style: TextStyle(
                                      letterSpacing: 0.57,
                                      color: CustomTheme.presntstate ? 
                                      notify! == 0 ? HexColor('#39B7E9') : HexColor("#CBD1D8") : 
                                      notify! == 0 ? HexColor('#39B7E9') : HexColor("#1C1B1B"),

                                      fontWeight: FontWeight.w500,
                                      fontSize: 9),
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1, color: notify! == 0  ? HexColor('#39B7E9') : white
                                    )
                                  )
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  notify = 1;
                                  displaylist = lite.reversed.toList();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "KWIKLITE",
                                  style: TextStyle(
                                    letterSpacing: 0.57,
                                    color: CustomTheme.presntstate ? 
                                    notify! == 1 ? HexColor('#39B7E9') : HexColor("#CBD1D8") : 
                                    notify! == 1 ? HexColor('#39B7E9') : HexColor("#1C1B1B"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  width: 1,
                                  color: notify! == 1
                                      ? HexColor('#39B7E9')
                                      : white,
                                ))),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  notify = 2;
                                  displaylist = others.reversed.toList();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "GOALS & KWIKMAX",
                                  style: TextStyle(
                                    letterSpacing: 0.57,
                                    color: CustomTheme.presntstate ? 
                                    notify! == 2 ? HexColor('#39B7E9') : HexColor("#CBD1D8") : 
                                    notify! == 2 ? HexColor('#39B7E9') : HexColor("#1C1B1B"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                      width: 1,
                                      color: notify! == 2
                                          ? HexColor('#39B7E9')
                                          : white,
                                    )
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: displaylist.isEmpty,
                          child: Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: double.infinity,
                            height: 200,
                            alignment: Alignment.center,
                            // color: prim,
                            decoration: BoxDecoration(
                              color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F6F6F6"),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              "No Data",
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                        ),
                        Visibility(
                          visible: displaylist.isNotEmpty,
                          child: Expanded(
                            child: Stack(
                              children: [
                                ListView.builder(
                                  itemCount: displaylist.length,
                                  controller: _scrollController,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                      margin: const EdgeInsets.only(bottom: 5),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: CustomTheme.presntstate ?  dackmodedashboardcaard : HexColor("#f8f8f8"),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "1" && (displaylist[index]["transaction_type"] == "1" || displaylist[index]["transaction_type"] == "2"),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/image/maxedited.svg',
                                                semanticsLabel: 'Target',
                                                width: 15,
                                                height: 15,
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "1" && (displaylist[index]["transaction_type"] == "3" || displaylist[index]["transaction_type"] == "4"),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: error,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Ionicons.close_outline,
                                                color: white,
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "2" && (displaylist[index]["transaction_type"] == "1" || displaylist[index]["transaction_type"] == "2"),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: kwikeegoals,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/image/goalsicons.svg',
                                                semanticsLabel: 'Target',
                                                width: 15,
                                                height: 15,
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "2" && (displaylist[index]["transaction_type"] == "3" || displaylist[index]["transaction_type"] == "4"),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: error,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Ionicons.close_outline,
                                                color: white,
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "5" && displaylist[index]["transaction_type"] == "5",
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: error,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Ionicons.close_outline,
                                                color: white,
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "3" && (displaylist[index]["transaction_type"] == "1" || displaylist[index]["transaction_type"] == "2"),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: registerActioncolor,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/image/goalsappicon.svg',
                                                semanticsLabel: 'Target',
                                                width: 15,
                                                height: 15,
                                              ),
                                            )
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "3" && (displaylist[index]["transaction_type"] == "3" || displaylist[index]["transaction_type"] == "4"),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: error,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Ionicons.close_outline,
                                                color: white,
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "5" && (displaylist[index]["transaction_type"] == "1" || displaylist[index]["transaction_type"] == "2"),
                                            child: Container(
                                              child: SvgPicture.asset(
                                                'assets/image/cashback.svg',
                                                semanticsLabel: 'Target',
                                                width: 25,
                                                height: 25,
                                                color: error,
                                              ),
                                            ),
                                          ),


                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "5" && (displaylist[index]["transaction_type"] == "3" || displaylist[index]["transaction_type"] == "4"),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: error,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Ionicons.close_outline,
                                                color: white,
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "4" && displaylist[index]["transaction_type"] == "2",
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: success,
                                                shape: BoxShape.circle
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                FontAwesome.angle_down,
                                                size: 20.0,
                                                color: white,
                                              )
                                            ),
                                          ),


                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "4" && displaylist[index]["transaction_type"] == "1",
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: success,
                                                shape: BoxShape.circle
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                FontAwesome.angle_down,
                                                size: 20.0,
                                                color: white,
                                              )
                                            ),
                                          ),


                                          Visibility(
                                            visible: displaylist[index]["product_mode"] == "4" && displaylist[index]["transaction_type"] == "3",
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: error,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Ionicons.close_outline,
                                                color: white,
                                              ),
                                            ),
                                          ),

                                            Visibility(
                                            visible: displaylist[index]["product_mode"] == "4" && displaylist[index]["transaction_type"] == "4",
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: error,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Ionicons.close_outline,
                                                color: white,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 20),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 5, right: 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    // "Credit Application X728829",
                                                    displaylist[index]["narration"].toString(),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: CustomTheme.presntstate ? goalstext : dashname
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        displaylist[index]["giroreference"].toString(),
                                                        style: TextStyle(
                                                          fontSize: 9.5,
                                                          fontWeight: FontWeight.w400,
                                                          color: CustomTheme.presntstate ?  white : black
                                                        ),
                                                      ),
                                                      Text(
                                                        // "15 Oct, 2022.",
                                                        dateformater(displaylist[index]["created_at"].toString()),
                                                        style: TextStyle(
                                                          fontSize: 9.5,
                                                          fontWeight: FontWeight.w400,
                                                          color: CustomTheme.presntstate ?  white : black
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ),
                                          Visibility(
                                            visible: displaylist[index]["transaction_type"] == "2",
                                            child: Text(
                                              // '₦1,500',
                                              stringamount(displaylist[index]["amount"]),
                                              style: TextStyle(
                                                color: listmoneylight,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: GoogleFonts.roboto().toString(),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: displaylist[index]["transaction_type"] == "1",
                                            child: Text(
                                              // '₦1,500',
                                              stringamount(displaylist[index]["amount"]),
                                              style: TextStyle(
                                                color: error,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: GoogleFonts.roboto().toString(),
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: displaylist[index]["transaction_type"] == "3",
                                            child: Text(
                                              // '₦1,500',
                                              stringamount(displaylist[index]["amount"]),
                                              style: TextStyle(
                                                color: error,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: GoogleFonts.roboto().toString(),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: displaylist[index]["transaction_type"] == "4",
                                            child: Text(
                                              // '₦1,500',
                                              stringamount(displaylist[index]["amount"]),
                                              style: TextStyle(
                                                color: listmoneylight,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: GoogleFonts.roboto().toString(),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: displaylist[index]["transaction_type"] == "5",
                                            child: Text(
                                              // '₦1,500',
                                              stringamount(displaylist[index]["amount"]),
                                              style: TextStyle(
                                                color: error,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: GoogleFonts.roboto().toString(),
                                              ),
                                            ),
                                          )
                                          // Text(
                                          //   // '₦1,500',
                                          //   stringamount(displaylist[index]["amount"]),
                                          //   style: TextStyle(
                                          //     color: listmoneylight,
                                          //     fontWeight: FontWeight.w600,
                                          //     fontSize: 15
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    );
                                  }),
                                // Container(color: success, width: 100.w, height: 80), 
                                //Positioned(child: Container(color: success, width: 100.w, height: 80), bottom: 0,),
                                // true ? Positioned(
                                //   left: 0,
                                //   bottom: 0,
                                //   child: Column(
                                //     children: [
                                //       Container(color: success, width: 100.w, height: 80),
                                //       Container(
                                //         height: 10,
                                //         width: 100.w,
                                //         alignment: Alignment.center,
                                //         child: Center(
                                //           child: CircularProgressIndicator.adaptive(
                                //             valueColor: AlwaysStoppedAnimation<Color>(primary),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ) : Container()
                            ],
                          ),
                            
                          ),
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }
}
