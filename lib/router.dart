// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:after_app/Users/UI/Screens/forgot_password.dart';
// import 'Barbers/UI/Screens/login_barber.dart';
// import 'Barbers/UI/Screens/register_barber.dart';
// import 'Barbers/UI/Screens/start_barber.dart';
import 'Users/UI/Screens/home_page_user.dart';
import 'Users/UI/Screens/login_user.dart';
import 'Users/UI/Screens/register_user.dart';
import 'Users/UI/Screens/start_user.dart';
import 'Users/UI/Widgets/maps/search/search_place.dart';
// Routes
// const String HomePageRoute = "/";
const String WalkthroughRoute = "/";
const String StartUserRoute = "/";
const String StartBarberRoute = "StartBarber";
const String LoginUserRoute = "LoginUser";
const String LoginBarberRoute = "LoginBarber";
const String RegisterUserRoute = "RegisterUser";
const String RegisterBarberRoute = "RegisterBarber";
const String SearchinmapRoute = "SearchMap";
const String HomePageUserRoute = "HomePageUser";
const String ForgotPasswordRoute = "ForgotPassword";
// Router
// ignore: missing_return
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ForgotPasswordRoute:
      return PageTransition(child: ForgotPassword(), type: PageTransitionType.rightToLeft);
    case HomePageUserRoute:
      return PageTransition(child: HomePageUser(), type: PageTransitionType.rightToLeft);
    case StartUserRoute:
      return PageTransition(child: StartUser(), type: PageTransitionType.rightToLeft);
    // case StartBarberRoute :
    //   return PageTransition(child: StartBarber(), type: PageTransitionType.rightToLeft);
    case LoginUserRoute :
      return PageTransition(child: SignInScreen(), type: PageTransitionType.rightToLeft);
    case LoginBarberRoute :
    //   return PageTransition(child: LoginBarber(), type: PageTransitionType.rightToLeft);
    case RegisterUserRoute :
      return PageTransition(child: RegisterUser(), type: PageTransitionType.rightToLeft);
    // case RegisterBarberRoute :
    //   return PageTransition(child: RegisterBarber(), type: PageTransitionType.rightToLeft);
    case SearchinmapRoute :
      return PageTransition(child: const SearchMap(editFav: false,), type: PageTransitionType.rightToLeft);

  }
}
