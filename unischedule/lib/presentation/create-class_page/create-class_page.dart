import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({Key? key}) : super(key: key);

  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildAppBar(),
          Expanded(
            child: _buildCreateClassForm(),
          ),
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
      title: const Text(
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

    const assistants = <String>[
      'Laura',
      'Gotty',
      'Sebastian',
      'Juan',
      'Lucciano'
    ];
    final MultiSelectController assistantsMultiSelectController = MultiSelectController();

    const reminders = <String>[
      'No reminder',
      'At time of event',
      '5 minutes before',
      '15 minutes before',
      '30 minutes before',
      '1 hour before',
    ];
    String? selectedReminder;

    const labels = <String>[
      'Uniandes 📚',
      'Work 👩‍💻',
      'Personal ✨',
      'Family 👨‍👩‍👧‍👦',
      'Friends 👯‍',
    ];
    final MultiSelectController labelsMultiSelectController = MultiSelectController();

    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFFD0D5DD), width: 1),
                ),
                child: const Text(
                  'One-Time',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF9DCC18),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFF9DCC18), width: 1),
                ),
                child: const Text(
                  'Recurrent',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFD0D5DD), width: 1),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 56,
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Event Name',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFF475569),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: SvgPicture.asset('assets/icons/signature.svg',
                            width: 24, height: 24, color: const Color(0xFF475569)),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFD0D5DD),
                      width: 1,
                    ),
                  ),
                  height: 1,
                ),
                Container(
                  height: 56,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MultiSelectDropDown(
                          controller: assistantsMultiSelectController,
                          onOptionSelected: (List<ValueItem> selectedOptions) {},
                          options: assistants.map((key) => ValueItem(label: key, value: key)).toList(),
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                          optionTextStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.bold,
                          ),
                          borderColor: Colors.transparent,
                          focusedBorderColor: Colors.transparent,
                          borderWidth: 0,
                          focusedBorderWidth: 0,
                          clearIcon: const Icon(Icons.clear),
                          padding: const EdgeInsets.all(0),
                          hint: 'Assistants',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.bold,
                          ),
                          hintPadding: const EdgeInsets.all(0),
                        ),
                      ),
                      SizedBox(
                          width: 30,
                          child: SvgPicture.asset('assets/icons/person-chalkboard.svg',
                              width: 24, height: 24, color: const Color(0xFF475569)),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFD0D5DD),
                      width: 1,
                    ),
                  ),
                  height: 1,
                ),
                Container(
                  height: 56,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Reminder',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFF475569),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          items: reminders.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Color(0xFF475569),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedReminder = newValue;
                            });
                          },
                          value: selectedReminder,
                        ),
                      ),
                      SizedBox(
                          width: 30,
                          child: SvgPicture.asset('assets/icons/stopwatch.svg',
                              width: 24, height: 24, color: Color(0xFF475569)),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFD0D5DD),
                      width: 1,
                    ),
                  ),
                  height: 1,
                ),
                Container(
                  height: 56,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MultiSelectDropDown(
                          controller: labelsMultiSelectController,
                          onOptionSelected: (List<ValueItem> selectedOptions) {},
                          options: labels.map((key) => ValueItem(label: key, value: key)).toList(),
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                          optionTextStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.bold,
                          ),
                          borderColor: Colors.transparent,
                          focusedBorderColor: Colors.transparent,
                          borderWidth: 0,
                          focusedBorderWidth: 0,
                          clearIcon: Icon(Icons.clear),
                          padding: EdgeInsets.all(0),
                          hint: 'Assistants',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.bold,
                          ),
                          hintPadding: const EdgeInsets.all(0),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: SvgPicture.asset('assets/icons/tag.svg',
                            width: 24, height: 24, color: const Color(0xFF475569)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(),
          Row(),
          Row(),
          Card(),
        ],
      ),
    );
  }

  Widget _buildPlaceRecommendationPopup() {
    return Column(
      children: <Widget>[
      ],
    );
  }
}
