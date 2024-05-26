import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:unischedule/constants/strings/asset_constants.dart';
import 'package:unischedule/constants/strings/route_constants.dart';
import 'package:unischedule/constants/styles/style_constants.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/utils/filter.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'widgets/friend_card.dart';

class FriendsView extends ConsumerStatefulWidget {
  const FriendsView({super.key});

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends ConsumerState<FriendsView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      // Forzar reconstrucción para aplicar filtro.
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allFriends = ref.watch(fetchFriendsProvider).asData?.value ?? [];
    final bool allFriendsEmpty = allFriends.isEmpty;
    final filteredFriends = filterByQuery<FriendModel>(
        allFriends, _searchController.text, (p0) => p0.name);
    final connectivityStatus = ref.watch(connectivityStatusProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          SizedBox(height: Scaffold.of(context).appBarMaxHeight),
          UniScheduleSearchBar(searchController: _searchController),
          const SizedBox(height: 8),
          Expanded(
            child: connectivityStatus == ConnectivityStatus.isDisconnected &&
                    allFriendsEmpty
                ? Center(
                    child: Text(
                      "No friends to display at the moment. Please check your internet connection to view your friends.",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  )
                : allFriendsEmpty
                    ? Center(
                        child: Text(
                          "You currently have no friends to display. Add one to see them here.",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : filteredFriends.isEmpty
                        ? Center(
                            child: Text(
                              "No matching friends found.",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                  color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            itemCount: filteredFriends.length,
                            itemBuilder: (context, index) {
                              return FriendCard(
                                  friend: filteredFriends[index],
                                  actionIcon: SvgPicture.asset(
                                    AssetConstants.icComment,
                                    width: StyleConstants.iconWidth,
                                    height: StyleConstants.iconHeight,
                                    color: ColorConstants.gullGrey,
                                  ),
                                  onActionTap: () {
                                    context.push(
                                      RouteConstants.chat,
                                      extra: filteredFriends[index].id
                                    );
                                  });
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
