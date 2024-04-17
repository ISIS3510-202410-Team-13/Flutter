import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:unischedule/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/utils/filter.dart';

class GroupsPage extends ConsumerStatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends ConsumerState<GroupsPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;  // TODO understand how this works

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

  void updateSearch(String searchText) {
    final allGroups = ref.read(fetchGroupsProvider).value ?? [];
    setState(() {
      filteredGroups = filterByQuery<GroupModel>(allGroups, searchText, (p0) => p0.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildGroupsList(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/bars.svg',
          width: 21,
          height: 24,
          color: Colors.black,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: const Text('Groups', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget _buildSearchBar() {
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
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF686868),
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF686868)),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(
                'assets/icons/magnifying-glass.svg',
                width: 24,
                height: 24,
                color: Color(0xFF686868),
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredGroups.length,
        itemBuilder: (context, index) => _buildGroupItem(filteredGroups[index]),
      ),
    );
  }

  Widget _buildGroupItem(GroupModel group) {
    final bgColor = Color(int.parse(group.color.replaceAll('#', '0xff')));
    final colorMasOscuro = bgColor
        .withRed(max(0, bgColor.red - 50))
        .withGreen(max(0, bgColor.green - 50))
        .withBlue(max(0, bgColor.blue - 50));

    return Container(
      width: double.infinity,
      height: 133,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                group.name.length > 15 ? '${group.name.substring(0, 15)}...' : group.name,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: MyCustomPainter(colorMasOscuro),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Column(
              children: const [
                CircleAvatar(radius: 3, backgroundColor: Colors.white),
                SizedBox(height: 3),
                CircleAvatar(radius: 3, backgroundColor: Colors.white),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 12,
            child: ProfileIconsRow(
                memberCount: group.members.length,
                imagePaths: group.profilePictures
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF9DCC18),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(0),
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
        side: BorderSide(
          color: Color(0xFF9DCC18),
          width: 3.8,
        ),
      ),
      elevation: 0,
    );
  }
}

class ProfileIconsRow extends StatelessWidget {
  final int memberCount;
  final List<String> imagePaths;

  const ProfileIconsRow({required this.memberCount, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Hacer que el contenedor ocupe todo el ancho disponible
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          for (var i = 0; i < 3; i++)
            Positioned(
              left: i==2? 0: (2-i) * 20.0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imagePaths[i],
                      fadeInDuration: const Duration(milliseconds: 0),
                      fadeOutDuration: const Duration(milliseconds: 0),
                      filterQuality: FilterQuality.none,
                      maxHeightDiskCache: 100,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 20,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.error, color: Colors.red), // Error icon in white
                      ),
                    )
                ),
              ),
            ),
          if (memberCount > 3)
            Container(
              padding: EdgeInsets.fromLTRB(6, 8, 16, 8),
              alignment: Alignment.centerRight,
              child: Text(
                '+${memberCount - 3}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Color color;

  MyCustomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.moveTo(size.width * 0.25, 0);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.25, size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.35, size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.8, size.width * 0.7, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.85, size.height, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
