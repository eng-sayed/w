import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/default_app_bar.dart';
import '../../notification.dart/notification.dart';
import '../cubit/services_cubit.dart';

class AppBarServiceDetailes extends StatelessWidget {
  const AppBarServiceDetailes({
    Key? key,
    required this.servDetailsCubit,
  }) : super(key: key);

  final ServicesCubit servDetailsCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        DefaultAppBar(),
        Padding(
          padding: const EdgeInsets.only(top: 58, left: 30, right: 30),
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
              GestureDetector(
                  onTap: () {
                    navigate(context: context, route: NotificationScreen());
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300.withOpacity(.4),
                    radius: 22,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/images/notification1.png')),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 150,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetMask(
                blendMode: BlendMode.srcATop,
                childSaveLayer: true,
                mask: Image.network(
                  servDetailsCubit.service.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: ((context, error, stackTrace) => Image.asset(
                        'assets/images/logo2.png',
                        fit: BoxFit.cover,
                      )),
                ),
                child: Image.asset(
                  'assets/images/shi.png',
                  width: 220,
                  height: 225,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
