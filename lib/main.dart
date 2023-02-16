import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'package:bot_toast/bot_toast.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/layout/cubit/layout_cubit.dart';
import 'package:supa_kota/presentaition/layout/layout.dart';
import 'package:supa_kota/presentaition/screens/become_partener/cubit/become_partner_cubit.dart';
import 'package:supa_kota/presentaition/screens/news/cubit/news_cubit.dart';
import 'package:supa_kota/presentaition/screens/notification.dart/cubit/notifications_cubit.dart';
import 'package:supa_kota/presentaition/screens/on_boarding/on_boarding.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:supa_kota/presentaition/screens/profile/cubit/profile_cubit.dart';
import 'package:supa_kota/presentaition/screens/services/cubit/services_cubit.dart';
import 'package:upgrader/upgrader.dart';
import 'core/utiles/firebase_message.dart';
import 'core/utiles/utiles.dart';
import 'cubit/app_cubit.dart';
import 'data/api/my_api.dart';
import 'data/hive/local_hive.dart';
import 'data/local/sharedpref.dart';
import 'firebase_options.dart';
import 'presentaition/screens/about_us/cubit/about_us_cubit.dart';
import 'presentaition/screens/add_car/cubit/add_car_cubit.dart';
import 'presentaition/screens/auth/cubit/auth_cubit.dart';
import 'presentaition/screens/car_detailes/cubit/car_details_cubit.dart';
import 'presentaition/screens/cart/cubit/cart_cubit.dart';
import 'presentaition/screens/edit_car/cubit/edit_car_cubit.dart';
import 'presentaition/screens/gallery/cubit/gallery_cubit.dart';
import 'presentaition/screens/my_cars/cubit/my_cars_cubit.dart';
import 'presentaition/screens/on_boarding/cubit/on_boarding_cubit.dart';
import 'presentaition/screens/reservation/cubit/reservation_cubit.dart';
import 'presentaition/screens/reviews/cubit/reviews_cubit.dart';
import 'presentaition/screens/splash_screen/cubit/splach_cubit.dart';
import 'presentaition/screens/splash_screen/splash_screen.dart';
import 'package:hive/hive.dart';

import 'presentaition/screens/start/cubit/start_totrial_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Utiles.initialized();
  runApp(EasyLocalization(
      startLocale: Locale('en', "US"),
      supportedLocales: [
        Locale('ar', "EG"),
        Locale('en', "US"),
      ],
      saveLocale: true,
      path: 'assets/translation',
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<ReservationCubit>(
        //   create: (context) => ReservationCubit(),
        // ),
        BlocProvider<EditCarCubit>(
          create: (context) => EditCarCubit(),
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
        ),
        BlocProvider<CarDetailsCubit>(
          create: (context) => CarDetailsCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider<AddCarCubit>(
          create: (context) => AddCarCubit(),
        ),
        BlocProvider<LayoutCubit>(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider<GalleryCubit>(
          create: (context) => GalleryCubit(),
        ),
        BlocProvider<ReviewsCubit>(
          create: (context) => ReviewsCubit(),
        ),
        BlocProvider<OnBoardingCubit>(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider<NewsCubit>(
          create: (context) => NewsCubit(),
        ),
        BlocProvider<MyCarsCubit>(
          create: (context) => MyCarsCubit(),
        ),
        BlocProvider<ServicesCubit>(
          create: (context) => ServicesCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<AboutUsCubit>(
          create: (context) => AboutUsCubit(),
        ),
        BlocProvider<SplachCubit>(
          create: (context) => SplachCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<StartTotrialCubit>(
          create: (context) => StartTotrialCubit(),
        ),
        BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(),
        ),
        BlocProvider<BecomePartnerCubit>(
          create: (context) => BecomePartnerCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          Utiles.rebuildAllChildren(context);
          return MaterialApp(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final smartDialog = FlutterSmartDialog.init();
              child = smartDialog(context, child);

              return Directionality(
                  textDirection: TextDirection.ltr,
                  child: ResponsiveWrapper.builder(child,
                      maxWidth: 1200,
                      minWidth: 480,
                      defaultScale: true,
                      breakpoints: [
                        ResponsiveBreakpoint.resize(480, name: MOBILE),
                        ResponsiveBreakpoint.resize(800, name: TABLET),
                        const ResponsiveBreakpoint.resize(1000,
                            name: DESKTOP, scaleFactor: 2),
                      ],
                      background: const Scaffold(
                        backgroundColor: Colors.white,
                      )));
            },
            title: 'Supa Koto',
            theme: ThemeData(
                fontFamily:
                    context.locale == Locale('ar', 'EG') ? "stc" : "grotley",
                primarySwatch: AppColors.primiry.toMaterialColor(),
                scaffoldBackgroundColor: Colors.transparent),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
