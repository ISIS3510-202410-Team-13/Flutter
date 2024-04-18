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

  // Home
  static final Function(String) helloUser = (String name) => 'Hey, $name!';
  static const String myGroups = 'My Groups';
  static const String myEvents = 'My Events';

  // Friends
  static const String friendsTitle = 'Friends';

  // Groups
  static const String groupsTitle = 'Groups';
}