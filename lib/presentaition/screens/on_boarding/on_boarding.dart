import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/screens/on_boarding/widgets/dots.dart';
import 'package:supa_kota/presentaition/screens/on_boarding/widgets/on_boarding_content.dart';

import '../../components/custom_text.dart';
import '../../components/default_button.dart';
import '../auth/auth_screen.dart';
import '../../components/default_app_bar.dart';
import '../../components/toggle_clickable_container.dart';
import '../select_lang/select_lang.dart';
import 'cubit/on_boarding_cubit.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  static double? blockH;
  static double? blockV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    blockH = screenW! / 100;
    blockV = screenH! / 100;
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // late PageController _controller;

  @override
  void initState() {
    final cubit = OnBoardingCubit.get(context);
    cubit.controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          SizeConfig().init(context);
          double width = SizeConfig.screenW!;
          double height = SizeConfig.screenH!;
          final cubit = OnBoardingCubit.get(context);
          return Background(
            child: Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Image.asset(
                      'assets/images/logo2.png',
                      width: 130.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: cubit.controller,
                        onPageChanged: (value) => setState(() {
                          cubit.currentPage = value;
                          print(cubit.currentPage);
                        }),
                        itemCount: contents.length,
                        itemBuilder: (context, i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(30.h),
                                child: Image.asset(
                                  contents[i].image,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 400),
                                child: CustomText(
                                  contents[i].title.tr(),
                                  align: TextAlign.center,
                                  fontsize: 22.fs,
                                  maxLines: 3,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 75),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyButton(
                            radius: 30,
                            color: AppColors.primiry,
                            width: 150,
                            text: cubit.currentPage == 2
                                ? "Let's Start".tr()
                                : 'next'.tr(),
                            fontSize: 18,
                            function: () {
                              if (cubit.controller.page! <= 1) {
                                cubit.controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                navigateReplacement(
                                    context: context, route: AuthScreen());

                                cubit.saveOnBording();
                              }
                            },
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              contents.length,
                              (int index) => Dots(
                                index: index,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  ClickableContainer(
                                    text: 'ع',
                                    color: context.locale == Locale('ar', 'EG')
                                        ? AppColors.primiry
                                        : AppColors.white,
                                    function: () async {
                                      await context
                                          .setLocale(Locale('ar', 'EG'));
                                      setState(() {});
                                    },
                                    textColor:
                                        context.locale == Locale('ar', 'EG')
                                            ? AppColors.white
                                            : AppColors.primiry,
                                    borderColor: AppColors.primiry,
                                    isSelect:
                                        context.locale == Locale('ar', 'EG')
                                            ? true
                                            : false,
                                    isRight: false,
                                  ),
                                  ClickableContainer(
                                    text: 'En',
                                    color: context.locale == Locale('en', 'US')
                                        ? AppColors.primiry
                                        : AppColors.white,
                                    function: () async {
                                      await context
                                          .setLocale(Locale('en', 'US'));
                                      setState(() {});
                                    },
                                    textColor:
                                        context.locale == Locale('en', 'US')
                                            ? AppColors.white
                                            : AppColors.primiry,
                                    borderColor: AppColors.primiry,
                                    isSelect:
                                        context.locale == Locale('en', 'US')
                                            ? true
                                            : false,
                                    isRight: true,
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: cubit.currentPage < 2,
                                replacement: SizedBox(
                                  height: 38.h,
                                  width: 55.w,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    navigateReplacement(
                                        context: context, route: AuthScreen());
                                    cubit.saveOnBording();
                                  },
                                  child: CustomText(
                                    "skip".tr(),
                                    fontsize: 20,
                                    color: AppColors.primiry,
                                  ),
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: (width <= 550) ? 13 : 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
