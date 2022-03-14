import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import "package:kwikee1/styles.dart";
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:intl/intl.dart';


class Cashbackhome extends StatefulWidget {
  const Cashbackhome({ Key? key }) : super(key: key);

  @override
  State<Cashbackhome> createState() => _CashbackhomeState();
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox? parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme!.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox!.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class _CashbackhomeState extends State<Cashbackhome> {


  dynamic cashback;
  dynamic max;
  dynamic timeCount;
  double _currentSliderValue1 = 1000.00;
  dynamic currentStep;
  SavingController saving = Get.find<SavingController>();
  

  @override
  void initState() {
    setState(() {
      cashback = Get.arguments;
      max = Get.arguments["kwikmax"];
      _currentSliderValue1 = double.parse(cashback["offer_amount"].toString());
      date1 = DateTime.parse(cashback["start_date"].toString());
      currentStep = cashback["end_date"].toString();
      date2 = DateTime.parse(cashback["end_date"].toString());
      stepers = daysBetween(date1!, date2!);
      timeCount = double.parse(stepers.toString());
    });
    print(cashback);
    super.initState();
  }

  DateTime? date1;
  DateTime? date2;
  dynamic stepers;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  

  Future submit() async {
    // saving
    final endate = DateTime.parse(currentStep);
    final Map params = {
      "amount": _currentSliderValue1,
      "end_date":  DateFormat('yyyy-MM-dd'). format(endate)
    };
    context.loaderOverlay.show();
    await saving.previewcashback(params).then((value) {
      context.loaderOverlay.hide();
      if (value["status"] == "error") {
        snackbar(message: value?["message"], header: "error", bcolor: error);
      }
      if (value["status"] == "success") {
        setState(() {
          value["savingid"] = max["investmentid"];
        });
        Get.toNamed('cashback/preview', arguments: value);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
            width: 45,
            height: 45,
            alignment: Alignment.center,
            // color: black,
            child: Icon(
              FontAwesome.angle_left,
              size: 20,
              color: CustomTheme.presntstate ? white : black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                
                Icon(
                  FontAwesome.bell,
                  color: registerActioncolor,
                  size: 20.0,
                  // textDirection: TextDirection.ltr,
                  semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 92, 53, 1),
                    shape: BoxShape.circle
                  ),
                  child: Icon(
                    FontAwesome.money,
                    size: 30,
                    color: white,
                  )
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cashback",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: primary
                      ),
                    ),
                    Text(
                      "Get quick funds from your saved KwikMax funds with \n Kwikee Cashback.",
                      softWrap: true,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
                        color: CustomTheme.presntstate ? white : black
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 20, top: 14),
                  height: 109,
                  width: 331,
                  decoration: BoxDecoration(
                    color:const Color.fromRGBO(234, 234, 243, 1),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            max["savings_name"].toString(),
                            style: TextStyle(
                              color: kwiklightcolor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            stringamount(_currentSliderValue1.toString()),
                            style: TextStyle(
                              color: primary,
                              fontSize: 35,
                              fontFamily: GoogleFonts.roboto().toString(),
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          // const SizedBox(height: 5),
                          // Text(
                          //   "₦20,000/month",
                          //   style: TextStyle(
                          //     color: kwiklightcolor.withOpacity(0.2),
                          //     fontSize: 10,
                          //     fontFamily: GoogleFonts.roboto().toString(),
                          //     fontWeight: FontWeight.w600
                          //   ),
                          // ),                                                    
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            max["month_spent"].toString(),
                            style: TextStyle(
                              color: savingmonth,
                              fontWeight: FontWeight.w300,
                              fontSize: 17
                            ),
                          ),
                        ],
                      )             
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  // top: -10,
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      height: 30,
                      width: 148,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        max["matures_in"].toString(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  "Cashback",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: CustomTheme.presntstate ? inputcolordark : const Color.fromRGBO(53, 49, 48, 0.6),
                  ),
                ),
                Text(
                  stringamount(_currentSliderValue1.toString()),
                  style: const TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(247, 92, 53, 1),
                  ),
                ),
                // const SizedBox(height: 5),
                SliderTheme(
                  data: SliderThemeData(
                    trackShape: CustomTrackShape(),
                  ),
                  child: Slider(
                    value: _currentSliderValue1,
                    min: 1000.0,
                    max: double.parse(cashback["offer_amount"].toString()),
                    // divisions: 5,
                    activeColor: primary,
                    mouseCursor: MouseCursor.defer,
                    thumbColor: const Color.fromRGBO(247, 92, 53, 1),
                    inactiveColor: const Color.fromRGBO(0, 0, 0, 0.08),
                    label: _currentSliderValue1.round().toString(),
                    onChanged: (double value) {
                      if (value > 999) {
                        setState(() {
                          _currentSliderValue1 = value;
                        });
                      }
                      
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      stringamount('1000'),
                      // '',
                      style: const TextStyle(
                        color:Color.fromRGBO(0, 0, 0, 0.08),
                        fontSize: 10,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      // "N4000",
                      stringamount(cashback["offer_amount"].toString()),
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        fontSize: 10,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  "Repayment Date",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: CustomTheme.presntstate ? inputcolordark : const Color.fromRGBO(53, 49, 48, 0.6),
                  ),
                ),
                Text(
                  dateformater(currentStep),
                  style: const TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(247, 92, 53, 1),
                  ),
                ),
                const SizedBox(height: 10),
                SliderTheme(
                  data: SliderThemeData(
                    trackShape: CustomTrackShape(),
                  ),
                  child: Slider(
                    value: timeCount,
                    min: 0,
                    max: double.parse(stepers.toString()),
                    divisions: stepers,
                    activeColor: primary,
                    mouseCursor: MouseCursor.defer,
                    thumbColor: const Color.fromRGBO(247, 92, 53, 1),
                    inactiveColor: const Color.fromRGBO(0, 0, 0, 0.08),
                    // label: _currentSliderValue1.round().toString(), timeCount
                    onChanged: (double value) {
                      final thestartdate = DateTime.parse(cashback["start_date"].toString());
                      
                      setState(() {
                        timeCount = value;
                        currentStep = thestartdate.add(Duration(days: value.toInt())).toString();
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // "N4000",
                      dateformater(cashback["start_date"].toString()),
                      style: const TextStyle(
                        color:Color.fromRGBO(0, 0, 0, 0.08),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      dateformater(cashback["end_date"].toString()),
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 10),


          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              // onTap: () => Get.toNamed('cashback/confirm'),
              onTap: () => submit(),
              child: Card(
                color: HexColor("#0000000F"),
                child: Container(
                  width: double.infinity,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(66, 213, 121, 1),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#0000000F"),
                        blurRadius: 3,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Request Cashback',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: white
                              ),
                            ),
                            // const SizedBox(width: 10),
                            // SvgPicture.asset(
                            //   'assets/image/feather-right1.svg',
                            //   semanticsLabel: 'Action Button',
                            //   width: 20,
                            //   height: 20,
                            //   color: white,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}