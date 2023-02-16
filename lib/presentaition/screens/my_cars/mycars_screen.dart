import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/loadinganderror.dart';
import 'package:supa_kota/presentaition/screens/my_cars/cubit/my_cars_cubit.dart';

import 'widget/appbar_mycar.dart';
import 'widget/car_widget.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final myCarsCubit = MyCarsCubit.get(context);
      await myCarsCubit.getMyCars(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: BlocConsumer<MyCarsCubit, MyCarsState>(
            listener: (context, state) {},
            builder: (context, state) {
              final myCarsCubit = MyCarsCubit.get(context);
              return RefreshIndicator(
                onRefresh: () async {
                  await myCarsCubit.getMyCars(context);
                },
                child: Column(
                  children: [
                    AppBarMyCars(),
                    Directionality(
                      textDirection: context.locale == Locale('en', 'US')
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      child: Expanded(
                        child: LoadingAndError(
                          function: () async {
                            await myCarsCubit.getMyCars(context);
                          },
                          isError: state is CarsErrorState,
                          isLoading: state is CarsLoadingState,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: myCarsCubit.myCars.isEmpty
                                ? SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Center(
                                      child: CustomText(
                                        'addnewcar'.tr(),
                                        fontsize: 25,
                                        textStyleEnum: TextStyleEnum.title,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemCount: myCarsCubit.myCars.length,
                                    itemBuilder: (context, index) {
                                      return CarWidget(
                                        myCarsCubit: myCarsCubit,
                                        index: index,
                                      );
                                    }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
