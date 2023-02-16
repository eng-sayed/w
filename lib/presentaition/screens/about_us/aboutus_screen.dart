import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/default_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/navigate.dart';
import '../../components/default_app_bar.dart';
import '../../components/network_image.dart';
import '../notification.dart/notification.dart';
import '../services/widgets/communication_wiget.dart';
import 'cubit/about_us_cubit.dart';
import 'widget/appbar_aboutus.dart';
import 'widget/brands_address.dart';
import 'widget/country_widget.dart';
import 'widget/slider_aboutUs.dart';
import 'widget/video_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = AboutUsCubit.get(context);
      await cubit.getData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: BlocConsumer<AboutUsCubit, AboutUsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = AboutUsCubit.get(context);

        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              await cubit.getData(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarAboutUs(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 20),
                      children: [
                        SliderAboutUs(cubit: cubit),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'About us'.tr(),
                                // textStyleEnum: TextStyleEnum.title,
                                color: AppColors.primiry,
                                fontsize: 21,
                                // weight: FontWeight.w600,
                              ),
                              ReadMoreText(
                                cubit.aboutUsModel?.about ?? '',
                                trimLines: 3,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'readMore'.tr(),
                                trimExpandedText: 'readLess'.tr(),
                                moreStyle: TextStyle(
                                    fontSize: 15, color: AppColors.primiry),
                                style: TextStyle(fontSize: 15),
                              ),
                              if (cubit.aboutUsModel?.youtube_video_link
                                      ?.isNotEmpty ??
                                  false)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VideoWidget(),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 450.w,
                                    child: Divider(color: AppColors.primiry),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomText(
                                  'PrivacyPolicy'.tr(),
                                  textStyleEnum: TextStyleEnum.title,
                                  color: AppColors.primiry,
                                  fontsize: 21,
                                  // weight: FontWeight.w600,
                                ),
                              ),
                              ReadMoreText(
                                cubit.aboutUsModel?.privacyPolicy ?? '',
                                trimLines: 3,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'readMore'.tr(),
                                trimExpandedText: 'readLess'.tr(),
                                moreStyle: TextStyle(
                                    fontSize: 15, color: AppColors.primiry),
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 450.w,
                                    child: Divider(color: AppColors.primiry),
                                  ),
                                ],
                              ),
                              if (cubit.countries.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: CustomText(
                                    'Our Branches'.tr(),
                                    fontsize: 21,
                                    color: AppColors.primiry,
                                  ),
                                ),
                              if (cubit.countries.isNotEmpty)
                                SizedBox(
                                  height: 70,
                                  child: ListView.builder(
                                    itemCount: cubit.countries.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CountryWidget(
                                          cubit: cubit, index: index);
                                    },
                                  ),
                                )
                            ],
                          ),
                        ),
                        if (cubit.countries.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 450.w,
                                child: Divider(color: AppColors.primiry),
                              ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'Contactteam'.tr(),
                                color: AppColors.primiry,
                                fontsize: 21,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          MyButtonWIdget(
                                            color: Colors.grey[200],
                                            width: 150,
                                            function: () {
                                              Utiles.makeCall(
                                                  Utiles.Allphones[index]);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CommuicationWidget(
                                                size: 16,
                                                num: Utiles.Allphones[index],
                                                color: AppColors.black,
                                                colorIcon: AppColors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: Utiles.Allphones.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 450.w,
                              child: Divider(color: AppColors.primiry),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomText(
                            'follow Us'.tr(),
                            color: AppColors.primiry,
                            fontsize: 21,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (cubit.aboutUsModel?.facebookLink != null)
                                GestureDetector(
                                  onTap: () async {
                                    final url =
                                        cubit.aboutUsModel?.facebookLink;
                                    if (!await launchUrl(
                                        Uri.parse(url ?? ''))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.facebook,
                                    size: 30.0,
                                    color: AppColors.primiry,
                                  ),
                                ),
                              SizedBox(
                                width: 25,
                              ),
                              if (cubit.aboutUsModel?.instagramLink != null)
                                GestureDetector(
                                  onTap: () async {
                                    final url =
                                        cubit.aboutUsModel?.instagramLink;
                                    if (!await launchUrl(
                                        Uri.parse(url ?? ''))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.instagram,
                                    size: 30.0,
                                    color: AppColors.primiry,
                                  ),
                                ),
                              SizedBox(
                                width: 25,
                              ),
                              if (cubit.aboutUsModel?.youtubeLink != null)
                                GestureDetector(
                                  onTap: () async {
                                    final url = cubit.aboutUsModel?.youtubeLink;
                                    if (!await launchUrl(
                                        Uri.parse(url ?? ''))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.youtube,
                                    size: 30.0,
                                    color: AppColors.primiry,
                                  ),
                                ),
                              SizedBox(
                                width: 25,
                              ),
                              if (cubit.aboutUsModel?.tiktokLink != null)
                                GestureDetector(
                                  onTap: () async {
                                    final url = cubit.aboutUsModel?.tiktokLink;
                                    if (!await launchUrl(
                                        Uri.parse(url ?? ''))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.tiktok,
                                    size: 25.0,
                                    color: AppColors.primiry,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 450.w,
                              child: Divider(color: AppColors.primiry),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomText(
                            'visit Site'.tr(),
                            color: AppColors.primiry,
                            fontsize: 21,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: GestureDetector(
                                onTap: () async {
                                  final url = 'https://www.supakoto.com/';
                                  if (!await launchUrl(Uri.parse(url))) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: CustomText(
                                  'www.supakoto.com',
                                  fontsize: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
