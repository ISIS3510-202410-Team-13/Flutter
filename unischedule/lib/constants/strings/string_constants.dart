class StringConstants {

  // Backend
  static const String connectionTimeout = 'Error connection timeout';
  static const String badRequest = 'Bad request';
  static const String unauthorizedRequest = 'Unauthorized request';
  static const String accessForbidden = 'Access forbidden';
  static const String anErrorOccurred = "An error occurred. Sorry for the inconvenience. We're fixing this issue";

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
  static final Function(String) localAuthMessage = (String name) => 'Is it you? $name';
  static const String loginWithFingerprint = 'Login with Fingerprint';
  static const String login = 'Login';
  static const String loginTitle = 'Login to UniSchedule';
  static const String signup = 'Signup';
  static const String signupTitle = 'Signup to UniSchedule';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String name = 'Name';


  // Home
  static final Function(String) helloUser = (String name) => 'Hey, $name!';
  static const String myGroups = 'My Groups';
  static const String myEvents = 'My Events';

  // Friends
  static const String friendsTitle = 'Friends';

  // Groups
  static const String groupsTitle = 'Groups';
}