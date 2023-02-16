import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/default_app_bar.dart';
import 'package:supa_kota/presentaition/screens/auth/widget/login.dart';

import '../../components/background_image.dart';
import 'cubit/auth_cubit.dart';
import 'widget/signup.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  void initState() {
    final cubit = AuthCubit.get(context);
    cubit.tabController =
        TabController(length: 2, vsync: this, initialIndex: 0);
    cubit.tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);

    return Background(
      child: Scaffold(
        body: Column(
          children: [
            if (cubit.tabController.index == 1)
              DefaultAppBar(
                icon: 'sign up',
                title: 'signupbar'.tr(),
                desc: 'signupdis'.tr(),
              ),
            if (cubit.tabController.index == 0)
              DefaultAppBar(
                icon: 'log in',
                title: 'WelcomeBack'.tr(),
                desc: 'loginbar'.tr(),
              ),
            Container(
              height: 80,
              width: 350,
              child: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 0),
                unselectedLabelStyle: TextStyle(
                  color: AppColors.grey,
                  fontFamily:
                      context.locale == Locale('ar', 'EG') ? "stc" : "grotley",
                ),
                labelStyle: TextStyle(
                  fontSize: 22,
                  fontFamily:
                      context.locale == Locale('ar', 'EG') ? "stc" : "grotley",
                ),
                unselectedLabelColor: AppColors.grey,
                labelColor: AppColors.primiry,
                onTap: (s) {
                  cubit.tabindex = s;
                  cubit.changeHeaderAuthScreen();
                  setState(() {});
                },
                indicatorColor: AppColors.secondary,
                controller: cubit.tabController,
                tabs: [
                  Tab(
                    text: 'login'.tr(),
                  ),
                  Tab(
                    text: 'signup'.tr(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),
                    controller: cubit.tabController,
                    children: [
                      Login(),
                      SignUp(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
