import 'package:get/get.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/controllers/withdrawalcontroller.dart';
import 'package:kwikee1/pages/terms.dart';
import 'package:kwikee1/pages/newsplash1.dart';
import 'package:kwikee1/pages/dashboard/credit.dart';
import 'package:kwikee1/pages/dashboard/credit/camera.dart';
import 'package:kwikee1/pages/dashboard/credit/stepthree.dart';
import 'package:kwikee1/pages/dashboard/home/profile.dart';
import 'package:kwikee1/pages/dashboard/profile/changepassword.dart';
import 'package:kwikee1/pages/dashboard/profile/changepin.dart';
import 'package:kwikee1/pages/dashboard/profile/loandocument.dart';
import 'package:kwikee1/pages/dashboard/savings/cashback/cashbackconfirm.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikgoals/goalsconfirm.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikgoals/goalshome.dart';
import 'package:kwikee1/pages/dashboard/savings/kwiklite/kwiklitehome.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikmax/createmax.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikmax/maxconfirm.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikmax/maxliteaddfund.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikgoals/goalswithdraw.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikgoals/goaladdfund.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikmax/maxhome.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikmax/maxwithdraw.dart';
import 'package:kwikee1/pages/onboard.dart';
import 'package:kwikee1/pages/register_steps/enterpasssword.dart';
import 'package:kwikee1/pages/second.dart';
import '../pages/first.dart';
import '../pages/second.dart';
import '../pages/third.dart';
import '../pages/register_steps/setotp.dart';
import '../pages/register_steps/getnumber.dart';
import '../pages//register_steps/verifynumber.dart';
import '../pages/register_steps/nameandemail.dart';
import '../pages/register_steps/login.dart';
import '../pages/register_steps/password_reset.dart';
import '../pages/dashboard/home.dart';
import 'package:kwikee1/controllers/signupcontroller.dart';
import 'package:kwikee1/controllers/logincontroller.dart';
import 'package:kwikee1/pages/dashboard/savings/kwikgoals/creategoals.dart';
import '../pages/dashboard/credit/credithome.dart';
import '../pages/dashboard/credit/stepone.dart';
import '../pages/dashboard/credit/steptwo.dart';
import '../pages/dashboard/credit/stepfour.dart';
import '../pages/dashboard/credit/stepfive.dart';
import '../pages/dashboard/credit/creditpreview.dart';
import '../pages/dashboard/credit/confirmselfie.dart';
import '../pages/dashboard/credit/finalscreen.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import '../pages/dashboard/credit/takeselfie.dart';
import '../pages/dashboard/credit/creditaddbvn.dart';
import '../pages/dashboard/creditwithdrawal.dart';
import '../pages/dashboard/savings/kwiklite/litewithdrawal.dart';
import '../pages/dashboard/savings/cashback/cashbackhome.dart';
import '../pages/dashboard/savings/cashback/cashbacklisthome.dart';
import '../pages/dashboard/savings/cashback/cashbackrepay.dart';
import '../pages/dashboard/savings/cashback/cashconfirm.dart';
import '../pages/dashboard/homenav.dart';
import '../pages/dashboard/savings/kwikgoals/editgoal.dart';
import '../pages/verify.dart';
import '../pages/dashboard/notifications.dart';
import '../pages/otpmodal.dart';

