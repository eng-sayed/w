import 'package:flutter/material.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/presentaition/screens/start/start.dart';

import '../../../core/utiles/firebase_message.dart';
import '../../../core/utiles/navigate.dart';
import '../on_boarding/on_boarding.dart';
import 'cubit/splach_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final splashCubit = SplachCubit.get(context);
      Future.wait([
        FBMessging.initUniLinks(),
        splashCubit.getCountriesAndCites(context)
      ]);
      await Future.delayed(
        const Duration(milliseconds: 3000),
        () async {
          splashCubit.getUserData(context);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: AppColors.primiry,
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/images/splash.gif",
          gaplessPlayback: true,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
