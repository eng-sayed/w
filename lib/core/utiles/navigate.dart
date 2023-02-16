import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
// Future<Widget>
navigate({required BuildContext context, required Widget route}) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => route),
  );

  return Future.microtask(() {
    return route;
  });
}

// Future<Widget> buildPageAsync() async {
//   return Future.microtask(() {
//     return HeavyDetailPage();
//   });
// }

navigateReplacement({required BuildContext context, required Widget route}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}

void navigateHero({required BuildContext context, required Widget route}) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => route));
}