List<GetPage> approutlist = [
  GetPage(
    name: '/terms',
    page: () => const Terms(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/verify',
    page: () => const Verify(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/newsplash',
    page: () => const Newsplash(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/otpage',
    page: () => const Otpmodal(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/first',
    page: () => const FirstScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(seconds: 1)
  ),
  //
  GetPage(
    name: '/second', 
    page: () => const Second(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
    name: '/notification', 
    page: () => const Notification(),
    binding: BindingsBuilder(
      () => {
       Get.put(SignupController()),
        Get.put(LoginController())
      },
    ),
    // transition: Transition.fadeIn,
    // transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
    name: '/third', 
    page: () => const Third(),
    transition: Transition.fadeIn
  ),
  GetPage(
    name: '/onboard', 
    page: () => const Onboarding(),
    transition: Transition.fadeIn,
  ),

  GetPage(
    name: '/register/getnumber', 
    page: () => const Getnumber(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
       Get.put(SignupController()),
        Get.put(LoginController())
      },
    ),
  ),

// Setotp

  GetPage(
    name: '/register/setotp', 
    page: () => const Setotp(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(SignupController()),
        Get.put(AuthController()),
      },
    ),
  ),

  GetPage(
    name: '/register/verifynumber', 
    page: () => const Verifynumber(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
       Get.put(SignupController()),
        Get.put(LoginController())
      },
    ),
  ),


  GetPage(
    name: '/register/nameandemail', 
    page: () => const Nameandemail(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(SignupController()),
        Get.put(LoginController())
      },
    ),
  ),

  GetPage(
    name: '/register/password', 
    page: () => const Password(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(SignupController()),
        Get.put(LoginController())
      },
    ),
  ),

  GetPage(
    name: '/auth/login', 
    page: () => const Login(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(LoginController())
      },
    ),
  ),


  

  GetPage(
    name: '/auth/password/reset', 
    page: () => const Passwordreset(),
    transition: Transition.rightToLeft,
     binding: BindingsBuilder(
      () => {
        Get.put(SignupController())
      },
    ),
  ),


  GetPage(
    name: '/home',
    page: () =>  const Home(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(AuthController()),
      },
    ),
  ),

  GetPage(
    name: '/home/mov', 
    page: () => const Homenav(),
    transition: Transition.fadeIn,
  ),

  GetPage(
    name: '/profile',
    page: () =>  const Profile(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(AuthController()),
      },
    ),
  ),

  GetPage(
    name: '/profile/loandocument', 
    page: () => const LoanDocument(),
    binding: BindingsBuilder(
      () => {
        Get.put(AuthController()),
      },
    ),
  ),

  GetPage(
    name: '/profile/changepin',
    page: () => const Changepin(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(AuthController()),
        Get.put(SavingController()),
        Get.put(WithdrawController())
      },
    ),
  ),

  GetPage(
    name: '/profile/changepass',
    page: () => const Changepassword(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(AuthController()),
      },
    ),
  ),

  GetPage(
    name: '/credit',
    page: () =>  const Credit(),
    transition: Transition.rightToLeft,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),
  // 

    GetPage(
    name: '/credit/withdraw',
    page: () =>  const Creditwithdrawal(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController()),
        Get.put(WithdrawController())
      },
    ),
  ),



  GetPage(
    name: '/savings/goals/goalshome',
    page: () =>  const Goalshome(),
    transition: Transition.rightToLeft
  ),
  GetPage(
    name: '/savings/goals/withdrawal',
    page: () =>  const Goalswithdraw(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(SavingController()),
        Get.put(AuthController()),
        Get.put(WithdrawController())
      },
    ),
  ),

  GetPage(
    name: '/savings/goals/create',
    page: () =>  const CreateGoals(),
    transition: Transition.rightToLeft
  ),

  GetPage(
    name: '/savings/goals/edit',
    page: () =>  const EditGoals(),
    transition: Transition.rightToLeft
  ),

  GetPage(
    name: '/savings/goals/confirm', 
    page: () => const Goalsconfirm(),
    transition: Transition.rightToLeft
  ),

  GetPage(
    name: '/savings/goals/addfund', 
    page: () => const Goalsaddfund(),
    transition: Transition.rightToLeft
  ),
  //

  GetPage(
    name: '/savings/max/maxshome',
    page: () =>  const Maxhome(),
    transition: Transition.rightToLeft
  ),
  GetPage(
    name: '/savings/max/create', 
    page: () => const CreateMax(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),
  GetPage(
    name: '/savings/max/confirm', 
    page: () => const Maxconfirm(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(SavingController()),
        Get.put(AuthController()),
        Get.put(ApplyController())
      },
    ),
  ),
   GetPage(
    name: '/savings/max/withdrawal',
    page: () =>  const Maxwithdrawal(),
    transition: Transition.rightToLeft
  ),

  GetPage(
    name: '/savings/lite/maxliteaddfund.dart',
    page: () =>  const Maxliteaddfund(),
    transition: Transition.rightToLeft
  ),
  
  GetPage(
    name: '/savings/lite/litehome', 
    page: () => const Litehome(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(SavingController())
      },
    ),
  ),

  GetPage(
    name: '/savings/lite/withdraw', 
    page: () => const Litewithdrawal(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController()),
        Get.put(WithdrawController())
      },
    ),
  ),

  // credit 

  GetPage(
    name: '/credit/home', 
    page: () => const Credithome(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),


  GetPage(
    name: '/credit/first',
    page: () => const Creditfirst(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/second', 
    page: () => const CreditSecond(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/three', 
    page: () => const Nextofkin(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),
  GetPage(
    name: '/credit/four', 
    page: () => const Employmentinfo(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/five', 
    page: () => const Employmentbank(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/preview', 
    page: () => const Creditpreview(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/final', 
    page: () => const Finalcredit(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/addbvn', 
    page: () => const Creditbvn(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/takeselfie', 
    page: () => const TakeSelfie(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/confirmselfie', 
    page: () => const Confirmselfie(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/credit/camera', 
    page: () => const Camera(),
    transition: Transition.fadeIn,
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),
  //

   GetPage(
    name: '/cashback/repayment', 
    page: () => const CashbackRepayment(),
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/cashback/list', 
    page: () => const Cashbacklist(),
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/cashback/home', 
    page: () => const Cashbackhome(),
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/cashback/confirm', 
    page: () => const Cashback(),
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),

  GetPage(
    name: '/cashback/preview', 
    page: () => const ConfirmCashback(),
    binding: BindingsBuilder(
      () => {
        Get.put(ApplyController()),
        Get.put(SavingController()),
        Get.put(AuthController())
      },
    ),
  ),


  

  // Profile

  

];