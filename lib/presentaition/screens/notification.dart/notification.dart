import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/screens/notification.dart/cubit/notifications_cubit.dart';
import 'package:supa_kota/presentaition/components/toggle_clickable_container.dart';

import '../../../core/themes/colors.dart';
import '../../components/default_app_bar.dart';
import 'widgets/list_of_notifications.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool all = true, foryou = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = NotificationsCubit.get(context);
      await cubit.getAllNotifications(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = NotificationsCubit.get(context);
          return Scaffold(
              body: Column(
            children: [
              Stack(
                children: [
                  DefaultAppBar(
                    icon: 'notification',
                    title: 'Notifications'.tr(),
                    desc: 'you can see all you want here'.tr(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 55, left: 30, right: 30),
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
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 6,
                child: Direction(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListOfAllNotification(cubit: cubit)),
                ),
              )
            ],
          ));
        },
      ),
    );
  }
}
