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
    final allGroups = ref.watch(fetchGroupsProvider).asData?.value ?? [];
    final bool allGroupsEmpty = allGroups.isEmpty;
    final filteredGroups = filterByQuery<GroupModel>(
        allGroups, _searchController.text, (p0) => p0.name);
    final connectivityStatus = ref.watch(connectivityStatusProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          SizedBox(height: Scaffold.of(context).appBarMaxHeight),
          UniScheduleSearchBar(searchController: _searchController),
          const SizedBox(height: 8),
          Expanded(
            child: connectivityStatus == ConnectivityStatus.isDisconnected && allGroupsEmpty
                ? Center(
              child: Text(
                "No groups to display at the moment. Please check your internet connection to view your groups.",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
                : allGroupsEmpty
                ? Center(
              child: Text(
                "You currently have no groups to display. Add one to see them here.",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
                : filteredGroups.isEmpty
                ? Center(
              child: Text(
                "No matching groups found.",
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
