import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kwikee1/controllers/withdrawalcontroller.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Creditwithdrawal extends StatefulWidget {
  const Creditwithdrawal({Key? key}) : super(key: key);

  @override
  _CreditwithdrawalState createState() => _CreditwithdrawalState();
}

class _CreditwithdrawalState extends State<Creditwithdrawal> {
  TextEditingController bankcontroller = TextEditingController();
  TextEditingController accountno = TextEditingController();
  TextEditingController modecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  WithdrawController withdraw = Get.find<WithdrawController>();
  AuthController auth = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  dynamic selectedbank;
  dynamic tranw;
  List beneficiaries = [];

  List transwhere = [
    {"text": "Other Account", "value": '2'},
    {"text": "Salary Account", "value": '1'}
  ];

  List banks = [
    {
      "id": '5d1dbeb0a1039600258b1fcf',
      "name": 'PROV"id"US BANK',
      "bankcode": '101',
      "bankcode2": '000023'
    },
    {
      "id": '5d1dbeeb4e70d700254a1507',
      "name": 'FIRST CITY MONUMENT BANK PLC',
      "bankcode": '214',
      "bankcode2": '000003'
    },
    {
      "id": '5d1dc12883a8fa0025f78964',
      "name": 'UNITY BANK PLC',
      "bankcode": '215',
      "bankcode2": '000011'
    },
    {
      "id": '5d1dc15e83a8fa0025f78965',
      "name": 'STANBIC IBTC BANK PLC',
      "bankcode": '221',
      "bankcode2": '000012'
    },
    {
      "id": '5d1dc1aaa1039600258b1fd0',
      "name": 'STERLING BANK PLC',
      "bankcode": '232',
      "bankcode2": '000001'
    },
    {
      "id": '5d1dc1cd60986c00258f2afe',
      "name": 'JAIZ BANK',
      "bankcode": '301',
      "bankcode2": '000006'
    },
    {
      "id": '5d1dc22ca1039600258b1fd1',
      "name": 'STANBIC MOBILE MONEY',
      "bankcode": '304',
      "bankcode2": '100007'
    },
    {
      "id": '5d1dc26183a8fa0025f78966',
      "name": 'PAYCOM',
      "bankcode": '305',
      "bankcode2": '100004'
    },
    {
      "id": '5d1dc31a83a8fa0025f78967',
      "name": 'FBN MOBILE',
      "bankcode": '309',
      "bankcode2": '100014'
    },
    {
      "id": '5d1dc420a1039600258b1fd2',
      "name": 'GTBANK MOBILE MONEY',
      "bankcode": '315',
      "bankcode2": '100009'
    },
    {
      "id": '5d1dc49060986c00258f2aff',
      "name": 'ZENITH MOBILE',
      "bankcode": '322',
      "bankcode2": '100018'
    },
    {
      "id": '5d1dc4cb60986c00258f2b00',
      "name": 'ACCESS MOBILE',
      "bankcode": '323',
      "bankcode2": '100013'
    },
    {
      "id": '5d1dc50860986c00258f2b01',
      "name": 'ASO SAVINGS AND LOANS',
      "bankcode": '401',
      "bankcode2": '090001'
    },
    {
      "id": '5d1dc5d260986c00258f2b02',
      "name": 'PARALLEX BANK',
      "bankcode": '526',
      "bankcode2": '090004'
    },
    {
      "id": '5d1dc63c60986c00258f2b03',
      "name": 'FSDH MERCHANT BANK',
      "bankcode": '601',
      "bankcode2": '400001'
    },
    {
      "id": '5d1dc8a683a8fa0025f78968',
      "name": 'ACCESS BANK PLC',
      "bankcode": '044',
      "bankcode2": '000014'
    },
    {
      "id": '5d1dc90183a8fa0025f78969',
      "name": 'ACCESS BANK PLC (DIAMOND)',
      "bankcode": '063',
      "bankcode2": '000014'
    },
    {
      "id": '5d1dc932a1039600258b1fd3',
      "name": 'ECOBANK NIGERIA PLC',
      "bankcode": '050',
      "bankcode2": '000010'
    },
    {
      "id": '5d1dc9aba1039600258b1fd4',
      "name": 'F"id"ELITY BANK PLC',
      "bankcode": '070',
      "bankcode2": '000007'
    },
    {
      "id": '5d1dc9f3a1039600258b1fd5',
      "name": 'FIRST BANK PLC',
      "bankcode": '011',
      "bankcode2": '000016'
    },
    {
      "id": '5d1dca4560986c00258f2b04',
      "name": 'GUARANTY TRUST BANK PLC',
      "bankcode": '058',
      "bankcode2": '000013'
    },
    {
      "id": '5d1dca7983a8fa0025f7896a',
      "name": 'HERITAGE BANK',
      "bankcode": '030',
      "bankcode2": '000020'
    },
    {
      "id": '5d1dcab383a8fa0025f7896b',
      "name": 'KEYSTONE BANK PLC',
      "bankcode": '082',
      "bankcode2": '000002'
    },
    {
      "id": '5d1dcb0e83a8fa0025f7896c',
      "name": 'POLARIS',
      "bankcode": '076',
      "bankcode2": '000008'
    },
    {
      "id": '5d1dcc8f83a8fa0025f7896d',
      "name": 'STANDARD CHARTERED BANK NIGERIA LIMITED',
      "bankcode": '068',
      "bankcode2": '000021'
    },
    {
      "id": '5d1dccd1a1039600258b1fd6',
      "name": 'UNION BANK OF NIGERIA PLC',
      "bankcode": '032',
      "bankcode2": '000018'
    },
    {
      "id": '5d1dcd9960986c00258f2b05',
      "name": 'UNITED BANK FOR AFRICA PLC',
      "bankcode": '033',
      "bankcode2": '000004'
    },
    {
      "id": '5d1dce7360986c00258f2b06',
      "name": 'WEMA BANK PLC',
      "bankcode": '035',
      "bankcode2": '000017'
    },
    {
      "id": '5d1dceae83a8fa0025f7896e',
      "name": 'ZENITH BANK PLC',
      "bankcode": '057',
      "bankcode2": '000015'
    },
    {
      "id": '5d1dcee1a1039600258b1fd7',
      "name": 'CITIBANK',
      "bankcode": '023',
      "bankcode2": '000009'
    },
    {
      "id": '5d1dd176a1039600258b1fd8',
      "name": 'SUNTRUST',
      "bankcode": '000022',
      "bankcode2": '000022'
    },
    {
      "id": '5d1dd1ada1039600258b1fd9',
      "name": 'RAND MERCHANT BANK',
      "bankcode": '000024',
      "bankcode2": '000024'
    },
    {
      "id": '5d1dd25960986c00258f2b07',
      "name": 'CORONATION',
      "bankcode": '060001',
      "bankcode2": '060001'
    },
    {
      "id": '5d1dd29583a8fa0025f7896f',
      "name": 'FBNQuest',
      "bankcode": '060002',
      "bankcode2": '060002'
    },
    {
      "id": '5d1dd2c4a1039600258b1fda',
      "name": 'NOVA',
      "bankcode": '060003',
      "bankcode2": '060003'
    },
    {
      "id": '5d1dd35e60986c00258f2b08',
      "name": 'NPF MicroFinance Bank',
      "bankcode": '070001',
      "bankcode2": '070001'
    },
    {
      "id": '5d1dd38f83a8fa0025f78970',
      "name": 'Fortis Microfinance Bank',
      "bankcode": '070002',
      "bankcode2": '070002'
    },
    {
      "id": '5d1dd3d4a1039600258b1fdb',
      "name": 'COVENANT MFB',
      "bankcode": '070006',
      "bankcode2": '070006'
    },
    {
      "id": '5d1dd40b83a8fa0025f78971',
      "name": 'OMOLUABI MORTGAGE BANK PLC',
      "bankcode": '070007',
      "bankcode2": '070007'
    },
    {
      "id": '5d1dd429a1039600258b1fdc',
      "name": 'Page MFB',
      "bankcode": '070008',
      "bankcode2": '070008'
    },
    {
      "id": '5d1dd44c83a8fa0025f78972',
      "name": 'GATEWAY MORTGAGE BANK',
      "bankcode": '070009',
      "bankcode2": '070009'
    },
    {
      "id": '5d1dd45f60986c00258f2b09',
      "name": 'ABBEY MORTGAGE BANK',
      "bankcode": '070010',
      "bankcode2": '070010'
    },
    {
      "id": '5d1dd4b2a1039600258b1fdd',
      "name": 'REFUGE MORTGAGE BANK',
      "bankcode": '070011',
      "bankcode2": '070011'
    },
    {
      "id": '5d1dda5983a8fa0025f78975',
      "name": 'LBIC MORTGAGE BANK',
      "bankcode": '070012',
      "bankcode2": '070012'
    },
    {
      "id": '5d1dda7160986c00258f2b0c',
      "name": 'PLATINUM MORTGAGE BANK',
      "bankcode": '070013',
      "bankcode2": '070013'
    },
    {
      "id": '5d1ddac94e70d700254a150e',
      "name": 'FIRST GENERATION MORTGAGE BANK',
      "bankcode": '070014',
      "bankcode2": '070014'
    },
    {
      "id": '5d1ddaf8a1039600258b1fde',
      "name": 'BRENT MORTGAGE BANK',
      "bankcode": '070015',
      "bankcode2": '070015'
    },
    {
      "id": '5d1ddb2483a8fa0025f78976',
      "name": 'INFINITY TRUST MORTGAGE BANK',
      "bankcode": '070016',
      "bankcode2": '070016'
    },
    {
      "id": '5d1ddb57a1039600258b1fdf',
      "name": 'HAGGAI MORTGAGE BANK',
      "bankcode": '070017',
      "bankcode2": '070017'
    },
    {
      "id": '5d1ddb94a1039600258b1fe0',
      "name": 'JUBILEE LIFE JubileeLife',
      "bankcode": '090003',
      "bankcode2": '090003'
    },
    {
      "id": '5f6a2dab4c96990028d1e769',
      "name": 'ACCION MFB',
      "bankcode": '090134',
      "bankcode2": '090134'
    },
    {
      "id": '5f6a2dab4c96990028d1e76a',
      "name": 'AG MORTGAGE BANK PLC',
      "bankcode": '100028',
      "bankcode2": '100028'
    },
    {
      "id": '5f6a2dab4c96990028d1e76d',
      "name": 'AMML MFB',
      "bankcode": '090116',
      "bankcode2": '090116'
    },
    {
      "id": '5f6a2dab4c96990028d1e76b',
      "name": 'AL-BARKAH MFB',
      "bankcode": '090133',
      "bankcode2": '090133'
    },
    {
      "id": '5f6a2dab4c96990028d1e76c',
      "name": 'ALLWORKERS MFB',
      "bankcode": '090131',
      "bankcode2": '090131'
    },
    {
      "id": '5f6a2dab4c96990028d1e772',
      "name": 'Astrapolis MFB',
      "bankcode": '090172',
      "bankcode2": '090172'
    },
    {
      "id": '5f6a2dab4c96990028d1e770',
      "name": 'Alphakapital MFB',
      "bankcode": '090169',
      "bankcode2": '090169'
    },
    {
      "id": '5f6a2dab4c96990028d1e771',
      "name": 'Amju MFB',
      "bankcode": '090180',
      "bankcode2": '090180'
    },
    {
      "id": '5f6a2dab4c96990028d1e76f',
      "name": 'Addosser MFBB',
      "bankcode": '090160',
      "bankcode2": '090160'
    },
    {
      "id": '5f6a2dab4c96990028d1e76e',
      "name": 'APEKS Microfinance Bank',
      "bankcode": '090143',
      "bankcode2": '090143'
    },
    {
      "id": '5f6a2dab4c96990028d1e773',
      "name": 'BC Kash MFB',
      "bankcode": '090127',
      "bankcode2": '090127'
    },
    {
      "id": '5f6a2dab4c96990028d1e776',
      "name": 'Bowen MFB',
      "bankcode": '090148',
      "bankcode2": '090148'
    },
    {
      "id": '5f6a2dab4c96990028d1e775',
      "name": 'Bosak MFB',
      "bankcode": '090176',
      "bankcode2": '090176'
    },
    {
      "id": '5f6a2dab4c96990028d1e777',
      "name": 'CEMCS MFB',
      "bankcode": '090154',
      "bankcode2": '090154'
    },
    {
      "id": '5f6a2dab4c96990028d1e774',
      "name": 'Boctrust Microfinance Bank',
      "bankcode": '090117',
      "bankcode2": '090117'
    },
    {
      "id": '5f6a2dab4c96990028d1e77a',
      "name": 'Cellulant',
      "bankcode": '100005',
      "bankcode2": '100005'
    },
    {
      "id": '5f6a2dab4c96990028d1e778',
      "name": 'CIT Microfinance Bank',
      "bankcode": '090144',
      "bankcode2": '090144'
    },
    {
      "id": '5f6a2dab4c96990028d1e77c',
      "name": 'Contec Global',
      "bankcode": '100032',
      "bankcode2": '100032'
    },
    {
      "id": '5f6a2dab4c96990028d1e77b',
      "name": 'Chikum Microfinance Bank',
      "bankcode": '090141',
      "bankcode2": '090141'
    },
    {
      "id": '5f6a2dab4c96990028d1e779',
      "name": 'CONSUMER  MFB',
      "bankcode": '090130',
      "bankcode2": '090130'
    },
    {
      "id": '5f6a2dab4c96990028d1e77e',
      "name": 'Daylight Microfinance Bank',
      "bankcode": '090167',
      "bankcode2": '090167'
    },
    {
      "id": '5f6a2dab4c96990028d1e77d',
      "name": 'Credit Afrique MFB',
      "bankcode": '090159',
      "bankcode2": '090159'
    },
    {
      "id": '5f6a2dab4c96990028d1e77f',
      "name": 'EMPIRE MFB',
      "bankcode": '090114',
      "bankcode2": '090114'
    },
    {
      "id": '5f6a2dab4c96990028d1e780',
      "name": 'Eartholeum',
      "bankcode": '100021',
      "bankcode2": '100021'
    },
    {
      "id": '5f6a2dab4c96990028d1e781',
      "name": 'Ecobank Xpress Account',
      "bankcode": '100008',
      "bankcode2": '100008'
    },
    {
      "id": '5f6a2dab4c96990028d1e782',
      "name": 'Ekondo MFB',
      "bankcode": '090097',
      "bankcode2": '090097'
    },
    {
      "id": '5f6a2dab4c96990028d1e785',
      "name": 'FBN Morgages Limited',
      "bankcode": '090107',
      "bankcode2": '090107'
    },
    {
      "id": '5f6a2dab4c96990028d1e783',
      "name": 'Eso-E Microfinance Bank',
      "bankcode": '090166',
      "bankcode2": '090166'
    },
    {
      "id": '5f6a2dab4c96990028d1e786',
      "name": 'FCMB MOBILE',
      "bankcode": '100031',
      "bankcode2": '100031'
    },
    {
      "id": '5f6a2dab4c96990028d1e784',
      "name": 'FAST MFB',
      "bankcode": '090179',
      "bankcode2": '090179'
    },
    {
      "id": '5f6a2dab4c96990028d1e787',
      "name": 'FET',
      "bankcode": '100001',
      "bankcode2": '100001'
    },
    {
      "id": '5f6a2dab4c96990028d1e788',
      "name": 'FFS Microfinance Bank',
      "bankcode": '090153',
      "bankcode2": '090153'
    },
    {
      "id": '5f6a2dab4c96990028d1e789',
      "name": 'FUTO MFB',
      "bankcode": '090158',
      "bankcode2": '090158'
    },
    {
      "id": '5f6a2dab4c96990028d1e78c',
      "name": 'FinaTrust Microfinance Bank',
      "bankcode": '090111',
      "bankcode2": '090111'
    },
    {
      "id": '5f6a2dab4c96990028d1e78a',
      "name": 'F"id"Fund MFB',
      "bankcode": '090126',
      "bankcode2": '090126'
    },
    {
      "id": '5f6a2dab4c96990028d1e78d',
      "name": 'First Multiple MFB',
      "bankcode": '090163',
      "bankcode2": '090163'
    },
    {
      "id": '5f6a2dab4c96990028d1e78b',
      "name": 'F"id"elity Mobile',
      "bankcode": '100019',
      "bankcode2": '100019'
    },
    {
      "id": '5f6a2dab4c96990028d1e792',
      "name": 'GOWANS MFB',
      "bankcode": '090122',
      "bankcode2": '090122'
    },
    {
      "id": '5f6a2dab4c96990028d1e790',
      "name": 'FortisMobile',
      "bankcode": '100016',
      "bankcode2": '100016'
    },
    {
      "id": '5f6a2dab4c96990028d1e791',
      "name": 'Full range MFB',
      "bankcode": '090145',
      "bankcode2": '090145'
    },
    {
      "id": '5f6a2dab4c96990028d1e793',
      "name": 'Gashua Microfinance Bank',
      "bankcode": '090168',
      "bankcode2": '090168'
    },
    {
      "id": '5f6a2dab4c96990028d1e78f',
      "name": 'Flutterwave Technology solutions Limited',
      "bankcode": '110002',
      "bankcode2": '110002'
    },
    {
      "id": '5f6a2dab4c96990028d1e78e',
      "name": 'First Royal Microfinance Bank',
      "bankcode": '090164',
      "bankcode2": '090164'
    },
    {
      "id": '5f6a2dab4c96990028d1e794',
      "name": 'GreenBank MFB',
      "bankcode": '090178',
      "bankcode2": '090178'
    },
    {
      "id": '5f6a2dab4c96990028d1e795',
      "name": 'HASAL MFB',
      "bankcode": '090121',
      "bankcode2": '090121'
    },
    {
      "id": '5f6a2dab4c96990028d1e796',
      "name": 'Hackman Microfinance Bank',
      "bankcode": '090147',
      "bankcode2": '090147'
    },
    {
      "id": '5f6a2dab4c96990028d1e799',
      "name": 'IBILE Microfinance Bank',
      "bankcode": '090118',
      "bankcode2": '090118'
    },
    {
      "id": '5f6a2dab4c96990028d1e79b',
      "name": 'Imperial Homes Mortgage Bank',
      "bankcode": '100024',
      "bankcode2": '100024'
    },
    {
      "id": '5f6a2dab4c96990028d1e79c',
      "name": 'Infinity MFB',
      "bankcode": '090157',
      "bankcode2": '090157'
    },
    {
      "id": '5f6a2dab4c96990028d1e79d',
      "name": 'Innovectives Kesh',
      "bankcode": '100029',
      "bankcode2": '100029'
    },
    {
      "id": '5f6a2dab4c96990028d1e797',
      "name": 'Hedonmark',
      "bankcode": '100017',
      "bankcode2": '100017'
    },
    {
      "id": '5f6a2dab4c96990028d1e79e',
      "name": 'Intellifin',
      "bankcode": '100027',
      "bankcode2": '100027'
    },
    {
      "id": '5f6a2dab4c96990028d1e79a',
      "name": 'IRL Microfinance Bank',
      "bankcode": '090149',
      "bankcode2": '090149'
    },
    {
      "id": '5f6a2dab4c96990028d1e798',
      "name": 'HighStreet MFB',
      "bankcode": '090175',
      "bankcode2": '090175'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a1',
      "name": 'Lafayette Microfinance Bank',
      "bankcode": '090155',
      "bankcode2": '090155'
    },
    {
      "id": '5f6a2dab4c96990028d1e79f',
      "name": 'KUDA MFB',
      "bankcode": '090267',
      "bankcode2": '090267'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a0',
      "name": 'Kegow',
      "bankcode": '100015',
      "bankcode2": '100015'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a4',
      "name": 'Mainstreet MFB',
      "bankcode": '090171',
      "bankcode2": '090171'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a3',
      "name": 'MONEYTRUST MFB',
      "bankcode": '090129',
      "bankcode2": '090129'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a2',
      "name": 'Lapo MFB',
      "bankcode": '090177',
      "bankcode2": '090177'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a5',
      "name": 'Malachy MFB',
      "bankcode": '090174',
      "bankcode2": '090174'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a9',
      "name": 'Mutual Trust Microfinance Bank',
      "bankcode": '090151',
      "bankcode2": '090151'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a7',
      "name": 'Mkudi',
      "bankcode": '100011',
      "bankcode2": '100011'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a6',
      "name": 'Microcred Microfinance Bank',
      "bankcode": '090136',
      "bankcode2": '090136'
    },
    {
      "id": '5f6a2dab4c96990028d1e7a8',
      "name": 'MoneyBox',
      "bankcode": '100020',
      "bankcode2": '100020'
    },
    {
      "id": '5f6a2dab4c96990028d1e7aa',
      "name": 'NIP Virtual Bank',
      "bankcode": '999999',
      "bankcode2": '999999'
    },
    {
      "id": '5f6a2dab4c96990028d1e7ac',
      "name": 'Ndiorah MFB',
      "bankcode": '090128',
      "bankcode2": '090128'
    },
    {
      "id": '5f6a2dab4c96990028d1e7ab',
      "name": 'Nargata MFB',
      "bankcode": '090152',
      "bankcode2": '090152'
    },
    {
      "id": '5f6a2dab4c96990028d1e7ad',
      "name": 'New Prudential Bank',
      "bankcode": '090108',
      "bankcode2": '090108'
    },
    {
      "id": '5f6a2dab4c96990028d1e7ae',
      "name": 'OHAFIA MFB',
      "bankcode": '090119',
      "bankcode2": '090119'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b0',
      "name": 'Okpoga MFB',
      "bankcode": '090161',
      "bankcode2": '090161'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b1',
      "name": 'Paga',
      "bankcode": '100002',
      "bankcode2": '100002'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b4',
      "name": 'Pecan Trust Microfinance Bank',
      "bankcode": '090137',
      "bankcode2": '090137'
    },
    {
      "id": '5f6a2dab4c96990028d1e7af',
      "name": 'ONE FINANCE',
      "bankcode": '100026',
      "bankcode2": '100026'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b5',
      "name": 'Personal Trust Microfinance Bank',
      "bankcode": '090135',
      "bankcode2": '090135'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b6',
      "name": 'Petra Microfinance Bank',
      "bankcode": '090165',
      "bankcode2": '090165'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b7',
      "name": 'REGENT MFB',
      "bankcode": '090125',
      "bankcode2": '090125'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b9',
      "name": 'Rahama MFB',
      "bankcode": '090170',
      "bankcode2": '090170'
    },
    {
      "id": '5f6a2dab4c96990028d1e7ba',
      "name": 'Reliance MFB',
      "bankcode": '090173',
      "bankcode2": '090173'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b8',
      "name": 'RICHWAY MFB',
      "bankcode": '090132',
      "bankcode2": '090132'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b2',
      "name": 'Parkway-ReadyCash',
      "bankcode": '100003',
      "bankcode2": '100003'
    },
    {
      "id": '5f6a2dab4c96990028d1e7bb',
      "name": 'Royal Exchange Microfinance Bank',
      "bankcode": '090138',
      "bankcode2": '090138'
    },
    {
      "id": '5f6a2dab4c96990028d1e7b3',
      "name": 'PayAttitude Online',
      "bankcode": '110001',
      "bankcode2": '110001'
    },
    {
      "id": '5f6a2dab4c96990028d1e7bd',
      "name": 'Sagamu Microfinance Bank',
      "bankcode": '090140',
      "bankcode2": '090140'
    },
    {
      "id": '5f6a2dab4c96990028d1e7be',
      "name": 'Seed Capital Microfinance Bank',
      "bankcode": '090112',
      "bankcode2": '090112'
    },
    {
      "id": '5f6a2dab4c96990028d1e7bf',
      "name": 'Stanford MFB',
      "bankcode": '090162',
      "bankcode2": '090162'
    },
    {
      "id": '5f6a2dab4c96990028d1e7bc',
      "name": 'SafeTrust',
      "bankcode": '090006',
      "bankcode2": '090006'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c3',
      "name": 'TeasyMobile',
      "bankcode": '100010',
      "bankcode2": '100010'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c0',
      "name": 'Sterling Mobile',
      "bankcode": '100022',
      "bankcode2": '100022'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c4',
      "name": 'Tr"id"ent Microfinance Bank',
      "bankcode": '090146',
      "bankcode2": '090146'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c6',
      "name": 'VFD MFB',
      "bankcode": '090110',
      "bankcode2": '090110'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c2',
      "name": 'TagPay',
      "bankcode": '100023',
      "bankcode2": '100023'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c5',
      "name": 'Trustbond',
      "bankcode": '090005',
      "bankcode2": '090005'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c8',
      "name": 'Verite Microfinance Bank',
      "bankcode": '090123',
      "bankcode2": '090123'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c1',
      "name": 'TCF',
      "bankcode": '090115',
      "bankcode2": '090115'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c7',
      "name": 'VTNetworks',
      "bankcode": '100012',
      "bankcode2": '100012'
    },
    {
      "id": '5f6a2dab4c96990028d1e7cb',
      "name": 'WETLAND MFB',
      "bankcode": '090120',
      "bankcode2": '090120'
    },
    {
      "id": '5f6a2dab4c96990028d1e7cc',
      "name": 'XSLNCE Microfinance Bank',
      "bankcode": '090124',
      "bankcode2": '090124'
    },
    {
      "id": '5f6a2dab4c96990028d1e7c9',
      "name": 'Virtue MFB',
      "bankcode": '090150',
      "bankcode2": '090150'
    },
    {
      "id": '5f6a2dab4c96990028d1e7ca',
      "name": 'Visa Microfinance Bank',
      "bankcode": '090139',
      "bankcode2": '090139'
    },
    {
      "id": '5f6a2dab4c96990028d1e7cd',
      "name": 'Yes MFB',
      "bankcode": '090142',
      "bankcode2": '090142'
    },
    {
      "id": '5f6a2dab4c96990028d1e7ce',
      "name": 'Zinternet - KongaPay',
      "bankcode": '100025',
      "bankcode2": '100025'
    },
    {
      "id": '5f6a2dab4c96990028d1e7d0',
      "name": 'eTranzact',
      "bankcode": '100006',
      "bankcode2": '100006'
    },
    {
      "id": '5f6a2dab4c96990028d1e7cf',
      "name": 'e-BARCs MFB',
      "bankcode": '090156',
      "bankcode2": '090156'
    }
  ];

