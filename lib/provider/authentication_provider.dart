// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:immo/data/api_models/authentication/sign_up_model.dart';
import 'package:immo/provider/language_provider.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../data/api_models/authentication/email_already_exist.dart';
import '../data/api_models/authentication/forget_password_model.dart';
import '../data/api_models/authentication/log_in_model.dart';
import '../data/api_models/authentication/logout_model.dart';
import '../data/api_models/authentication/social_signup_model.dart';
import '../data/api_repo.dart';
import '../data/connection_model.dart';
import '../helper/routes_helper.dart';
import '../utils/api_url.dart';
import '../utils/app_constant.dart';
import '../view/widgets/circular_progress.dart';
import '../view/widgets/custom_snackbar.dart';

class AuthProvider extends ChangeNotifier {
  bool isSignInEmailValid = false;
  bool isSignUpEmailValid = false;
  bool isCompanySignUpEmailValid = false;
  bool isForgetEmailValid = false;
  bool isSignUpPasswordValid = false;
  bool isCompanySignUpPasswordValid = false;
  bool isSignInPasswordValid = false;
  bool isCreateScreenPasswordValid = false;
  bool isCompanySignUp = false;
  bool isSecure = true;
  bool? isLoading;

  TextEditingController forgotEmailController = TextEditingController();
  TextEditingController createScreenPasswordController =
      TextEditingController();

  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();

  // Authentication Models
  SignUpModel signupModel = SignUpModel();
  SocialSignUpModel socialSignUpModel = SocialSignUpModel();
  LoginModel loginModel = LoginModel();
  ForgetPasswordModel forgotPasswordModel = ForgetPasswordModel();
  LogOutModel logOutModel = LogOutModel();
  EmailAlreadyExistModel emailAlreadyExistModel = EmailAlreadyExistModel();
  ApiRepo apiRepo = ApiRepo();

  setIsSecure() {
    isSecure = !isSecure;
    debugPrint("isSecure : $isSecure");
    notifyListeners();
  }

  setSignUpEmail() {
    isCompanySignUp = false;
    signUpEmailController.text = signInEmailController.text;
    notifyListeners();
  }

  setCompanySignUpEmail() {
    isCompanySignUp = true;
    companyEmailController.text = signInEmailController.text;
    notifyListeners();
  }

  getEmailValid() {
    isSignInEmailValid;
    isSignUpEmailValid;
    isForgetEmailValid;
    isCompanySignUpEmailValid;
    notifyListeners();
  }

  getPasswordValid() {
    isSignUpPasswordValid;
    isSignInPasswordValid;
    isCreateScreenPasswordValid;
    isCompanySignUpPasswordValid;
    notifyListeners();
  }

  //clear text field
  clearPasswordTextField() {
    signInPasswordController.clear();
    notifyListeners();
  }
  clearUserNamesTextField() {
    signUpNameController.clear();
    companyNameController.clear();
    notifyListeners();
  }
  clearSignUpScreen() {
    signUpNameController.clear();
    signUpEmailController.clear();
    companyNameController.clear();
    companyEmailController.clear();
    isCompanySignUp = false;
    isSignInEmailValid = false;
    isSignUpEmailValid = false;
    isForgetEmailValid = false;
    isCompanySignUpEmailValid = false;
    notifyListeners();
  }

  resetIsCompanySignUp() {
    isCompanySignUp = false;
    notifyListeners();
  }

  clearTextField() {
    forgotEmailController.clear();
    createScreenPasswordController.clear();

    companyEmailController.clear();
    companyNameController.clear();

    signInEmailController.clear();
    signInPasswordController.clear();

    signUpNameController.clear();
    signUpEmailController.clear();
    signUpPasswordController.clear();

    isCompanySignUp = false;
    isSignInEmailValid = false;
    isSignUpEmailValid = false;
    isCompanySignUpEmailValid = false;
    isForgetEmailValid = false;
    isSignUpPasswordValid = false;
    isCompanySignUpPasswordValid = false;
    isSignInPasswordValid = false;
    isCreateScreenPasswordValid = false;

    isSecure = true;

    notifyListeners();
  }

  // Validation
  nameValidation(value) {
    if (value.isEmpty) {
      return hintYourName;
    }
  }

  companyNameValidation(value) {
    if (value.isEmpty) {
      return hintCompanyName;
    }
  }

