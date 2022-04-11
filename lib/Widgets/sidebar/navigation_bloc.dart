
import 'package:after_app/Users/UI/Screens/faq_users.dart';
import 'package:after_app/Users/UI/Screens/user_profile.dart';
import 'package:after_app/Users/UI/Screens/user_resume.dart';
import 'package:after_app/Users/UI/Screens/user_services.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  homeScreenClickedEvent,
  userResumeClickedEvent,
  faqUsersClickedEvent,
  userProfileClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super( UserServices()){
    on<NavigationEvents>((event, emit) {
      switch (event) {
        case NavigationEvents.homeScreenClickedEvent:
          emit(UserServices());
          break;
        case NavigationEvents.userResumeClickedEvent:
          emit(UserResume());
          break;
        case NavigationEvents.userProfileClickedEvent:
          emit(UserProfile());
          break;
        case NavigationEvents.faqUsersClickedEvent:
          emit(FAQUsers());
          break;
      }
    });
  }
}
