import 'package:flutter/material.dart';
import 'package:immo/view/ad_details/ad_details_screen.dart';
import 'package:immo/view/authentication_screen/create_password_screen.dart';
import 'package:immo/view/authentication_screen/forgot_password_screen.dart';
import 'package:immo/view/authentication_screen/signup_screen.dart';
import 'package:immo/view/contact_us/contact_us_screen.dart';
import 'package:immo/view/filter_screen/filter_screen.dart';
import 'package:immo/view/inquiry_management/inquiry_management_screen.dart';
import 'package:immo/view/more_options/components/privacy_policy_screen.dart';
import 'package:immo/view/more_options/more_option_screen.dart';
import 'package:immo/view/my_alerts/my_alerts_screen.dart';
import 'package:immo/view/notification/notification_list.dart';
import 'package:immo/view/on_boarding_screen/on_boarding_first_screen.dart';
import 'package:immo/view/post_an_ad/components/ad_map_location_selection.dart';
import 'package:immo/view/post_an_ad/post_an_ad_first_screen.dart';
import 'package:immo/view/post_an_ad/post_an_ad_second_screen.dart';
import 'package:immo/view/post_an_ad/post_an_ad_third_screen.dart';
import 'package:immo/view/search_location/map_search_screen.dart';
import 'package:immo/view/splash_screen/splash_screen.dart';
import 'package:immo/view/user_profile/components/select_location.dart';
import 'package:immo/view/user_profile/set_profile.dart';
import 'package:immo/view/widgets/detail_ad_on_map.dart';
import 'package:immo/view/widgets/location_access_permission.dart';

import '../view/authentication_screen/compnay_signup_screen.dart';
import '../view/authentication_screen/signin_screen/email_screen.dart';
import '../view/authentication_screen/signin_screen/password_screen.dart';
import '../view/favorites_ads/favorites_ads.dart';
import '../view/home_screen/home_screen.dart';
import '../view/my_ads_list/my_ads_list.dart';
import '../view/on_boarding_screen/on_boarding_second_screen.dart';
import '../view/on_boarding_screen/on_boarding_third_screen.dart';
import '../view/online_property_apraisal/property_apraisal_screen_four.dart';
import '../view/online_property_apraisal/property_apraisal_screen_one.dart';
import '../view/online_property_apraisal/property_apraisal_screen_three.dart';
import '../view/online_property_apraisal/property_apraisal_screen_two.dart';
import '../view/post_an_ad/pos_an_ad_sixth_screen.dart';
import '../view/post_an_ad/post_an_ad_fifth_screen.dart';
import '../view/post_an_ad/post_an_ad_forth_screen.dart';
import '../view/post_an_ad/post_an_ad_seventh_screen.dart';
import '../view/search_list/searched_property_list.dart';
import '../view/widgets/internet_connection.dart';

class RouterHelper {
  static const initial = "/";
  static const onBoardingFirstScreen = "/onBoardingFirstScreen";
  static const onBoardingSecondScreen = "/onBoardingSecondScreen";
  static const onBoardingThirdScreen = "/onBoardingThirdScreen";
  // static const signInScreen = "/signInScreen";
  static const emailSignInScreen = "/emailsignInScreen";
  static const passwordScreen = "/passwordScreen";
  static const individualSignUpScreen = "/individualSignUp";
  static const companySignUpScreen = "/companySignUp";
  static const createPasswordScreen = "/createPasswordScreen";
  static const forgotPasswordScreen = "/forgotPasswordScreen";
  static const homeScreen = "/homeScreen";
  static const filterScreen = "/filterScreen";
  // static const searchLocation = "/searchLocation";
  static const mapSearchScreen = "/mapSearch";
  static const postAdMainDetailFirstScreen = "/postAdMainDetailFirstScreen";
  static const postAdMainDetailSecondScreen = "/postAdMainDetailSecondScreen";
  static const postAdDimensionScreen = "/postAdDimentionScreen";
  static const postAdUploadingDataScreen = "/postAdUploadingDataScreen";
  static const postAdContactsDetailScreen = "/postAdContactsDetailScreen";
  static const postAdOrderDetailScreen = "/postAdOrderDetailScreen";
  static const postAdFinishingDetailScreen = "/postAdFinishingDetailScreen";
  static const moreOptions = "/moreOptions";
  static const setProfile = "/setProfile";
  static const inquiryManagement = "/inquiryManagement";
  static const myAlerts = "/myAlerts";
  static const contactUs = "/contactUs";
  static const onlinePropertyAppraisalsScreen = "/onlinePropertyAppraisals";
  static const informationPropertyDetailsScreen = "/informationPropertyDetails";
  static const otherPropertyDetailsScreen = "/otherPropertyDetailsScreen";
  static const yourContactDetailsScreen = "/yourContactDetailsScreen";
  static const searchedListScreen = "/searchedListScreen";
  static const myAdsListScreen = "/myAdsListScreen";
  static const favoritesListScreen = "/favoritesListScreen";
  static const notificationScreen = "/notificationScreen";
  static const adDetailsScreen = "/adDetailsScreen";
  static const noConnectionScreen = "/noConnectionScreen";
  static const selectLocationScreen = "/selectLocationScreen";
  static const locationPermission = "/locationPermission";
  static const postAdLocationScreen = "/postAdLocation";
  static const detailAdOnMapScreen = "/detailAdOnMap";
  static const privacyPolicyScreen = "/privacyPolicyScreen";

