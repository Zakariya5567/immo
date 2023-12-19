// import 'package:flutter/material.dart';
// import 'package:immo/utils/colors.dart';
// import 'package:immo/utils/extension/widget_extension.dart';
// import 'package:provider/provider.dart';

// import '../../../localization/app_localizations.dart';
// import '../../../provider/language_provider.dart';
// import '../../../utils/images.dart';
// import '../../../utils/size.dart';
// import '../../../utils/string.dart';
// import '../../../utils/style.dart';

// class ImagePreview extends StatefulWidget {
//   const ImagePreview({super.key, required this.image});
//   final String image;

//   @override
//   State<ImagePreview> createState() => _ImagePreviewState();
// }

// class _ImagePreviewState extends State<ImagePreview> {
//   double imageAngle = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LanguageProvider>(
//       builder: (context, language, child) {
//         return Scaffold(
//           backgroundColor: blackPrimary,
//           body: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(
//                     left: setWidgetWidth(30),
//                     right: setWidgetWidth(30),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       //Back Button
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const ImageIcon(
//                           AssetImage(
//                             Images.arrowBackIcon,
//                           ),
//                           size: 23,
//                           color: whitePrimary,
//                         ),
//                       ),
//                       // Save Button
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           translate(context, language.languageCode, save)!,
//                           style: textStyle(
//                             fontSize: 20,
//                             color: whitePrimary,
//                             fontFamily: satoshiMedium,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Transform.rotate(
//                   angle: imageAngle,
//                   child: Image(
//                     image: NetworkImage(widget.image),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Crop
//                         const ImageIcon(
//                           AssetImage(Images.crop),
//                           color: whitePrimary,
//                           size: 28,
//                         ),
//                         marginHeight(6),
//                         Text(
//                           translate(context, language.languageCode, crop)!,
//                           style: textStyle(
//                             fontSize: 18,
//                             fontFamily: satoshiRegular,
//                             color: whitePrimary,
//                           ),
//                         )
//                       ],
//                     ),
//                     marginWidth(62),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Rotate
//                         const ImageIcon(
//                           AssetImage(Images.rotate),
//                           color: whitePrimary,
//                           size: 28,
//                         ),
//                         marginHeight(6),
//                         Text(
//                           translate(context, language.languageCode, rotate)!,
//                           style: textStyle(
//                             fontSize: 18,
//                             fontFamily: satoshiRegular,
//                             color: whitePrimary,
//                           ),
//                         )
//                       ],
//                     ).onPress(() {
//                       setState(() {
//                         if (imageAngle <= 0.5) {
//                           imageAngle += 0.1;
//                         } else if (imageAngle > 0.5) {
//                           imageAngle = 0.0;
//                         }
//                       });
//                     }),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
