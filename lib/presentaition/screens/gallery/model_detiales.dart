// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:supa_kota/presentaition/components/background_image.dart';
// import 'package:supa_kota/presentaition/components/custom_text.dart';

// import '../../../core/themes/colors.dart';
// import 'cubit/gallery_cubit.dart';
// import 'gallery_detailes.dart';
// import 'widget/image_tile.dart';

// class ModelDetailes extends StatefulWidget {
//   const ModelDetailes({super.key});

//   @override
//   State<ModelDetailes> createState() => _GalleryDetailesState();
// }

// class _GalleryDetailesState extends State<ModelDetailes> {
//   final rnd = Random();
//   // late List<int> extents;
//   // int crossAxisCount = 4;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   extents = List<int>.generate(10000, (int index) => rnd.nextInt(7) + 1);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GalleryCubit, GalleryState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         final galleryCubit = GalleryCubit.get(context);

//         return Background(
//           child: Scaffold(
//               body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.arrow_back_ios,
//                             color: AppColors.black,
//                           )),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Image.asset(
//                           'assets/images/logo2.png',
//                           fit: BoxFit.cover,
//                           width: 80,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: CustomText(
//                     'Tesla Model S',
//                     color: AppColors.primiry,
//                     textStyleEnum: TextStyleEnum.title,
//                   ),
//                 ),
//                 Expanded(
//                   child: MasonryGridView.count(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 4,
//                     crossAxisSpacing: 4,
//                     itemBuilder: (context, index) {
//                       final height = (rnd.nextInt(7) + 1) * 40;
//                       return ImageTile(
//                         isText: false,
//                         index: index,
//                         width: 300,
//                         height: height < 45 ? 90 : height,
//                         image: galleryCubit.models[index].gallery,
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           )),
//         );
//       },
//     );
//   }
// }
