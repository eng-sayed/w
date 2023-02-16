import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';

// class MyLoading {
//   static bool shown = false;

//   static show(
//     BuildContext context, {
//     bool fullScreen = true,
//   }) {
//     if (shown == false) {
//       showDialog(
//           barrierColor: Colors.white.withOpacity(0.7),
//           barrierDismissible: false,
//           context: context,
//           builder: (context) {
//             return WillPopScope(
//               onWillPop: (() => Future.value(false)),
//               child: fullScreen
//                   ? loadingWidget()
//                   : Dialog(
//                       child: SizedBox(
//                           width: 200, height: 200, child: loadingWidget())),
//             );
//           });

//       shown = true;
//     }
//   }

//   static Center loadingWidget() => Center(
//       child: Lottie.asset("assets/json/loading.json", width: 300, height: 300));

//   static dismis(BuildContext context) {
//     if (shown) {
//       Navigator.pop(context);
//       shown = false;
//     } else {}
//   }
// }

class MyLoading {
  static bool shown = false;

  static show({
    bool fullScreen = true,
  }) {
    if (shown == false) {
      SmartDialog.show(
          clickMaskDismiss: false,
          animationType: SmartAnimationType.scale,
          animationTime: Duration(milliseconds: 100),
          keepSingle: true,
          builder: (context) => fullScreen
              ? loadingWidget()
              : Dialog(
                  child: SizedBox(
                      width: 200, height: 200, child: loadingWidget())));

      shown = true;
    }
  }

  static Center loadingWidget() => Center(
      child: Image.asset("assets/images/loading.gif",
          gaplessPlayback: true, width: 150));

  static dismis() {
    if (shown) {
      SmartDialog.dismiss();
      shown = false;
    } else {}
  }
}
