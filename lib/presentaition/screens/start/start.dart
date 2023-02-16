import 'package:flutter/material.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/presentaition/layout/layout.dart';
import 'package:supa_kota/presentaition/screens/start/cubit/start_totrial_cubit.dart';

class StartTotrial extends StatefulWidget {
  const StartTotrial({super.key});

  @override
  State<StartTotrial> createState() => _StartTotrialState();
}

class _StartTotrialState extends State<StartTotrial> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = StartTotrialCubit.get(context);
      await cubit.saveOnBording();
      await Future.delayed(
        const Duration(milliseconds: 24000),
        () {
          navigateReplacement(context: context, route: HomeLayout());
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 02, color: Colors.white),
          image: DecorationImage(
            image: AssetImage("assets/images/start.gif"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
