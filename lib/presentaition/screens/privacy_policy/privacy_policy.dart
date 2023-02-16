import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/loadinganderror.dart';
import 'package:supa_kota/presentaition/screens/about_us/cubit/about_us_cubit.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/navigate.dart';
import '../../components/default_app_bar.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final profileCubit = AboutUsCubit.get(context);
      if (Utiles.privacy.isEmpty || Utiles.privacy == '')
        await profileCubit.getAboutUs(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              DefaultAppBar(
                icon: 'about',
                title: 'PrivacyPolicy'.tr(),
//desc: 'see All details about supa koto'.tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                        )),
                    // GestureDetector(
                    //   onTap: () async {
                    //     // var page = await NotificationScreen();
                    //     // var route =
                    //     //     MaterialPageRoute(builder: (_) => page);
                    //     // Navigator.push(context, route);
                    //     navigate(context: context, route: NotificationScreen());
                    //   },
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.grey.shade300.withOpacity(.4),
                    //     radius: 25,
                    //     child: Padding(
                    //         padding: EdgeInsets.all(10),
                    //         child:
                    //             Image.asset('assets/images/notification1.png')),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
          BlocConsumer<AboutUsCubit, AboutUsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Expanded(
                  child: LoadingAndError(
                isError: state is AboutUsErrorState,
                isLoading: state is AboutUsLoadingState,
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    CustomText(
                      'PrivacyPolicy'.tr(),
                      textStyleEnum: TextStyleEnum.title,
                      color: AppColors.primiry,
                      fontsize: 21,
                      // weight: FontWeight.w600,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(Utiles.privacy),
                    ),
                  ],
                ),
              ));
            },
          )
        ],
      ),
    ));
  }
}
