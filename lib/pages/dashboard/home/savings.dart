import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/styles.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:clipboard/clipboard.dart';
import 'package:kwikee1/services/datstruct.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

class Savings extends StatefulWidget {
  const Savings({ Key? key }) : super(key: key);

  @override
  _SavingsState createState() => _SavingsState();
}


class _SavingsState extends State<Savings> {
  bool loading = false;
  SavingController saving = Get.put(SavingController());
  final GlobalKey<RefreshIndicatorState> refreshkey = GlobalKey<RefreshIndicatorState>();
  bool showamount = true;
  dynamic savings; 
  List lite = [{
    "amount_saved": 0
  }];
  List max = [];
  List goals= [];

  @override
  void initState() {
    saving.showliteinit();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      
      // plugin.initialize(publicKey: publicKeyTest);
      if (saving.firstload.value) {
        refreshkey.currentState?.show(); 
      } 
      if (!saving.firstload.value) {
        loadasaving();
      }
    });
    super.initState();
  }

  Future loadasaving() async {
    setState(() {
      loading = true;
    });
    await saving.allsavings().then((value) {
      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Loading error", bcolor: error);
        return;
      }
      if (value?["savings"] != null) {
        setState(() {
          savings = value?["savings"];
        });
        sortsaving();
        saving.sortsaving(value?["savings"]);
      }
      setState(() {
      loading = false;
    });
    }).catchError((err) {
      setState(() {
      loading = false;
    });
      // print(err);
    });
    saving.firstload.value = false;
  }

  changeshow(bool prenent) {
    setState(() {
      showamount = !prenent;
    });
  }

  addsaving(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext,Animation animation, Animation secondaryAnimation) {
        return Scaffold(
          backgroundColor: white.withOpacity(0),
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Get.back(),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  FontAwesome.close,
                  color: white,
                  size: 20,
                ),
              ),
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: 100.w,
                height: 100.h,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: white.withOpacity(0),
                  border: Border(
                    bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: HexColor("#707070"),
                      width: 1
                    ),
                    left: BorderSide(
                      style: BorderStyle.solid,
                      color: HexColor("#707070"),
                      width: 1
                    ),
                    right: BorderSide(
                      style: BorderStyle.solid,
                      color: HexColor("#707070"),
                      width: 1
                    ),
                  )
                  // border: Border.all(
                    // style: BorderStyle.solid,
                    // color: HexColor("#707070"),
                    // width: 1
                  // )
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    children:  [
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed('savings/max/create');
                        },
                        child: Container(
                          width: 435,
                          height: 111,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(246, 251, 254, 1)
                                  ),
                                  child: Icon(
                                    FontAwesome5Solid.piggy_bank,
                                    color: primary,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "KwikMax",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const Text(
                                        "Earn up to 18% per annum when you lock your funds for a minimum of 30 days.\nUpfront interest.",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 12,
                                          // letterSpacing: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(246, 251, 254, 0.42),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Icon(
                                      FontAwesome5Solid.arrow_right,
                                      color: white,
                                      size: 10,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
            
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed('savings/goals/create');
                        },
                        child: Container(
                          width: 435,
                          height: 111,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: savingmonth,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(246, 251, 254, 1)
                                  ),
                                  child:  SvgPicture.asset(
                                    'assets/image/maxcircle.svg',
                                    semanticsLabel: 'Target',
                                    // color: white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "KwikGoals",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const Text(
                                        "Acheive your target, save towards a particular goal. 12% per annum",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color:Color.fromRGBO(246, 251, 254, 0.42)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Icon(
                                      FontAwesome5Solid.arrow_right,
                                      color: white,
                                      size: 10,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
            
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Future getsinglesavings(String id) async {
    context.loaderOverlay.show();
    await saving.singlesave(id).then((value) {
      context.loaderOverlay.hide();
    }).catchError((onError) {
      context.loaderOverlay.hide();
      snackbar(message: "Error Occoured", header: "error", bcolor: error);
      print(onError);
      return;
    });
  }

  sortsaving() {
    final lit = [];
    final ma = [];
    final go = [];
    savings.forEach((v) {
      if (v?["type"] == "3") {
        lit.add(v);
      }
      if (v?["type"] == "1") {
        ma.add(v);
      }
      if (v?["type"] == "2") {
        go.add(v);
      }
    });
    setState(() {
      lite = lit.reversed.toList();
    });
    setState(() {
      max = ma.reversed.toList();
    });
    setState(() {
      goals = go.reversed.toList();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: RefreshIndicator(
                    onRefresh: () => loadasaving(),
                    key: refreshkey,
                    color: primary,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                "KWIK LITE",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  letterSpacing: 1.6,
                                  fontWeight: FontWeight.w300
                                ),
                              )
                            ],
                          ),
                          // const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Obx(
                                    () => Text(
                                      saving.liteshow.value ?
                                      "*****" :  stringamount(lite[0]["amount_saved"].toString()),
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: GoogleFonts.roboto().toString(),
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 10),
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () => saving.changeStatus(),
                                      child: Icon(
                                        // FontAwesome.eye,
                                        saving.liteshow.value ?
                                        FontAwesome.eye : FontAwesome.eye_slash,
                                        size: 21,
                                        color: white,
                                      ),
                                    )
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: !loading,
                                child: GestureDetector(
                                  onTap: () => Get.toNamed('savings/lite/litehome', arguments: lite[0]["investmentid"].toString()),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      FontAwesome.angle_right,
                                      size: 31,
                                      color: white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  width: 100.w,
                  height: 125,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        HexColor("#3E4095"),
                        HexColor("#91D8F7"),
                      ],
                    )
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FUND KWIKLITE",
                        style: TextStyle(
                          color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 0.6) :  const Color.fromRGBO(246, 251, 254, 1),
                          fontSize: 17,
                          letterSpacing: 2.3,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      const SizedBox(height: 20),
                      //rgba(53, 49, 48, 0.6)
                      Text(
                        "Your Kwiklite works like a regular bank account. You can fund it directly and withdraw anytime you want. 10% per annum.\n\nIt is directly connected to a unique wema bank account which could be funded using the Account Number.",
                        style: TextStyle(
                          color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 0.6).withOpacity(0.42) :  white,
                          fontSize: 12,
                          height: 1.5,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
                //account number
        
                const SizedBox(height: 20),
                Visibility(
                  visible: !loading,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, right: 30 , top: 10, bottom: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "WEMA BANK",
                              // lite[0]["payment_bank_name"].toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                                color: !CustomTheme.presntstate ? primary : white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                FlutterClipboard.copy(lite[0]["payment_account_number"].toString()).then(( value ) => snackbar(message: "Account number copied ${lite[0]["payment_account_number"].toString().toString()}", header: "Copied", bcolor: success));
                              },
                              child: Container(
                                height: 34,
                                width: 45.w,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.copy,
                                          color: white,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          lite[0]["payment_account_number"].toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: white
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // kwik max
                Obx(
                  () => Visibility(
                    visible: saving.max.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "KWIK MAX",
                                  style: TextStyle(
                                    color: !CustomTheme.presntstate ? creditcolorlight.withOpacity(0.42) :  const Color.fromRGBO(246, 251, 254, 1).withOpacity(0.42),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  FontAwesome5Solid.info_circle,
                                  color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 0.6).withOpacity(0.42) :  const Color.fromRGBO(246, 251, 254, 1).withOpacity(0.42),
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                          
                          // const SizedBox(height: 10),
                          SizedBox(
                            height: 130, 
                            width: double.infinity,
                            // padding: EdgeInsets.symmetric( ),
                            child: Obx(() => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: saving.max.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return GestureDetector(
                                  onTap: () => Get.toNamed('savings/max/maxshome', arguments: saving.max[index]["investmentid"]),
                                    // onTap: () => getsinglesavings(max[index]["investmentid"]),
                                    child: Container(
                                      margin: index == 0 ? const EdgeInsets.only(left: 20) : index == saving.max.length -1 ? const EdgeInsets.only(left: 10, right: 20) : const EdgeInsets.only(left: 10),
                                      child: Stack(
                                        children: [
                                          const SizedBox(height: 180, width: 269,),
                                          Positioned(
                                            top: 10,
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 15),
                                              height: 100,
                                              child: Container(
                                                padding: const EdgeInsets.all(10),
                                                height: 90,
                                                width: 269,
                                                decoration: BoxDecoration(
                                                  color:const Color.fromRGBO(62, 64, 149, 0.11),
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    FittedBox(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          Text(
                                                            // "CAMARY",
                                                            saving.max[index]["savings_name"].toString(),
                                                            softWrap: true,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 0.6) :  const Color.fromRGBO(246, 251, 254, 1),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                                          const SizedBox(height: 5),
                                                          Text(
                                                            // "₦300,000",
                                                            stringamount(saving.max[index]["deposit_amount"].toString()),
                                                            softWrap: true,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: !CustomTheme.presntstate ? primary : white,
                                                              fontSize: 21,
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: GoogleFonts.roboto().toString(),
                                                            ),
                                                          ),
                                                          // const SizedBox(height: 5),
                                                          // Text(
                                                          //   "₦20,000/month",
                                                          //   style: TextStyle(
                                                          //     color: kwiklightcolor.withOpacity(0.2),
                                                          //     fontSize: 10,
                                                          //     fontWeight: FontWeight.w600
                                                          //   ),
                                                          // ),                                                    
                                                        ],
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        // "1/3 Months",
                                                        saving.max[index]["month_spent"].toString(),
                                                       softWrap: true,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: savingmonth,
                                                          fontWeight: FontWeight.w300
                                                        ),
                                                      ),
                                                    )             
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            // top: 10,
                                            child: Opacity(
                                              opacity: 1,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: HexColor("#42D579"),
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  // "Matures in 310 days",
                                                  saving.max[index]["matures_in"].toString(),
                                                  softWrap: true,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              ), 
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        
                // kwik goal
                Obx(
                  () => Visibility(
                    visible: saving.goals.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children:  [
                                Text(
                                  "GOALS",
                                  style: TextStyle(
                                    color: !CustomTheme.presntstate ? creditcolorlight :  const Color.fromRGBO(246, 251, 254, 1).withOpacity(0.42),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  FontAwesome5Solid.info_circle,
                                  color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 0.6).withOpacity(0.42) :  const Color.fromRGBO(246, 251, 254, 1).withOpacity(0.42),
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(height: 10),
                          SizedBox(
                            height: 130, 
                            width: double.infinity,
                            child: Obx(() => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: saving.goals.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return  GestureDetector(
                                  onTap: () => Get.toNamed('savings/goals/goalshome', arguments: saving.goals[index]["investmentid"]),
                                  child: Container(
                                    margin: index == 0 ? const EdgeInsets.only(left: 20) : index == goals.length -1 ? const EdgeInsets.only(left: 10, right: 20) : const EdgeInsets.only(left: 10),
                                    child: Stack(
                                      children: [
                                        const SizedBox(height: 180, width: 269,),
                                        
                                        Positioned(
                                          top: 10,
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 15),
                                            height: 100,
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 74,
                                              width: 269,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(145, 216, 247, 0.24),
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 10),
                                                        Text(
                                                          makecapitalize(saving.goals[index]["savings_name"].toString()),
                                                         
                                                          softWrap: true,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 0.6) :  const Color.fromRGBO(246, 251, 254, 1),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          stringamount(saving.goals[index]["target_amount"].toString()),
                                                          softWrap: true,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontFamily: GoogleFonts.roboto().toString(),
                                                            color: !CustomTheme.presntstate ? primary : white,
                                                            fontSize: 21,
                                                            fontWeight: FontWeight.w600
                                                          ),
                                                        ),
                                                        // const SizedBox(height: 5), 
                                                        Text(
                                                          "${stringamount(saving.goals[index]["preffered_saving_amount"].toString())}/day",
                                                          softWrap: true,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 0.6) :  const Color.fromRGBO(246, 251, 254, 1),
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: GoogleFonts.roboto().toString(),
                                                          ),
                                                        ),                                                    
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      saving.goals[index]["month_spent"].toString(),
                                                      softWrap: true,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: savingmonth,
                                                        fontWeight: FontWeight.w300
                                                      ),
                                                    ),
                                                  )             
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          // top: 10,
                                          child: Opacity(
                                            opacity: 1,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: HexColor("#42D579"),
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                // "Matures in 310 days",
                                                saving.goals[index]["matures_in"].toString(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                              
                                      ],
                                    ),
                                  ),
                                );
                              }
                              )
                            ),
                            
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Add Savings",
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w700
          ),
        ),
        icon: Icon(FontAwesome5Solid.plus, color: white),
        onPressed: () => addsaving(context),
        splashColor: primary,
        hoverColor: primary,
        backgroundColor: primary,
        
      ),
    );
  }
}