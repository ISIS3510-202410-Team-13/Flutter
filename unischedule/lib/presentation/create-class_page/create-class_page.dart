import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({Key? key}) : super(key: key);

  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            _buildAppBar(),
          ]
      ),
      backgroundColor: Color(0xFFF8F8F8),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/arrow-left.svg',
            width: 21, height: 24, color: Colors.black),
        onPressed: () {
          context.go('/calendar'); // FIXME - Pop last route, will need to work on navigation stack
        },
      ),
      title: Text(
        'Create Class',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/plus.svg',
              width: 24, height: 24, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCreateClassForm() {
    return Column(
      children: <Widget>[
      ],
    );
  }

  Widget _buildPlaceRecommendationPopup() {
    return Column(
      children: <Widget>[
      ],
    );
  }
}
