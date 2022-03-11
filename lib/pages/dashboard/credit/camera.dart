import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:kwikee/controllers/applycontroller.dart';


class Camera extends StatefulWidget {
  const Camera({ Key? key }) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}


class _CameraState extends State<Camera> with WidgetsBindingObserver {
  ApplyController applycon = Get.find<ApplyController>();
  dynamic loandata;
  CameraController? controller;
  bool _isCameraInitialized = false;
  List<CameraDescription> cameras = [];
  bool snaping = false;
  XFile? PictureFile;
  var img;

  loadcamera() async {
    cameras = await availableCameras();
    onNewCameraSelected(cameras[1]);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
        setState(() {
          controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      // print('Error initializing camera: $e');
    }

    // Update the boolean
    if (mounted) {
      setState(() {
          _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }


  // uploadselfie() async {
  //   context.loaderOverlay.show();
  //   applycon.selfieupload().then((value) {
  //     // print(value);
  //     context.loaderOverlay.hide();
  //     // print(value["status"]);
  //     if (value["status"] == "success") {
  //       Get.toNamed('dashboard/apply/two', arguments: applycon.password["loan_id"]); 
  //     }

  //     if (value["status"] == "error") {
  //       Get.snackbar(
  //         "Error.", // title
  //         value["message"], // message
  //         icon: const Icon(Icons.cancel),
  //         backgroundColor: error,
  //         colorText: grey6,
  //         shouldIconPulse: true,
  //         // onTap:(){},
  //         barBlur: 20,
  //         isDismissible: true,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 2),
  //       );
  //     }
      
  //   }).catchError((onError ) {
  //     context.loaderOverlay.hide();
  //     // print(onError);
  //     Get.snackbar(
  //       "Error.", // title
  //       "Error Occoured", // message
  //       icon: const Icon(Icons.cancel),
  //       backgroundColor: error,
  //       colorText: grey6,
  //       shouldIconPulse: true,
  //       // onTap:(){},
  //       barBlur: 20,
  //       isDismissible: true,
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: const Duration(seconds: 2),
  //     );
      
  //     context.loaderOverlay.hide();
  //   });
  // }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      loadcamera();
      setState(() {
        loandata = Get.arguments;
      });
      print(loandata);
      applycon.password["loan_id"] = Get.arguments;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  firstsnapper(context) async {
    if (snaping) {
      return;
    }
    setState(() {
      snaping = true;
    });
    var ximg = await controller!.takePicture();
    setState(() {
      PictureFile = ximg;
      snaping = false;
    });
    img = PictureFile?.path;
    applycon.password["passport"] = img;
    // applycon.image = ximg;
    // final bytes = Io.File(img).readAsBytesSync();
    // String img64 = "data:image/jpg;base64,"+base64Encode(bytes);
    _showSimpleModalDialog(context);
  }

  

  _showSimpleModalDialog(context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20.0)
          ),
          child: Container(
              margin: const EdgeInsets.all(10),
              // width: 400.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                image: DecorationImage(
                  image: FileImage(Io.File(img)),
                  // image: Image.memory(img),
                  fit: BoxFit.cover
                ),
              ),
              height: 300,
              // alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () { 
                          Get.back();
                          // jsonEncode([loandata, img]
                          // uploadselfie();
                          // print(loandata);
                          // print(img);
                          Get.offAndToNamed('credit/confirmselfie', arguments: jsonEncode([loandata, img]));
                          // Get.toNamed('credit/confirmselfie', arguments: jsonEncode([loandata, img])); 
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              fontSize: 20,
                              color: white
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            img = null;
                            PictureFile = null;
                            snaping = false;
                            // applycon.password["passport"] = "";
                          });
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 20,
                              color: white
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: error,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String themestate = MediaQuery.of(context).platformBrightness == Brightness.light ? "light" : "dark";
    return Scaffold(
        body: _isCameraInitialized
            ?  Stack(
              alignment: Alignment.center,
              children: [
                controller!.buildPreview(),
                Container(
                  // color: whitecolor.withOpacity(0.7),
                  alignment: Alignment.center,
                  // child: 
                ),
    
                Camerapix(themestate: themestate),
    
                 Positioned(
                  top: 18.h,
                  // left: 35.w,
                  child: Center(
                    child: Text(
                      "Put your face in circle to take picture",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primary,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
    
                Positioned(
                  bottom: 10.h,
                  left: 33.w,
                  child: InkWell(
                    onTap: () async {
                      firstsnapper(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Take Photo',
                        style: TextStyle(
                          fontSize: 20,
                          color: white
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: error,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                )
              ],
            )
            : Container(),
    );
  }
}

class Camerapix extends StatelessWidget {
  const Camerapix({
    Key? key, this.themestate
  }) : super(key: key);

  final String? themestate;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        white.withOpacity(0.8), 
        // themestate == 'dark' ? darkbackground.withOpacity(0.8) : whitecolor.withOpacity(0.8),
        BlendMode.srcOut
      ), // This one will create the magic
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              backgroundBlendMode: BlendMode.dstOut
            ), // This one will handle background + difference out
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 600,
            width: 600,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(100),
            ),
          ),
         
        ],
      ),
    );
  }
}


// stl