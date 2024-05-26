import 'package:flutter/material.dart';
import 'package:unischedule/views/new_group/new_group_app_bar.dart';
import 'package:unischedule/views/new_group/new_group_form.dart';


class NewGroupView extends StatelessWidget {
  const NewGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NewGroupForm(),
      appBar: NewGroupAppBar(),
      backgroundColor: Color(0xFFF8F8F8),  // TODO use a Color constant
    );
  }
}
