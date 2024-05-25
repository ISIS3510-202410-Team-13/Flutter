import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:unischedule/models/friends/friend_model.dart';
import 'package:unischedule/models/groups/group_model.dart';
import 'package:unischedule/providers/authentication/authentication_provider.dart';
import 'package:unischedule/providers/connectivity/connectivity_provider.dart';
import 'package:unischedule/providers/friends/friends_provider.dart';
import 'package:unischedule/providers/groups/groups_provider.dart';
import 'package:unischedule/views/friends/widgets/friend_card.dart';
import 'package:unischedule/views/new_event/widgets/color_picker_button.dart';
import 'package:uuid/uuid.dart';

class NewGroupForm extends ConsumerStatefulWidget {
  const NewGroupForm({super.key});

  @override
  ConsumerState<NewGroupForm> createState() => _NewGroupFormState();
}

class _NewGroupFormState extends ConsumerState<NewGroupForm> {
  String _groupName = ''; // Almacenar el nombre del grupo
  List<String> _groupMembers = []; // Lista para guardar los miembros del grupo
  String _groupColor = '#9DCC18'; // Color por defecto en formato HEX
  final Uuid _uuid = Uuid();
  List<FriendModel> allFriends = []; // Almacenar todos los amigos

  @override
  void initState() {
    super.initState();
    // Cargar amigos inicialmente
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allFriends = ref.read(fetchFriendsProvider).asData?.value ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Sección de Group Name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Group Name',
                      style: TextStyle(fontSize: 18, fontFamily: 'Poppins')),
                  TextField(
                    maxLength: 50,
                    onChanged: (value) => setState(() => _groupName = value),
                    style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'Enter Group Name',
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9DCC18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Sección de Members
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 430), // Define un límite de altura
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: const Text('Members',
                          style: TextStyle(fontFamily: 'Poppins')),
                      trailing: IconButton(
                        icon: const Icon(Icons.add,
                            color: ColorConstants.limerick),
                        onPressed: () => _showFriendsDialog(allFriends),
                      ),
                    ),
                    ..._groupMembers.map((memberName) {
                      FriendModel? friend;
                      try {
                        friend =
                            allFriends.firstWhere((f) => f.name == memberName);
                      } catch (e) {
                        friend = null;
                      }
                      return friend != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: FriendCard(
                                friend: friend,
                                actionIcon: Icon(Icons.delete,
                                    color: ColorConstants.gullGrey),
                                onActionTap: () => _removeMember(friend!.name),
                              ),
                            )
                          : Container();
                    }).toList(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Sección de Group Color
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: const Text('Group Color',
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins')),
                  ),
                  ColorPickerButton(
                    onColorSelected: (colorHex) {
                      setState(() {
                        _groupColor = colorHex;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: connectivityStatus == ConnectivityStatus.isConnected
                  ? _createGroup
                  : null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: connectivityStatus == ConnectivityStatus.isConnected
                      ? const Color(0xFF9DCC18)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color:  connectivityStatus == ConnectivityStatus.isConnected
                      ? const Color(0xFF9DCC18)
                      : Colors.grey, width: 1),
                ),
                width: double.infinity,
                child: Text(connectivityStatus == ConnectivityStatus.isConnected
                      ? 'Create Group'
                      : 'No Internet Connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFriendsDialog(List<FriendModel> allFriends) {
    // Filtrar amigos disponibles que no están ya en el grupo
    List<FriendModel> availableFriends = allFriends
        .where((friend) => !_groupMembers.contains(friend.name))
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Text('Select Friends',
              style: TextStyle(fontFamily: 'Poppins')),
          content: availableFriends.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "No more friends to add to the group",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.gullGrey),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: availableFriends.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (!_groupMembers
                              .contains(availableFriends[index].name)) {
                            setState(() {
                              _groupMembers.add(availableFriends[index].name);
                            });
                            Navigator.pop(
                                context); // Cierra el diálogo después de seleccionar
                          }
                        },
                        child: FriendCard(friend: availableFriends[index]),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }

  void _removeMember(String memberName) {
    setState(() {
      _groupMembers.remove(memberName);
    });
  }

  void _createGroup() async {
    final user = ref.watch(authenticationStatusProvider);
    final memberIds = _groupMembers
        .map(
            (name) => allFriends.firstWhere((friend) => friend.name == name).id)
        .toList();
    final newGroup = GroupModel(
      id: _uuid.v4(),
      name: _groupName,
      members: [user?.uid, ...memberIds].cast<String>(),
      groupPicture: 'https://picsum.photos/1080',
      color: _groupColor,
      icon: '📚',
      events: [],
      profilePictures: [],
      memberCount: memberIds.length + 1,
    );
    try {
      ref.read(addGroupProvider(group: newGroup).future);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Group created successfully!'),
          backgroundColor: ColorConstants.limerick));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to create group.'),
          backgroundColor: ColorConstants.red));
      print('Error creating group: $e');
    }
  }
}
