import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AdmobController.dart';
import 'package:recipe_app/screen/DashboardScreen.dart';
import 'package:recipe_app/screen/DashboardWebScreen.dart';
import 'package:recipe_app/screen/WalkThroughScreen.dart';
import 'package:recipe_app/database/DatabaseHelper.dart';
import 'package:recipe_app/utils/Common.dart';
import 'package:recipe_app/utils/Constants.dart';

class SplashController extends GetxController {
  final admob = Get.find<AdmobController>();
  Logger log = Logger();

  bool showInterstitial = false;

  @override
  void onReady() async {
    log.i("onReady of splash controller");
    await admob.loadOpenad();
    super.onReady();

    await Future.delayed(Duration(seconds: 3), () async {
      admob.showAppOpen();

      //TODO: HERE GOES THE LOGIC FOR WHICH PAGE TO SHOW...

      if (isMobile) {
        database = await DatabaseHelper.instance.database;
      }
      await Future.delayed(Duration(seconds: 2));

      if (getBoolAsync(IS_FIRST_TIME, defaultValue: true) && isMobile) {
        WalkThroughScreen().launch(context, isNewTask: true);
      } else {
        if (isWeb) {
          DashboardWebScreen().launch(context, isNewTask: true);
        } else {
          DashboardScreen().launch(context, isNewTask: true);
        }
      }

      Get.off(() => StartPage(), transition: Transition.zoom);
    });
  }

  void onInit() async {
    super.onInit();
    log.i("Init of splash controller");
    // await prepareApi();
    // await admob.loadInterstitial();
  }

  prepareApi() async {
    // final response =await http.get("https://twitter-fleets.herokuapp.com/");
  }
}