  List allbanks = [];

  shoWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Mode',
          style: TextStyle(fontSize: 20, color: primary),
        ),
        // message: const Text('Select your marital status below'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Other Account',
              style: TextStyle(fontSize: 20, color: black),
            ),
            onPressed: () {
              withdraw.withform["mode"] = "2";
              modecontroller.text = "Other Account";
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Salary Account',
              style: TextStyle(fontSize: 20, color: black),
            ),
            onPressed: () {
              withdraw.withform["mode"] = "1";
              modecontroller.text = "Salary Account";
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20, color: error),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      print(withdraw.withform);
      submit();
      // Get.toNamed('dashboard/withdraw/confirm');

    } else {
      // print("not validated");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      loadashboard();
      withdraw.withform["mode"] = "2";
    });
  }

  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future submit() async {
    context.loaderOverlay.show();
    await withdraw.withdrawalstart().then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error.", bcolor: error);
        return;
      }
      if (value["status"] == "success") {
        _showMessage("Withdraw is successful", success);
        Get.offAllNamed('home', arguments: 0);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
    });
  }

  Future loadashboard() async {
    context.loaderOverlay.show();
    await auth.dashbaord().then((value) {
      context.loaderOverlay.hide();
      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error.", bcolor: error);
        return;
      }

      if (value?["status"] == "success") {
        withdraw.withform["loan_id"] = value["loans"]["loan_id"];
        if (value?["user"]["beneficiary"] != null) {
          setState(() {
            beneficiaries = value?["user"]["beneficiary"];
          });
        }        
      }
      // print(withdraw.withform);  
      // print(value["loans"]["loan_id"]);
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
    });
  }

  _showFullModal(context) {
    FocusScope.of(context).requestFocus(FocusNode());
    showGeneralDialog(
      context: context,
      barrierDismissible:
          false, // should dialog be dismissed when tapped outside
      barrierLabel: "Bank", // label for barrier
      transitionDuration: const Duration(
          milliseconds:
              50), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor:
                    !CustomTheme.presntstate ? white : darkscaffold,
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: !CustomTheme.presntstate ? Colors.black : white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(
                  "Bank",
                  style: TextStyle(
                      color: !CustomTheme.presntstate ? Colors.black87 : white,
                      fontFamily: 'Overpass',
                      fontSize: 20),
                ),
                elevation: 0.0),
            backgroundColor:
                !CustomTheme.presntstate ? whitescaffold : darkscaffold,
            body: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xfff8f8f8),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: TextField(
                      style: const TextStyle(
                        color: Color.fromRGBO(136, 136, 136, 1),
                      ),
                      onChanged: (value) {
                        final allbks = banks.where((bank) {
                          final bankname = bank["name"].toLowerCase();
                          final searchname = value.toLowerCase();
                          return bankname.contains(searchname);
                        }).toList();
                        setState(() {
                          allbanks = allbks;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        
                        hintText: "Sort Bank",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 10.0),
                        fillColor: !CustomTheme.presntstate
                            ? inputColor
                            : inputcolordark,
                        border: inputborder,
                        focusedBorder: activeinputborder,
                        enabledBorder: inputborder,
                        focusedErrorBorder: inputborder,
                        errorBorder: errorborder,
                        disabledBorder: inputborder,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      // decoration: !CustomTheme.presntstate  ? inputformdecodark : inputformdeco,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                        itemCount: allbanks.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                            onTap: () {
                              withdraw.withform["bankcode"] =
                                  allbanks[index]["bankcode"];
                              bankcontroller.text = allbanks[index]["name"];
                              Get.back();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: black))),
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  allbanks[index]["name"],
                                  style: TextStyle(
                                      color: !CustomTheme.presntstate
                                          ? black
                                          : white),
                                )),
                          );
                        }),
                  ))
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(FontAwesome.angle_left,
                        color: !CustomTheme.presntstate ? black : white,
                        size: 20
                      ),
                    ),
                  ),
                  Container(
                    width: 60.w,
                    height: 15.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/topwaver.png'),
                        fit: BoxFit.cover, // -> 02
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'New Withdrawal',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: CustomTheme.presntstate ? creditwithdark : primary 
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Enter the Amount you would like to withdraw today and the payment destination.",
                          style: TextStyle(
                            color: CustomTheme.presntstate ? inputcolordark : getstartedp, 
                            fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 12),
                        Visibility(
                          visible: withdraw.withform["mode"] != "2",
                            child: const SizedBox(height: 20)
                          ),
                        Obx(() => Visibility(
                          visible: withdraw.withform["mode"] == "2" && beneficiaries.isNotEmpty,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: beneficiaries.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    withdraw.withform["beneficiary"] = '1';
                                    modecontroller.text = "Other Account";
                                    accountno.text = beneficiaries[index]["account_number"];
                                    banks.forEach((data) {
                                      if (data["bankcode"] == beneficiaries[index]["bank_code"]) {
                                        withdraw.withform["bankcode"] =  data["bankcode"];
                                        bankcontroller.text = data["name"];
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    width: 80,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: beneficiaries[index]["logo"],
                                          imageBuilder:(context, imageProvider) =>
                                          Container(
                                            width: 60,
                                            height: 60,
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
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                        Text(
                                          '${beneficiaries[index]["account_name"]}',
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: CustomTheme.presntstate ? white : black, 
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              ),
                            ),
                          )
                        ),
                        // const SizedBox(height: 10),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'How much do you want to withdraw',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp, 
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                style: TextStyle(
                                  color: !CustomTheme.presntstate ? darkscaffold  : whitescaffold,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                                // obscureText: true,
                                validator: RequiredValidator(
                                  errorText: 'Amount is required.'),
                                  keyboardType: TextInputType.number,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                  locale: 'en',
                                  decimalDigits: 0,
                                  symbol: '₦',
                                )],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                onSaved: (val) {
                                  withdraw.formatamount(val);
                                },
                                
                              ),
                              // const SizedBox(height: 15),
                              // Text(
                              //   'Where Do you want to withdraw into',
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.w400,
                              //     fontSize: 12,
                              //     color: CustomTheme.presntstate ? inputcolordark : getstartedp, 
                              //   ),
                              // ),
                              // const SizedBox(height: 5),
                              // GestureDetector(
                              //   onTap: () => shoWidget(),
                              //   child: TextFormField(
                              //     style: TextStyle(
                              //         color: !CustomTheme.presntstate
                              //             ? darkscaffold
                              //             : whitescaffold),
                              //     // obscureText: true,
                              //     validator: (String? value) {
                              //       if (value == null) {
                              //         return 'Mode is required';
                              //       }
                              //       return null;
                              //     },
                              //     keyboardType: TextInputType.number,
                              //     autovalidateMode:
                              //         AutovalidateMode.onUserInteraction,
                              //     textInputAction: TextInputAction.done,
                              //     onSaved: (val) {
                              //       // loginstate.login["email"] = val;
                              //     },
                              //     enabled: false,
                              //     controller: modecontroller,
                              //     decoration: InputDecoration(
                              //       filled: true,
                              //       contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                              //       fillColor: !CustomTheme.presntstate
                              //           ? inputColor
                              //           : inputcolordark,
                              //       border: inputborder,
                              //       focusedBorder: activeinputborder,
                              //       enabledBorder: inputborder,
                              //       focusedErrorBorder: inputborder,
                              //       errorBorder: errorborder,
                              //       disabledBorder: inputborder,
                              //       errorStyle: const TextStyle(color: Colors.red),
                              //     )
                              //   ),
                              // ),
                              Obx(() => Visibility(
                                  visible: withdraw.withform["mode"] == "2",
                                  child: const SizedBox(height: 20))),
                              Obx(() => Visibility(
                                    visible: withdraw.withform["mode"] == "2",
                                    child: Text(
                                      'Choose Bank',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: CustomTheme.presntstate ? inputcolordark : getstartedp, 
                                      ),
                                    ),
                                  )),
                              Obx(() => Visibility(
                                  visible: withdraw.withform["mode"] == "2",
                                  child: const SizedBox(height: 5))),
                              Obx(() => Visibility(
                                    visible: withdraw.withform["mode"] == "2",
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          allbanks = banks;
                                        });
                                        allbanks.sort((a,b) =>a["name"].compareTo(b["name"]));
                                        _showFullModal(context);
                                      } ,
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: !CustomTheme.presntstate
                                                ? darkscaffold
                                                : whitescaffold),
                                        // obscureText: true,
                                        validator: RequiredValidator(errorText: "Bank is required"),
                                        keyboardType: TextInputType.number,
                                        autovalidateMode: AutovalidateMode
                                            .onUserInteraction,
                                        textInputAction: TextInputAction.done,
                                        onSaved: (val) {
                                          // loginstate.login["email"] = val;
                                        },
                                        enabled: false,
                                        controller: bankcontroller,
                                      ),
                                    ),
                                  )),
                              Obx(() => Visibility(
                                  visible: withdraw.withform["mode"] == "2",
                                  child: const SizedBox(height: 20))),
                              Obx(() => Visibility(
                                    visible: withdraw.withform["mode"] == "2",
                                    child: Text(
                                      'Account Number',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: CustomTheme.presntstate ? inputcolordark : getstartedp, 
                                      ),
                                    ),
                                  )),
                              Obx(() => Visibility(
                                  visible: withdraw.withform["mode"] == "2",
                                  child: const SizedBox(height: 5))),
                              Obx(() => Visibility(
                                  visible: withdraw.withform["mode"] == "2",
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: !CustomTheme.presntstate
                                          ? darkscaffold
                                          : whitescaffold),
                                    // obscureText: true,
          
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.done,
                                    onSaved: (val) {
                                      withdraw.withform["accountnumber"] = val;
                                    },
                                    validator: MultiValidator([
                                      RequiredValidator( errorText: "Account number is reqired"),
                                      MinLengthValidator(10,
                                        errorText:  "Account number should be more than 10")
                                    ]),
                                    controller: accountno,
                                    
                                  ),
                                )
                            ),
                              const SizedBox(height: 20),
                              Text(
                                'Pin',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp, 
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                style: TextStyle(
                                    color: !CustomTheme.presntstate
                                        ? darkscaffold
                                        : whitescaffold),
                                // obscureText: true,
          
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                onSaved: (val) {
                                  withdraw.withform["transaction_pin"] = val;
                                },
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "Pin is reqired"),
                                ]),
                                controller: pincontroller,
                                obscureText: true,
                                
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.offAllNamed("/credit");
                          Get.back();
                        },
                        child: Container(
                          width: 100.w,
                          height: 58,
                          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: labelactive
                          ),
                          child: Center(
                            child: Text(
                              'Previous',
                              style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          validate();
                        },
                        child: Container(
                          width: 100.w,
                          height: 58,
                          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: registerActioncolor
                          ),
                          child: Center(
                            child: Text(
                              'Withdraw',
                              style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
    // return Container(
    //   child: Text("idskd")
    // );
  }
}
