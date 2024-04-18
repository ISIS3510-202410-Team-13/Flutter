import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/utils/filter.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'widgets/friend_card.dart';

class FriendsView extends ConsumerStatefulWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends ConsumerState<FriendsView> {
  final TextEditingController _searchController = TextEditingController();
  List<FriendModel> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    filteredFriends = ref.read(fetchFriendsProvider).value ?? [];
    _searchController.addListener(() {
      updateSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void updateSearch(String searchText) {
    final allFriends = ref.read(fetchFriendsProvider).value ?? [];
    setState(() {
      filteredFriends = filterByQuery<FriendModel>(allFriends, searchText, (p0) => p0.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          SizedBox(height: Scaffold.of(context).appBarMaxHeight),
          UniScheduleSearchBar(searchController: _searchController),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: filteredFriends.length,
              itemBuilder: (context, index) {
                return FriendCard(friend: filteredFriends[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
