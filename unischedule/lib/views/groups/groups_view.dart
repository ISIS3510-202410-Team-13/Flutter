import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/utils/filter.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'widgets/group_card.dart';

class GroupsView extends ConsumerStatefulWidget {
  const GroupsView({super.key});

  @override
  _GroupsViewState createState() => _GroupsViewState();
}

class _GroupsViewState extends ConsumerState<GroupsView> {

  final TextEditingController _searchController = TextEditingController();
  List<GroupModel> filteredGroups = [];

  @override
  void initState() {
    super.initState();
    filteredGroups = ref.read(fetchGroupsProvider).value ?? [];
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
    final allGroups = ref.read(fetchGroupsProvider).value ?? [];
    setState(() {
      filteredGroups = filterByQuery<GroupModel>(allGroups, searchText, (p0) => p0.name);
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
              itemCount: filteredGroups.length,
              itemBuilder: (context, index) {
                return GroupCard(group: filteredGroups[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