  emailValidation(value, controller) {
    if (value.isEmpty) {
      return hintEmail;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      if (controller == signInEmailController) {
        isSignInEmailValid = false;
      }
      if (controller == signUpEmailController) {
        isSignUpEmailValid = false;
      }
      if (controller == companyEmailController) {
        isCompanySignUpEmailValid = false;
      }
      if (controller == forgotEmailController) {
        isForgetEmailValid = false;
      }
      return validEmail;
    }
    if (controller == signInEmailController) {
      isSignInEmailValid = true;
    }
    if (controller == signUpEmailController) {
      isSignUpEmailValid = true;
    }
    if (controller == companyEmailController) {
      isCompanySignUpEmailValid = true;
    }
    if (controller == forgotEmailController) {
      isForgetEmailValid = true;
    }
    return null;
  }

  phoneValidation(value) {
    String pattern = r'^\d{2}\s\d{3}\s\d{2}\s\d{2}$';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return enterTelephone;
    } else if (!regExp.hasMatch(value)) {
      return validTelephone;
    }
  }

  passwordValidation(value, controller) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*])[A-Za-z\d!@#\$%^&*]{12,64}$';
    RegExp regExp = RegExp(pattern);
    value = value.toString().trim();
    if (value.isEmpty) {
      return enterPassword;
    } else if (!regExp.hasMatch(value)) {
      if (controller == signInPasswordController) {
        isSignInPasswordValid = false;
      } else if (controller == signUpPasswordController) {
        isSignUpPasswordValid = false;
      } else if (controller == companyEmailController) {
        isCompanySignUpPasswordValid = false;
      } else if (controller == createScreenPasswordController) {
        isCreateScreenPasswordValid = false;
      }
      return validPassword;
    }
    if (controller == signInPasswordController) {
      isSignInPasswordValid = true;
    } else if (controller == signUpPasswordController) {
      isSignUpPasswordValid = true;
    } else if (controller == companyEmailController) {
      isCompanySignUpPasswordValid = true;
    } else if (controller == createScreenPasswordController) {
      isCreateScreenPasswordValid = true;
    }
  }

  // Set is Secured to default
  setIsSecureDefault() {
    isSecure = true;
    notifyListeners();
  }

  //Loading
  setLoading(BuildContext context, bool value) {
    isLoading = value;
    if (value == true) {
      loaderDialog(context);
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

//===============================================================================
  // APIs calling section

  // Signup
  signUp(BuildContext context, String screen) async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      debugPrint("fcm_token: $token");
      String? fcmToken = token;
      if (fcmToken != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(AppConstant.fcmToken, fcmToken);

        setLoading(context, true);

        debugPrint("isLoading: $isLoading");
        String? token = sharedPreferences.getString(AppConstant.fcmToken);
        debugPrint(" signup ==========================>>>");
        debugPrint(" fcm_token ==========================>>> $token");

        try {
          Response response = await apiRepo.postData(
              context,
              screen,
              ApiUrl.signUpUrl,
              isCompanySignUp == true
                  ? {
                      "company_name": companyNameController.text,
                      "email": companyEmailController.text,
                      "password": signUpPasswordController.text.isNotEmpty
                          ? signUpPasswordController.text
                          : createScreenPasswordController.text,
                      "is_company": "1",
                    }
                  : {
                      "username": signUpNameController.text,
                      "email": signUpEmailController.text,
                      "password": signUpPasswordController.text.isNotEmpty
                          ? signUpPasswordController.text
                          : createScreenPasswordController.text,
                      "is_company": "0",
                    });
          final responseBody = response.data;
          debugPrint("response body ===============>>> $responseBody");
          signupModel = SignUpModel.fromJson(responseBody);
          if (signupModel.error == false) {
            sharedPreferences.setString(
                AppConstant.userId, signupModel.data!.id.toString());
            sharedPreferences.setString(
                AppConstant.userEmail, signupModel.data!.email.toString());
            sharedPreferences.setString(
                AppConstant.userName, signupModel.data!.username ?? '');
            sharedPreferences.setBool(AppConstant.isLogin, true);
            sharedPreferences.setInt(
                AppConstant.isCompany, signupModel.data!.isCompany!);

            ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(context, signupModel.message.toString(), 0));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(context, signupModel.message.toString(), 1));
          }

          setLoading(context, false);

          debugPrint("isLoading: $isLoading");
        } catch (e) {
          setLoading(context, false);
          debugPrint("isLoading: $isLoading");
        }

        notifyListeners();
      }
    });
  }

  // LOGIN
  login(BuildContext context, String screen) async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      debugPrint("fcm_token: $token");
      String? fcmToken = token;
      if (fcmToken != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(AppConstant.fcmToken, fcmToken);

        setLoading(context, true);

        debugPrint("isLoading: $isLoading");
        String? token = sharedPreferences.getString(AppConstant.fcmToken);
        debugPrint(" login ==========================>>>");
        debugPrint(" fcm_token ==========================>>> $token");

        try {
          Response response =
              await apiRepo.postData(context, screen, ApiUrl.logInUrl, {
            "email": signInEmailController.text,
            "password": signInPasswordController.text,
            "device": Platform.isAndroid ? "android" : "ios",
            "fcm_token": token
          });
          final responseBody = response.data;
          debugPrint("response body ===============>>> $responseBody");
          loginModel = LoginModel.fromJson(responseBody);

          if (loginModel.error == false) {
            sharedPreferences.setString(
                AppConstant.userId, loginModel.data!.user!.id.toString());
            sharedPreferences.setString(
                AppConstant.userEmail, loginModel.data!.user!.email.toString());

            sharedPreferences.setString(
                AppConstant.bearerToken, loginModel.data!.token.toString());
            sharedPreferences.setBool(AppConstant.isLogin, true);
            sharedPreferences.setInt(AppConstant.isCompany,
                loginModel.data!.user!.isCompany == 0 ? 0 : 1);
            if (loginModel.data!.user!.isCompany == 1) {
              sharedPreferences.setString(AppConstant.userName,
                  loginModel.data!.user!.companyName ?? '');
            } else {
              sharedPreferences.setString(
                  AppConstant.userName, loginModel.data!.user!.username ?? '');
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(context, loginModel.message.toString(), 1));
          }

          setLoading(context, false);

          debugPrint("isLoading: $isLoading");
        } catch (e) {
          setLoading(context, false);

          debugPrint("isLoading: $isLoading");
        }

        notifyListeners();
      }
    });
  }

  // IS EMAIL ALREADY EXIST
  Future<void> isEmailAlreadyExist(BuildContext context, String screen) async {
    setLoading(context, true);

    debugPrint("isLoading: $isLoading");
    debugPrint(" Checking for existing email ==========================>>>");

    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.emailAlreadyExistUrl, {
        "email": signInEmailController.text,
        "locale":
            Provider.of<LanguageProvider>(context, listen: false).languageCode,
      });
      final responseBody = response.data;
      debugPrint(
          "existing email response body ===============>>> $responseBody");
      emailAlreadyExistModel = EmailAlreadyExistModel.fromJson(responseBody);
      // if (emailAlreadyExistModel.error != false) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       customSnackBar(context, emailAlreadyExistModel.message!, 1));
      // }

      setLoading(context, false);

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(context, false);

      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  // LOGOUT
  logOut(BuildContext context, String screen) async {
    setLoading(context, true);

    debugPrint("isLoading: $isLoading");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstant.fcmToken);
    debugPrint(" logout ==========================>>>");
    debugPrint(" fcm_token ==========================>>> $token");

    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.logOutUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      logOutModel = LogOutModel.fromJson(responseBody);

      if (logOutModel.error == false) {
        sharedPreferences.setBool(AppConstant.isLogin, false);
        sharedPreferences.setString(AppConstant.bearerToken, "");
        sharedPreferences.setString(AppConstant.userEmail, "");
        sharedPreferences.setString(AppConstant.userId, "");
        sharedPreferences.setString(AppConstant.userName, "");
        sharedPreferences.setInt(AppConstant.isCompany, 0);

        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar(context, logOutSuccessful, 0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, logOutModel.message.toString(), 1));
      }

      setLoading(context, false);

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(context, false);

      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //FORGOT PASSWORD
  forgotPassword(BuildContext context, String screen) async {
    setLoading(context, true);

    debugPrint("isLoading: $isLoading");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        AppConstant.userEmail, forgotEmailController.text);
    String? userEmail = sharedPreferences.getString(AppConstant.userEmail);
    debugPrint(" forgotPassword ==========================>>>");

    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.forgetPasswordtUrl, {
        "email": userEmail,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      forgotPasswordModel = ForgetPasswordModel.fromJson(responseBody);

      if (forgotPasswordModel.error == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, forgotPasswordModel.message.toString(), 0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, forgotPasswordModel.message.toString(), 1));
      }

      setLoading(context, false);

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(context, false);

      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //SOCIAL SIGNUP
  socialSignup(BuildContext context, String name, String screen) async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      debugPrint("fcm_token: $token");
      String? fcmToken = token;
      if (fcmToken != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(AppConstant.fcmToken, fcmToken);
        debugPrint("isLoading: $isLoading");
        String? token = sharedPreferences.getString(AppConstant.fcmToken);
        debugPrint("social signup ==========================>>>");
        debugPrint(" fcm_token ==========================>>> $token");

        Map<String, dynamic>? data = await getSocialData(name, context, screen);
        try {
          setLoading(context, true);

          Response response = await apiRepo.postData(
              context, screen, ApiUrl.socialSignUpUrl, data);
          final responseBody = response.data;
          debugPrint("response body ===============>>> $responseBody");
          socialSignUpModel = SocialSignUpModel.fromJson(responseBody);

          if (socialSignUpModel.error == false) {
            sharedPreferences.setString(AppConstant.userId,
                socialSignUpModel.data!.user!.id.toString());
            sharedPreferences.setString(AppConstant.userEmail,
                socialSignUpModel.data!.user!.email.toString());
            sharedPreferences.setString(AppConstant.userName,
                socialSignUpModel.data!.user!.username ?? '');
            sharedPreferences.setString(AppConstant.bearerToken,
                socialSignUpModel.data!.token.toString());
            sharedPreferences.setBool(AppConstant.isLogin, true);

            setLoading(context, false);

            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                context, socialSignUpModel.message.toString(), 0));
          } else {
            setLoading(context, false);

            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                context, socialSignUpModel.message.toString(), 1));
          }
        } catch (e) {
          setLoading(context, false);
          debugPrint("Error : $e");
        }
        // }

        notifyListeners();
      }
    });
  }

  //===============================================================================
