import 'package:get/get.dart';
import 'package:kwikee1/services/backend.dart';
import 'package:kwikee1/services/utils.dart';


class SavingController extends GetxController {
  
  Backend dioclient = Backend();
  List savingslist = [].obs;
  List savingsdata = [].obs;
  var firstload = true.obs;
  List lite = [{
    "amount_saved": '0'
  }].obs;
  List max = [].obs;
  List  goals = [].obs;
  Map<String?, dynamic> savings = {
    "status": 1,
    "page_size": 10,
    "type": 2,    
    // "bankcode": "",
    // "accountnumber": "",
    // "loan_id": "",
    // "pin": "",
  }.obs;


  Map<String?, dynamic> createKwikMax = {
    // "savings_name": "a",
    "duration": "",
    "target_amount": "",
    "deposit_amount": "",
    "start_date": "",
    "type": 1,
    "payment_type": "",
    "last4": ""
  }.obs;

  Map<String?, dynamic> createKwikGoal = {
    "savings_name": "",
    "target_amount": "",
    "start_date": "",
    "saving_frequency": "",
    "preffered_saving_amount": "",
    "savings_category": "",
    "maturity_date": ""
  }.obs;

  Map<String?, dynamic> editKwikGoal = {
    "savings_name": "",
    "target_amount": "",
    "start_date": "",
    "saving_frequency": "",
    "preffered_saving_amount": "",
    "savings_category": "",
    "maturity_date": "",
    "investmentid": ""
  }.obs;

  Map<String?, dynamic> EditKwikGoal = {
    "savings_name": "",
    "end_date": "",
    "target_amount": "",
    "start_date": "",
    "saving_frequency": "",
    "preffered_saving_amount": "",
    "savings_category": "",
    "maturity_date": "",
    "investmentid": "",
    "savings_source": ""
  }.obs;

  Map<String?, dynamic> kwiklite = {
    "savings_name": ""
  };

  Map<String?, dynamic> savingwithdrawal = {
    "investmentid": "",
    "mode": "",
    "amount": "",
    "narration": "",
    "bankcode": "",
    "accountnumber": "",
    "transaction_pin": ""
  };

maxadd(List data) {

}

sortsaving(List savings) {
    final lit = [];
    final ma = [];
    final go = [];
    // lite.clear();
    
    for (var i = 0; i < savings.length; i++) {
      // print(savings[i]);
      if (savings[i]["type"] == "3") {
        lit.add(savings[i]);
      }
      if (savings[i]["type"] == "1") {
        ma.add(savings[i]);
      }
      if (savings[i]["type"] == "2") {
        go.add(savings[i]);
      }
    }
    addMax(ma);
    addGoals(go);
  }


  addMax(List data) {
    max.assignAll(data.reversed.toList());
    update();
  }
  addGoals(List data) {
    goals.assignAll(data.reversed.toList());
    update();
  }

  List get maxdata {
    return max;
  }

  loadeditKwikGoal(Map data) {
    // print(data);
    editKwikGoal["target_amount"] =  stringamount(data["target_amount"]);
    editKwikGoal["start_date"] = data["start_date"];
    editKwikGoal["maturity_date"] = data["maturity_date"];
    editKwikGoal["saving_frequency"] = data["saving_frequency"];
    editKwikGoal["preffered_saving_amount"] = stringamount(data["preffered_saving_amount"]);
    editKwikGoal["savings_category"] = data["savings_category"];
    editKwikGoal["savings_name"] = data["savings_name"];
    editKwikGoal["investmentid"] = data["investmentid"];
  }


  formatamount(String? amountSign) {
    List stringarry = amountSign != null ? amountSign.split('₦') : [];
    String numbpart = stringarry[1];
    List numbparyarr = numbpart.split(',');
    String repdata = numbparyarr.join();
    createKwikMax["deposit_amount"] = repdata;
    createKwikMax["target_amount"] = repdata;
  }

   String goalformatamount(String? amountSign) {
    try {
      List stringarry = amountSign != null ? amountSign.split('₦') : [];
      String numbpart = stringarry[1];
      List numbparyarr = numbpart.split(',');
      String repdata = numbparyarr.join();
      return repdata;
    } catch (e) {
      return '';
    }
  }

  Future <dynamic> editgoals() async {
    dynamic bodydata;
    await dioclient.editgoals(data: EditKwikGoal).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  

  Future<dynamic> addfundGoals(Map data) async {
    dynamic bodydata;
    await dioclient.addfundGoals(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future<dynamic> banklist() async {
    dynamic bodydata;
    await dioclient.banklist().then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> allsavings() async {
    dynamic bodydata;
    await dioclient.allsavings(data: savings).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> applycashback(String id) async {
    dynamic bodydata;
    await dioclient.getcashback(data: id).then((value)  {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> previewcashback(Map data) async {
    dynamic bodydata;
    await dioclient.recalculateCashback(data: data).then((value)  {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> changeAutosave({required String data}) async {
    dynamic bodydata;
    await dioclient.changeAutosave(data: data).then((value)  {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> submitCashback(Map data) async {
    dynamic bodydata;
    await dioclient.submitCashback(data: data).then((value)  {
      bodydata = value;
    });
    return bodydata;
  }


  Future <dynamic> withsavings() async {
    dynamic bodydata;
    await dioclient.withsaving(data: savingwithdrawal).then((value) {
      // print('xcv $value');
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> singlesave(String id) async {
    dynamic bodydata;
    await dioclient.singlesavings(data: id).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> kwikmaxsinglesave(String id) async {
    dynamic bodydata;
    dynamic  data = {
      "investmentid": id
    };
    await dioclient.withsavingkwik(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> singlerollover(String id) async {
    dynamic bodydata;
    Map data = {
      "investmentid": id 
    };
    await dioclient.submitKwikeerollover(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }


  Future <dynamic> makeMax() async {
    dynamic bodydata;
    await dioclient.createKwikeemax(data: createKwikMax).then((value) {
      bodydata = value;
    });
    return bodydata;
  }



  Future <dynamic> makeGoal() async {
    dynamic bodydata;
    await dioclient.createKwikgoal(data: createKwikGoal).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> submitmax(dynamic data) async {
    dynamic bodydata;
    await dioclient.submitKwikeemax(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> submitlite() async {
    dynamic bodydata;
    await dioclient.createKwikeelite(data: kwiklite).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

}  