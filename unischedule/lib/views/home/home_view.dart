import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'widgets/group_card.dart';
import 'widgets/event_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {

  @override
  Widget build(BuildContext context) {

    final groupsProvider = ref.watch(fetchGroupsProvider);
    final eventsProvider = ref.watch(fetchEventsProvider);
    final user = ref.watch(authenticationStatusProvider);

    return Stack(
      children: <Widget>[
        const BackgroundImage(opacity: StyleConstants.backgroundOpacity),
        Center(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
              child: Text(
                StringConstants.helloUser(user?.displayName ?? ''),
                maxLines: 3,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: ColorConstants.desertStorm,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(37)),
            ),
            height: 393,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringConstants.myGroups,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: groupsProvider.when(
                    data: (groups) {
                      final bool allGroupsEmpty = groups.isEmpty;
                      final connectivityStatus = ref.watch(connectivityStatusProvider);

                      return connectivityStatus == ConnectivityStatus.isDisconnected && allGroupsEmpty
                          ? Center(
                        child: Text(
                          "No groups to display at the moment. Please check your internet connection!",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : allGroupsEmpty
                          ? Center(
                        child: Text(
                          "You currently have no groups to display. ",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          final GroupModel group = groups[index];
                          return GroupCard(group: group);
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text(
                          error.toString(),
                          style: Theme.of(context).textTheme.bodySmall
                      ),
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringConstants.myEvents,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: eventsProvider.when(
                    data: (events) {
                      final bool allEventsEmpty = events.isEmpty;
                      final connectivityStatus = ref.watch(connectivityStatusProvider);

                      return connectivityStatus == ConnectivityStatus.isDisconnected && allEventsEmpty
                          ? Center(
                        child: Text(
                          "No events to display at the moment. Please check your internet connection!",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : allEventsEmpty
                          ? Center(
                        child: Text(
                          "You currently have no events to display.",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final EventModel event = events[index];
                          return EventCard(event: event);
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Text(
                          error.toString(),
                          style: Theme.of(context).textTheme.bodySmall
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 353,
          child: Image.asset(
            'assets/images/sticker.png', // TODO make this dynamic, create a provider
            height: 197,
          ),
        ),
      ],
    );
  }
}