import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/themes/apptheme.dart';
import './home/first.dart';
import './home/savings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/services/datstruct.dart';
import 'home/profile.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthController auth = Get.find<AuthController>();
  dynamic passedid;
  int? index = 0;
  final pages =  <Widget>[
    const First(),
    const Savings(),
    const Profile()
    // TextButton(
    //   onPressed: () { currentTheme.toggleTheme(); },
    //   child: const Text("change theme")
    // ),
  ];

  // void logout() async {
  //   // Get.back();
  //   SharedPreferences authstorage = await SharedPreferences.getInstance();
  //   authstorage.remove('user');
  //   authstorage.remove('accessToken');
  //   authstorage.remove('fingeremail');
  //   authstorage.remove('fingerpassword');
  //   authstorage.remove('passgetstarted');
  //   // authstorage.remove('firstmail');
  //   Get.offAllNamed("third");
  // }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  void changetab(int ind) {
    setState(() {
      index = ind;
    });
  }

  @override
  void initState() {
    setState(() {
      passedid = Get.arguments;
    });
    if (passedid != null) {
    setState(() {
      index = passedid;
    });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final String themestate =
    //     MediaQuery.of(context).platformBrightness == Brightness.light
    //         ? "light"
    //         : "dark";

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Yo! ${makecapitalize(auth.userdata["firstname"].toString())},",
            // "Yo! ${auth.userdata["firstname"].capitalize()}",
            // 'Hi ${auth.userdata["lastname"]},',
            softWrap: false,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600
            ),
          )
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                
                InkWell(
                  // onTap: () => logout(),
                  child: Icon(
                    FontAwesome.bell,
                    color: registerActioncolor,
                    size: 20.0,
                    textDirection: TextDirection.ltr,
                    semanticLabel:
                        'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: !CustomTheme.presntstate ? HexColor('#CCCCCC').withOpacity(0.46) : darkbottomtype
        ),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => changetab(1),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      index == 1
                          ? 'assets/image/savingactive.svg'
                          : 'assets/image/savinginactive.svg',
                      semanticsLabel: 'Savings',
                      // color: index == 1 ? iconcolorselected : iconcolor,
                      // color: Colors.red,
                    ),
                    Text(
                      "Savings",
                      style: TextStyle(
                        color: !CustomTheme.presntstate ? index == 1 ? iconcolorselected : black : index == 1 ? iconcolorselected : white,
                        fontWeight: index == 1 ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 10
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => changetab(0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      index == 0
                          ? 'assets/image/homeIconactive.svg'
                          : 'assets/image/homeIcon.svg',
                      semanticsLabel: 'Home Icon',
                      // color: index == 0 ? iconcolorselected : iconcolor,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: !CustomTheme.presntstate ? index == 0 ? iconcolorselected : black : index == 0 ? iconcolorselected : white,
                        fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 10
                    ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => changetab(2),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      index == 2
                          ?
                          // profileIconactive.svg
                          'assets/image/profileIconactive.svg'
                          : 'assets/image/profileIcon.svg',
                      semanticsLabel: 'money bill',
                      // color: index == 2 ? iconcolorselected : iconcolor,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                       color: !CustomTheme.presntstate ? index == 2 ? iconcolorselected : black : index == 2 ? iconcolorselected : white,
                        fontWeight: index == 2 ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 10
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[index!],
    );
  }
}
