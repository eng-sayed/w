import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/api/my_api.dart';
import '../../data/hive/local_hive.dart';
import '../../data/local/sharedpref.dart';
import '../../firebase_options.dart';
import 'firebase_message.dart';

class Utiles {
  static bool isLogin = true;
  static bool onBoard = true;
  static bool start = true;
  static bool FirstOpen = true;
  static String token = '';
  static String name = '';
  static String UserId = '';
  static String email = '';
  static String phone = '';
  static String FCMToken = '';
  static String UserImage = '';
  static String complaint_phone = '';
  static String privacy = '';
  static bool isPartner = false;

  static ThemeMode appMode = ThemeMode.light;

  static List<String> Allphones = [];

  static String apiUrl = "https://technichal.prominaagency.com/api/";
  static String errorImage = 'assets/images/logo2.png';
  static makeCall(String phone) async {
    await FlutterPhoneDirectCaller.callNumber(phone);
    // await canLaunchUrl(Uri.parse('tel:$phone'));
  }

  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static initialized() async {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await EasyLocalization.ensureInitialized();
    CacheHelper.init();
    // HiveLocal.init();
    FirebaseMessaging.onBackgroundMessage(
        FBMessging.firebaseMessagingBackgroundHandler);
    DioHelper.init();
    //   await Hive.initFlutter();
  }
}

extension dateTimeParsing on String {
  String parseDateTime() {
    var dateTime = DateTime.tryParse(this);

    var formate1 = "${dateTime?.day} -${dateTime?.month} -${dateTime?.year}";

    return formate1;
  }
}

String fastCalc({required double amount}) {
  MoneyFormatter fmf = MoneyFormatter(amount: amount);

  return fmf.output.nonSymbol;
}
