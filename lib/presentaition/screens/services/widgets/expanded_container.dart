// import 'package:flutter/material.dart';

// class ExpandedSection extends StatefulWidget {
//   final Widget? firstChild;
//   final Widget? secChild;
//   ExpandedSection({this.firstChild, this.secChild});

//   @override
//   _ExpandedSectionState createState() => _ExpandedSectionState();
// }

// class _ExpandedSectionState extends State<ExpandedSection>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//   Animation<double>? _animation;
//   bool show = true;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _controller!,
//       curve: Curves.fastLinearToSlowEaseIn,
//     );
//     super.initState();
//   }

//   _toggleContainer() {
//     // print(_animation!.status);
//     // if (_animation!.status != AnimationStatus.completed) {
//     //   print('open');
//     _controller!.forward();
//     show = false;
//     setState(() {});
//     // } else {
//     //   _controller!.animateBack(0, duration: Duration(milliseconds: 500));
//     // }
//   }

//   closeController() {
//     _controller!.animateBack(0, duration: Duration(milliseconds: 500));
//     show = true;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (show)
//           GestureDetector(
//             onTap: () => _toggleContainer(),
//             child: widget.firstChild!,
//           ),
//         GestureDetector(
//           onTap: () => closeController(),
//           child: SizeTransition(
//             sizeFactor: _animation!,
//             axis: Axis.vertical,
//             child: widget.secChild,
//           ),
//         ),
//       ],
//     );
//   }
// }
