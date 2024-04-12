import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../providers/friends_page/friends_provider.dart';
import 'package:unischedule/models/friends_page/friend_model.dart';
import '../../../providers/friends_page/friends_state_notifier.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: const FriendsApp())));
}

// Widget principal que maneja el estado de la aplicación
class FriendsApp extends ConsumerStatefulWidget {
  const FriendsApp({Key? key}) : super(key: key);

  @override
  _FriendsAppState createState() => _FriendsAppState();
}

class _FriendsAppState extends ConsumerState<FriendsApp> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  final friends = ref.watch(friendsStateNotifierProvider);
  return Scaffold(
    backgroundColor: const Color(0xFFF8F8F8),
    appBar: _buildAppBar(),
    body: Stack(
      children: [
        _buildFriendsList(friends),
        _buildFloatingActionButton(),
      ],
    ),
  );
}

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/bars.svg', width: 21, height: 24, color: Colors.black),
        onPressed: () {},
      ),
      title: const Text('Friends', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/bell.svg', width: 21, height: 24, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

Widget _buildFriendsList(List<Friend> friends) {
  return ListView.builder(
    itemCount: friends.length + 1,
    itemBuilder: (context, index) {
      if (index == 0) {
        return _buildSearchBar();
      }
      return _buildFriendItem(friends[index - 1]);
    },
  );
}
Padding _buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
    child: Container(
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) { // Añadir esta línea
          ref.read(friendsStateNotifierProvider.notifier).filterFriends(value);
        },
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF686868)),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF686868)),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset('assets/icons/magnifying-glass.svg', width: 24, height: 24, color: Color(0xFF686868)),
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

  Widget _buildFriendItem(Friend friend) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 8, 30, 6),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(30),
          right: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 26.5,
              backgroundImage: NetworkImage(friend.profilePicture),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              friend.name,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/comment.svg',
              width: 24,
              height: 24,
              color: Color(0xFF9FA5C0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      right: 16,
      bottom: 16,
      child: FloatingActionButton(
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF9DCC18),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(0),
          child: SvgPicture.asset(
            'assets/icons/square-plus.svg',
            width: 50,
            height: 56,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color(0xFF9DCC18), width: 3.8),
        ),
        elevation: 0,
      ),
    );
  }
}
