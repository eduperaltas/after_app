
import 'package:after_app/Users/UI/Screens/faq_users.dart';
import 'package:after_app/Users/UI/Screens/user_profile.dart';
import 'package:after_app/Users/UI/Screens/user_resume.dart';
import 'package:after_app/Users/UI/Screens/user_services.dart';
import 'package:bloc/bloc.dart';



enum NavigationEvents {
  HomeScreenClickedEvent,
  UserResumeClickedEvent,
  faq_usersClickedEvent,
  user_profileClickedEvent,

}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super( UserServices());

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomeScreenClickedEvent:
        yield UserServices();
        break;
      case NavigationEvents.UserResumeClickedEvent:
        yield UserResume();
        break;
      case NavigationEvents.user_profileClickedEvent:
        yield UserProfile();
        break;
      case NavigationEvents.faq_usersClickedEvent:
        yield FAQUsers();
        break;
    }
  }}