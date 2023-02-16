import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/cam_or_gallery.dart';
import '../../../components/default_app_bar.dart';
import '../../notification.dart/notification.dart';
import '../cubit/profile_cubit.dart';

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({
    Key? key,
    required this.profileCubit,
  }) : super(key: key);

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultAppBar(
          // icon: 'upload',
          title: '${profileCubit.user?.name ?? ''}',
          desc: 'your profile to check information'.tr(),
        ),
        Hero(
          tag: 's',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return GalleryORCamera(
                            fun0: () async {
                              await profileCubit.addImage(true, context);
                            },
                            fun1: () async {
                              await profileCubit.addImage(false, context);
                            },
                          );
                        });
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 120, right: 60),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            backgroundImage: Image.network(
                              profileCubit.user?.avatar ?? '',
                              width: 70,
                              height: 70,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/upload.png',
                                  width: 160,
                                  height: 145,
                                  fit: BoxFit.contain,
                                );
                              },
                            ).image,
                            radius: 60,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 200, right: 60),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primiry,
                          child: Icon(
                            Icons.file_upload_outlined,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 53, left: 30, right: 30),
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
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