// social signIn

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getSocialData(
      String name, BuildContext context, String screen) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstant.fcmToken);
    debugPrint("Login with $name");

    Map<String, dynamic>? data;

    if (name == "google") {
      GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        googleSignIn.signOut();
      }
      GoogleSignInAccount? googleUser;
      try {
        googleUser = await googleSignIn.signIn();
        debugPrint('$googleUser');
      } on PlatformException catch (exception) {
        debugPrint('$exception');
        if (exception.code == GoogleSignIn.kNetworkError) {
          Future.delayed(
            Duration.zero,
            () {
              Navigator.pushNamed(
                context,
                RouterHelper.noConnectionScreen,
                arguments: ConnectionModel(
                  screen,
                  connectionError,
                ),
              );
            },
          );
        } else {
          Future.delayed(
            Duration.zero,
            () {
              Navigator.pushNamed(
                context,
                RouterHelper.noConnectionScreen,
                arguments: ConnectionModel(
                  screen,
                  somethingWentWrong,
                ),
              );
            },
          );
        }
      }
      data = {
        "username": "${googleUser!.displayName}",
        "email": googleUser.email,
        "provider_id": googleUser.id,
        "provider": "google",
        "device": Platform.isAndroid ? "android" : "ios",
        "fcm_token": token,
      };
    } else if (name == "facebook") {
      await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then((value) async {
        await FacebookAuth.instance.getUserData().then((newData) {
          data = {
            "username": "${newData["name"]}",
            "email": "${newData["email"]}",
            "provider_id": "${newData["id"]}",
            "provider": "facebook",
            "device": Platform.isAndroid ? "android" : "ios",
            "fcm_token": token,
          };
        });
      });
    } else if (name == "apple") {
      var redirectURL =
          "https://immo-experte-24.glitch.me/callbacks/sign_in_with_apple";
      var clientID = "com.immoexperte24.immoexperte24";
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID, redirectUri: Uri.parse(redirectURL)),
      );
      final oAuthProvider = OAuthProvider('apple.com');
      // ignore: unused_local_variable
      final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      debugPrint("email:  ${appleIdCredential.email}");
      debugPrint("given name:  ${appleIdCredential.givenName}");
      debugPrint("family name:  ${appleIdCredential.familyName}");
      debugPrint("authorization code:  ${appleIdCredential.authorizationCode}");
      debugPrint("user identifier:  ${appleIdCredential.userIdentifier}");
      debugPrint("identity token:  ${appleIdCredential.identityToken}");

      Map<String, dynamic> decodedToken =
          Jwt.parseJwt(appleIdCredential.identityToken!);

      data = {
        "username": appleIdCredential.givenName,
        "email": appleIdCredential.email ?? decodedToken['email'],
        // "provider_id": appleIdCredential.identityToken,
        "provider_id": appleIdCredential.userIdentifier ?? decodedToken['sub'],
        "provider": "apple",
        "device": Platform.isAndroid ? "android" : "ios",
        "fcm_token": token,
      };
    }

    return data!;
  }

  // ===========================================================================
// LOADING DIALOG
  loaderDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(100),
          contentPadding: const EdgeInsets.all(25),
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            height: setWidgetHeight(80),
            width: setWidgetWidth(80),
            child: const CircularProgress(),
          ),
        );
      },
    );
  }
}
