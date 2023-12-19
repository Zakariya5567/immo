import 'package:immo/provider/bedrooms_selection_provider.dart';
import 'package:immo/provider/contact_form_provider.dart';
import 'package:immo/provider/contact_us_provider.dart';
import 'package:immo/provider/detail_on_map_provider.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/provider/inquiry_form_provider.dart';
import 'package:immo/provider/language_provider.dart';
import 'package:immo/provider/more_option_provider.dart';
import 'package:immo/provider/notification_provider.dart';
import 'package:immo/provider/post_an_ad_provider.dart';
import 'package:immo/provider/property_apraisal_provider.dart';
import 'package:immo/provider/property_selection_provider.dart';
import 'package:immo/provider/search_map_provider.dart';
import 'package:immo/provider/user_profile_provider.dart';
import 'package:provider/provider.dart';

import '../provider/authentication_provider.dart';
import '../provider/home_page_provider.dart';

class ProviderHelper {
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
    ChangeNotifierProvider<PostAnAdProvider>(
        create: (context) => PostAnAdProvider()),
    ChangeNotifierProvider<PropertyAppraisalProvider>(
        create: (context) => PropertyAppraisalProvider()),
    ChangeNotifierProvider<InquiryFormProvider>(
        create: (context) => InquiryFormProvider()),
    ChangeNotifierProvider<ContactUsProvider>(
        create: (context) => ContactUsProvider()),
    ChangeNotifierProvider<UserProfileProvider>(
        create: (context) => UserProfileProvider()),
    ChangeNotifierProvider<ContactFormProvider>(
        create: (context) => ContactFormProvider()),
    ChangeNotifierProvider<MoreOptionProvider>(
        create: (context) => MoreOptionProvider()),
    ChangeNotifierProvider<FilterScreenProvider>(
        create: (context) => FilterScreenProvider()),
    ChangeNotifierProvider<HomePageProvider>(
        create: (context) => HomePageProvider()),
    ChangeNotifierProvider<BedRoomBathRoomSelectionProvider>(
        create: (context) => BedRoomBathRoomSelectionProvider()),
    ChangeNotifierProvider<PropertySelectionProvider>(
        create: (context) => PropertySelectionProvider()),
    ChangeNotifierProvider<LanguageProvider>(
        create: (context) => LanguageProvider()),
    ChangeNotifierProvider<SearchMapProvider>(
        create: (context) => SearchMapProvider()),
    ChangeNotifierProvider<NotificationProvider>(
        create: (context) => NotificationProvider()),
    ChangeNotifierProvider<DetailAdOnMapProvider>(
        create: (context) => DetailAdOnMapProvider()),
  ];
}
