class StringConstants {

  // Backend
  static const String connectionTimeout = 'Looks like you\'re offline. Please connect to the internet and try again.';
  static const String badRequest = 'Something went wrong on our end. Please try logging in again.';
  static const String unauthorizedRequest = 'Uh oh, it seems your credentials are incorrect. Please double-check your email and password.';
  static const String accessForbidden = 'You don\'t have permission to access this feature. Please contact support if you believe this is a mistake.';
  static const String anErrorOccurred = "We're having trouble connecting right now. Please check your internet connection and try again.";
  static const String invalidEmailFormat = 'The email address you entered is invalid. Please enter a valid email address.';
  static const String tooManyRequests = 'You\'ve tried logging in too many times in a short period. Please wait a few minutes and try again.';
  static const String emptyEmail  = 'Please enter your email address to log in.';
  static const String emptyPassword = 'Please enter your password to log in.';
  static const String emailTooLong = 'Your email address seems a bit long. Please try using a shorter one.';
  static const String passwordTooLong = 'For security reasons, passwords can\'t be this long. Please shorten your password.';

  static const String weakPassword = 'Your password is a bit weak. Choose a stronger password for better security.';
  static const String emailAlreadyInUse = 'This email address is already registered. Please try logging in or use a different email to sign up.';
  static const String nameIsNotSet = 'Oops! We seem to be missing some information. Please set your name in your profile.';  // Consider if applicable
  static const String wrongPassword = 'The password you entered is incorrect. Please double-check and try again.';
  static const String userNotFound = 'We couldn\'t find an account associated with this email address. Please check your email or try signing up.';


  // Network
  static const String connectivityError = 'Make sure you are connected to the internet to use UniSchedule';
  static const String connectivityRestored = 'You are now connected to the internet!';

  // NavBar
  static const String home = 'Home';
  static const String calendar = 'Calendar';
  static const String friends = 'Friends';
  static const String groups = 'Groups';

  // Search
  static const String search = 'Search...';

  // Authentication
  static const String appName = 'UniSchedule';
  static final Function(String) welcomeUser = (String name) => name.isEmpty ? 'Welcome!' : 'Welcome $name!';
  static final Function(String) localAuthMessage = (String name) => 'Is it you, $name?';
  static const String loginWithFingerprint = 'Login with Fingerprint';
  static const String login = 'Login';
  static const String loginTitle = 'Login to UniSchedule';
  static const String signup = 'Signup';
  static const String signupTitle = 'Signup to UniSchedule';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String name = 'Name';



  // Home
  static final Function(String) helloUser = (String name) => name.isEmpty ? 'Hey!' : 'Hey, $name!';
  static const String myGroups = 'My Groups';
  static const String myEvents = 'My Events';

  // Friends
  static const String friendsTitle = 'Friends';

  // Groups
  static const String groupsTitle = 'Groups';
}