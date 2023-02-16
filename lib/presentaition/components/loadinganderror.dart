import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import 'custom_text.dart';
import 'my_loading.dart';

class LoadingAndError extends StatelessWidget {
  const LoadingAndError(
      {Key? key,
      this.childError,
      this.childLoading,
      required this.isError,
      required this.isLoading,
      this.function,
      required this.child})
      : super(key: key);
  final bool isError;
  final bool isLoading;
  final Widget child;
  final Widget? childError;
  final Widget? childLoading;
  final Function? function;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (isError) {
        return SizedBox(
          height: double.infinity,
          child: RefreshIndicator(
            onRefresh: () async {
              await function == null ? null : function!();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: childError ??
                  Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            "assets/images/nonet.png",
                            width: 150,
                            height: 150,
                          ),
                          CustomText(
                            'NoInternetConnection'.tr(),
                            fontsize: 18,
                            color: AppColors.primiry,
                          ),
                          if (Navigator.canPop(context))
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: CustomText(
                                  "back".tr(),
                                  color: AppColors.white,
                                ))
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        );
      } else if (isLoading) {
        return childLoading ?? MyLoading.loadingWidget();
      } else {
        return child;
      }
    });
  }
}
