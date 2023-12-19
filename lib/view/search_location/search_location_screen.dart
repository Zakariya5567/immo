// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:immo/helper/routes_helper.dart';
// import 'package:immo/utils/images.dart';
// import 'package:immo/utils/size.dart';
// import 'package:immo/utils/string.dart';
// import 'package:immo/utils/theme.dart';
// import 'package:provider/provider.dart';
// import '../../helper/debouncer.dart';
// import '../../localization/app_localizations.dart';
// import '../../provider/language_provider.dart';
// import '../../utils/colors.dart';
// import '../../utils/style.dart';
// import '../widgets/search_textfield.dart';
// import '../widgets/sizedbox_width.dart';

// // ignore: must_be_immutable
// class SearchLocationScreen extends StatelessWidget {
//   SearchLocationScreen({Key? key}) : super(key: key);
//   TextEditingController searchController = TextEditingController();
//   final debouncer = DeBouncer(milliseconds: 300);
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: blueStatusBar(),
//       child: SafeArea(
//         top: Platform.isAndroid ? true : false,
//         bottom: Platform.isAndroid ? true : false,
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 0.0,
//             centerTitle: false,
//             automaticallyImplyLeading: false,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const ImageIcon(
//                 AssetImage(Images.arrowBackIcon),
//                 size: 23,
//               ),
//             ),
//             title: Consumer<LanguageProvider>(
//               builder: (context, language, child) {
//                 return Text(
//                   translate(context, language.languageCode, searchLocation)!,
//                   style: textStyle(
//                       fontSize: 18,
//                       color: whitePrimary,
//                       fontFamily: satoshiMedium),
//                 );
//               },
//             ),
//           ),
//           body: Consumer<LanguageProvider>(
//             builder: (context, language, child) {
//               return Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                               child: SearchTextField(
//                             icon: Icons.search,
//                             hintText: translate(
//                                 context, language.languageCode, searchHere)!,
//                             backgroundColor: greyShadow,
//                             controller: searchController,
//                             borderColor: greyShadow,
//                           )),
//                           SizedBox(
//                             width: setWidgetWidth(7),
//                           ),
//                           Container(
//                             height: setWidgetHeight(50),
//                             width: setWidgetWidth(99),
//                             decoration: const BoxDecoration(
//                                 color: blueShadow,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(25))),
//                             child: InkWell(
//                               onTap: () {
//                                 debouncer.run(() { 
//                                 Navigator.pushNamed(
//                                     context, RouterHelper.mapSearchScreen);});
//                               },
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     Images.iconMap,
//                                     width: 20,
//                                     height: 20,
//                                   ),
//                                   SizedBox(
//                                     width: setWidgetWidth(7),
//                                   ),
//                                   Text(
//                                     translate(
//                                         context, language.languageCode, map)!,
//                                     style: textStyle(
//                                         fontSize: 16,
//                                         color: bluePrimary,
//                                         fontFamily: satoshiMedium),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ]),
//                     SizedBox(
//                       height: setWidgetHeight(13),
//                     ),
//                     Row(
//                       children: [
//                         Image.asset(
//                           Images.iconCurrentLocation,
//                           width: 18,
//                           height: 18,
//                           color: bluePrimary,
//                         ),
//                         WidthSizedBox(width: .02),
//                         Text(
//                           translate(context, language.languageCode,
//                               useMyCurrentLocation)!,
//                           style: textStyle(
//                               fontSize: 12,
//                               color: bluePrimary,
//                               fontFamily: satoshiMedium),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: setWidgetHeight(13),
//                     ),
//                     Text(
//                       translate(context, language.languageCode, recentSearch)!,
//                       style: textStyle(
//                           fontSize: 16,
//                           color: blackLight,
//                           fontFamily: satoshiMedium),
//                     ),
//                     SizedBox(
//                       height: setWidgetHeight(10),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                           itemCount: 8,
//                           itemBuilder: (context, position) {
//                             return Padding(
//                               padding:
//                                   EdgeInsets.only(bottom: setWidgetHeight(10)),
//                               child: const Text(
//                                 'Zürich.',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     color: blackPrimary,
//                                     fontFamily: satoshiRegular),
//                               ),
//                             );
//                           }),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
