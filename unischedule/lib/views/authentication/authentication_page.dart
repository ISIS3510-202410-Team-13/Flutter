import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/providers/providers.dart';
import '../../../providers/friends/friends_state_notifier.dart';
import '../../../providers/groups/groups_state_notifier.dart';
import '../../../providers/events/events_state_notifier.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    initHive();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          if (!_dataLoaded) {
            _preloadData(ref);
          }

          return _buildPageContent();
        },
      ),
    );
  }

  Widget _buildPageContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Text(
              'UniSchedule',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Welcome David!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(5, 4),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 530.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: _authenticate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Login with Fingerprint'),
            ),
          ),
        ],
      ),
    );
  }

    
  void initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(FriendAdapter().typeId)) {
      Hive.registerAdapter(FriendAdapter());
    }
    if (!Hive.isAdapterRegistered(GroupModelAdapter().typeId)) {
      Hive.registerAdapter(GroupModelAdapter());
    }
    if (!Hive.isAdapterRegistered(EventAdapter().typeId)) {
      Hive.registerAdapter(EventAdapter());
    }
  }

  Future<void> _preloadData(WidgetRef ref) async {
    Future.delayed(Duration.zero, () async {
      const userId = "0MebgXs8fBYREjDKMlwq"; // Usar ID de usuario real aquí

      var friends = await ref.read(friendsProvider(userId).future);
      ref.read(friendsStateNotifierProvider.notifier).setFriends(friends);
      final boxFriends = await Hive.openBox<Friend>('friendBox');
      boxFriends.clear();
      for (Friend friend in friends) {
        await boxFriends.put(friend.id, friend);
      }

      var groups = await ref.read(fetchGroupsProvider.future);
      ref.read(groupsStateNotifierProvider.notifier).setGroups(groups);
      final boxGroups = await Hive.openBox<GroupModel>('groupBox');
      boxGroups.clear();
      for (GroupModel group in groups) {
        await boxGroups.put(group.id, group);
      }

      var events = await ref.read(eventsProvider(userId).future);
      ref.read(eventsStateNotifierProvider.notifier).setEvents(events);
      final boxEvents = await Hive.openBox<Event>('eventBox');
      boxEvents.clear();
      for (Event event in events) {
        await boxEvents.put(event.id, event);
      }
      _dataLoaded = true;
    });
  }


  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: "Is it you David?",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        context.go('/home'); // Navegación al HomePage usando GoRouter
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
