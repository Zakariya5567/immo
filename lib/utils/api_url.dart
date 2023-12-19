class ApiUrl {
//BASE URl
  static String baseUrl = "https://immo-experte24.ch/api";
  // "https://imo.ls.codesorbit.net/api";

  //AUTHENTICATION
  static String logInUrl = "$baseUrl/login";
  static String signUpUrl = "$baseUrl/register";
  static String logOutUrl = "$baseUrl/logout";
  static String forgetPasswordtUrl = "$baseUrl/forget-password";
  static String socialSignUpUrl = "$baseUrl/social-register";
  // User Profile
  static String currentUserUrl = "$baseUrl/current-user";
  static String updateProfileUrl = "$baseUrl/update-profile";
  static String emailAlreadyExistUrl = "$baseUrl/check-email-unique";

  // Contect Query
  static String contactUsUrl = "$baseUrl/contact-queries";
  static String contactUsReasonUrl = "$baseUrl/contact-query-reasons";
  static String contactUsDetailUrl = "$baseUrl/contact-us-detail";
// Inquiry Management
  static String sendInquiryUrl = "$baseUrl/property-inquiries";
  static String getInquiryUrl = "$baseUrl/property-inquiries";
  static String deleteInquiryUrl = "$baseUrl/property-inquiries";

  //Post An Ad
  static String getNoOfHousingUnityUrl = "$baseUrl/get-number-of-housing-units";
  static String getNoOfFloorsUrl = "$baseUrl/get-floors";
  static String getcountriesUrl = "$baseUrl/countries";
  static String savePropertyStepUrl = "$baseUrl/save-property-step";
  static String saveDetailsStepUrl = "$baseUrl/save-detail-step/";
  static String saveImageUrl = "$baseUrl/upload-property-image/";
  static String savePdfUrl = "$baseUrl/upload-property-pdf/";
  static String updatePdfUrl = "$baseUrl/update-property-pdf/";
  static String saveDocUrl = "$baseUrl/save-docs-step/";
  static String saveContactFormUrl = "$baseUrl/save-contact-step/";
  static String publishAdUrl = "$baseUrl/mark-as-published-property/";
  static String deleteFiledUrl = "$baseUrl/delete-media-file/";

  //Favorite
  static String getFavouriteUrl = "$baseUrl/favourite-properties";
  static String favouriteUnFavouriteUrl =
      "$baseUrl/favourite-unfavourite-property/";

  //Properties
  static String propertiesListUrl = "$baseUrl/properties";
  static String getPropertyCategoriesUrl = "$baseUrl/property-categories";
  static String deletePropertyUrl = "$baseUrl/properties/";
  static String duplicatePropertyUrl = "$baseUrl/duplicate-property/";
  static String getPropertyByIdUrl = "$baseUrl/properties/";
  static String getPropertyReportUrl = "$baseUrl/get-property-report-reasons";
  static String createPropertyReportUrl = "$baseUrl/property-reports";

  static String propertyShareUrl = "https://immo-experte24.ch/properties/";

  //Filter screen
  static String getNoOfRoomsUrl = "$baseUrl/get-number-of-rooms";
  static String getCharacteristicsUrl =
      "$baseUrl/get-characteristics-filters-list";
  static String getAgeOfAdUrl = "$baseUrl/get-published-since-filters-list";
  static String getAdsWithUrl = "$baseUrl/get-ads-with-filters-list";
  static String getFloorFilterListUrl = "$baseUrl/get-floors-filters-list";

  //Alert
  static String createAlertUrl = "$baseUrl/property-alerts";
  static String getAlertUrl = "$baseUrl/property-alerts";
  static String updateAlertUrl = "$baseUrl/property-alerts/";
  static String getAlertByIdUrl = "$baseUrl/property-alerts/";
  static String deleteAlertUrl = "$baseUrl/property-alerts/";

  //Map
  static String getCoordinatesUrl = "$baseUrl/get-properties-by-coordinates";

  //notification
  static String getAllNotificationUrl = "$baseUrl/notifications";
  static String markAllNotificationsAsReadUrl =
      "$baseUrl/mark-all-notifications-as-read";
  static String deleteAllNotificationUrl = "$baseUrl/mark-all-notifications";
  static String markSingleNotificationUrl =
      "$baseUrl/mark-all-notifications-as-read";
  //Privacy Policy
  static String privacyPoliciesUrl = "$baseUrl/privacy-policies";
  //Delete Account
  static String deleteAccountUrl = "$baseUrl/delete-account";
}
