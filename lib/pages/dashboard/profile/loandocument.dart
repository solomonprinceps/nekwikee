import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';

class LoanDocument extends StatefulWidget {
  const LoanDocument({ Key? key }) : super(key: key);

  @override
  State<LoanDocument> createState() => _LoanDocumentState();
}

class _LoanDocumentState extends State<LoanDocument> {

  // FocusScope.of(context).requestFocus(FocusNode());
  //                                   shoWidget();
  AuthController auth = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController docuementype = TextEditingController();
  TextEditingController document = TextEditingController();
  dynamic data = {
    "type" : "",
    "loan_id": "",
    "file": ""
  };

   @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      data["loan_id"] = auth.userdata["loan_id"];
    });
    print(data["loan_id"]);
    super.initState();
  }

  validate() {
    if (data["type"] == "" || data["file"] == "") {
      snackbar(message: "Error", header: "Document type and file is required", bcolor: error);
      return;
    }
    pickImage();
  }

  shoWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Document Type',
          style: TextStyle(
            fontSize: 20,
            color: primary
          ),
        ),
        // message: const Text('Select your marital status below'),
        actions: <CupertinoActionSheetAction>[
          
          
          CupertinoActionSheetAction(
            child: Text(
              'Passport Image',
              style: TextStyle(
                fontSize: 20,
                color: CustomTheme.presntstate ? white :  black
              ),
            ),
            onPressed: () {
              docuementype.text = "Passport";
              setState(() {
                data["type"] = '1';
              });
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Work Id',
              style: TextStyle(
                fontSize: 20,
                color: CustomTheme.presntstate ? white :  black
              ),
            ),
            onPressed: () {
              docuementype.text = "Work Id";
              setState(() {
                data["type"] = '2';
              });
              Navigator.pop(context);
            },
          ),
          
          
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 20,
              color: error
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  getfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg', 'docx'],
    );
    String? fileUrl = result!.files.single.path;
    setState(() {
      data["file"] = fileUrl;
    });
    document.text = fileUrl!;
  }

  pickImage() async {
    context.loaderOverlay.show();
    auth.uploadLoadDocument(data: data).then((value)  {
      context.loaderOverlay.hide();
      print(value);
      if (value?["status"] == "error") {
        snackbar(message: "Error", header: value?["message"], bcolor: error);
        return;
      }

      if (value?["status"] == "success") {
        Get.offAllNamed('home', arguments: 2);
        snackbar(message: "Success", header: value?["message"], bcolor: success);
        
        return;
      }

    }).catchError((error) {
      context.loaderOverlay.hide();
    });
    // if (result != null) {
    //   File file = File(result.files.single.path);
    // } else {
    //   // User canceled the picker
    // }
  }

  // pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   String? fileUrl = result!.files.single.path;
  //   context.loaderOverlay.show();
  //   auth.uploadLoadDocument(fileUrl).then((value)  {
  //     context.loaderOverlay.hide();
  //     print(value);
  //   }).catchError((error) {
  //     context.loaderOverlay.hide();
  //   });
  //   // if (result != null) {
  //   //   File file = File(result.files.single.path);
  //   // } else {
  //   //   // User canceled the picker
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                  Container(
                    width: 60.w,
                    height: 15.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/topwaver.png'),
                        fit: BoxFit.cover,    // -> 02
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.h, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            CustomTheme.presntstate ? 'assets/image/newlogo1white.png' :
                            'assets/image/newlogo1.png',
                            width: 25.w,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Upload Loan Document',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: CustomTheme.presntstate ? creditwithdark : primary 
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Kindly Select a loan document you want to upload.',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: CustomTheme.presntstate ? inputcolordark : getstartedp   
                            ),
                          ),
                          SizedBox(height: 6.h),
                
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  'Select document type',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                  ),
                                ),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    shoWidget();
                                  },
                                  child: TextFormField(
                                    enabled: false,
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? white : black
                                    ),
                                    // validator: MinLengthValidator(11, errorText: 'phone number must be atleast 11 digits long'),
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Document type is required'),
                                     
                                    ]),
                                    controller: docuementype,
                                    keyboardType: TextInputType.number,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.next,
                                    // onSaved: (val) {
                                    //   setState(() {
                                    //     data["pin"] = val;
                                    //   });
                                    // },
                                    // onChanged: (val) {
                                    //   setState(() {
                                    //     data["pin"] = val;
                                    //   });
                                    // },
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Select loan document',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                  ),
                                ),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    getfile();
                                  },
                                  child: TextFormField(
                                    
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? white : black
                                    ),
                                    validator: RequiredValidator(errorText: 'Password is required.'),
                                    controller: document,
                                    enabled: false,
                                    // keyboardType: TextInputType.visiblePassword,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.done,
                                    // onSaved: () {

                                    // },
                                    // onSaved: (val) {
                                    //   setState(() {
                                    //     data["password"] = val;
                                    //   }); 
                                    // },
                                    // onChanged: (val) {
                                    //   setState(() {
                                    //     data["password"] = val;
                                    //   }); 
                                    // },
                                  ),
                                ),
              
                                SizedBox(height: 5.h),
                               
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align( 
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: [
                    InkWell(
                      // onTap: () => Get.toNamed("credit/four"),
                      onTap: () => validate(),
                      child: Container(
                        width: 100.w,
                        height: 58,
                        color: const Color.fromRGBO(66, 213, 121, 1),
                        alignment: Alignment.center,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ),
                    
                
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}