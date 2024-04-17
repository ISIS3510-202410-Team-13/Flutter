import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/providers/groups/groups_provider.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/views/home/widgets/event_card.dart';
import 'package:unischedule/views/home/widgets/group_card.dart';
import 'package:unischedule/widgets/background_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final groups = ref.watch(fetchGroupsProvider);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const BackgroundImage(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset('assets/icons/bars.svg', width: 21, height: 24, color: Colors.white),
                onPressed: () {
                  // TODO implement logic for opening the drawer
                  Scaffold.of(context).openDrawer(); // Abre el drawer
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: SvgPicture.asset('assets/icons/bell.svg', width: 21, height: 24, color: Colors.white),
                  onPressed: () {
                    // TODO implement logic for notifications
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(37)),
              ),
              height: 393,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '   My Groups',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: groups.when(
                      data: (groups) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          final GroupModel group = groups[index];
                          return GroupCard(group: group);
                        },
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(child: Text('Error: $error')),
                    ),

                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '   My Events',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      10, // Define la cantidad de eventos estáticos que quieres mostrar
                      itemBuilder: (context, index) {
                        return const FriendCard();
                      },
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
              "assets/images/sticker.png", // TODO make this dynamic
              height: 197,
            ),
          ),
        ],
      ),
    );
  }
}