  static Map<String, Widget Function(BuildContext context)> routes = {
    initial: (context) => const SplashScreen(),
    onBoardingFirstScreen: (context) => const OnBoardingFirstScreen(),
    onBoardingSecondScreen: (context) => const OnBoardingSecondScreen(),
    onBoardingThirdScreen: (context) => const OnBoardingThirdScreen(),
    emailSignInScreen: (context) => EmailSignInScreen(),
    passwordScreen: (context) => PasswordScreen(),
    // signInScreen: (context) => SignInScreen(),
    individualSignUpScreen: (context) => SignUpScreen(),
    companySignUpScreen: (context) => CompanySignUpScreen(),
    createPasswordScreen: (context) => CreatePasswordScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    homeScreen: (context) => const HomeScreen(),
    filterScreen: (context) => const FilterScreen(),
    // searchLocation: (context) => SearchLocationScreen(),
    mapSearchScreen: (context) => const MapSearchScreen(),
    postAdMainDetailFirstScreen: (context) =>
        const MainInformationFirstScreen(),
    postAdMainDetailSecondScreen: (context) =>
        const MainInformationSecondScreen(),
    postAdDimensionScreen: (context) => const DimentionsScreen(),
    postAdUploadingDataScreen: (context) => const UploadingData(),
    postAdContactsDetailScreen: (context) => const ContactDetail(),
    postAdOrderDetailScreen: (context) => const OrderDetails(),
    postAdFinishingDetailScreen: (context) => const FinishindDetails(),
    moreOptions: (context) => const MoreOptionsScreen(),
    setProfile: (context) => const SetProfileScreen(),
    inquiryManagement: (context) => const InquiryManagementScreen(),
    myAlerts: (context) => const MyAlertsScreen(),
    contactUs: (context) => const ContactUsScreen(),
    onlinePropertyAppraisalsScreen: (context) => const OnlineAppraisalStepOne(),
    informationPropertyDetailsScreen: (context) =>
        const InformationPropertyDetails(),
    otherPropertyDetailsScreen: (context) => const OtherPropertyDetails(),
    yourContactDetailsScreen: (context) => const YourContactDetails(),
    searchedListScreen: (context) => const SearchedList(),
    myAdsListScreen: (context) => const MyAdsList(),
    favoritesListScreen: (context) => const FavoritesList(),
    notificationScreen: (context) => const NotificationView(),
    adDetailsScreen: (context) => const AdDetailsScreen(),
    noConnectionScreen: (context) => const NoConnection(),
    selectLocationScreen: (context) => const SelectLocation(),
    locationPermission: (context) => const AccessLocationPermission(),
    postAdLocationScreen: (context) => const PostAdLocation(),
    detailAdOnMapScreen: (context) => const ShowDetailAdOnMap(),
    privacyPolicyScreen: (context) => const PrivacyPolicyScreen()
  };
}
