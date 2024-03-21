import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(  // TODO add a toggle to switch between one-time and recurrent events
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
          const SizedBox(height: 20),
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
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Event Name',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFF475569),
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
                          chipConfig: const ChipConfig(
                            wrapType: WrapType.scroll,
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          optionTextStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
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
                          chipConfig: const ChipConfig(
                              wrapType: WrapType.scroll,
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                          ),
                          optionTextStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
                          ),
                          borderColor: Colors.transparent,
                          focusedBorderColor: Colors.transparent,
                          borderWidth: 0,
                          focusedBorderWidth: 0,
                          clearIcon: Icon(Icons.clear),
                          padding: EdgeInsets.all(0),
                          hint: 'Labels',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF475569),
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFD0D5DD), width: 1),
            ),
            width: double.infinity,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                      "Event Color",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color(0xFF475569)
                      )
                  ),
                ),
                EventColorInput(),
              ]
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(  // TODO - Add a date picker
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFD0D5DD), width: 1),
                  ),
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset('assets/icons/calendar-check.svg',
                            width: 24, height: 24, color: const Color(0xFF475569)),
                        const SizedBox(width: 12),
                        const Text(
                            "Wednesday",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xFF475569)
                            )
                        ),
                      ]
                  )
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFD0D5DD), width: 1),
                  ),
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset('assets/icons/note-sticky.svg',
                            width: 24, height: 24, color: const Color(0xFF475569)),
                        const SizedBox(width: 12),
                        const Text(
                            "Notes",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xFF475569)
                            )
                        ),
                      ]
                  )
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(  // TODO - Add a time picker
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFD0D5DD), width: 1),
                  ),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('assets/icons/hourglass-start.svg',
                          width: 24, height: 24, color: const Color(0xFF475569)),
                      const SizedBox(width: 12),
                      const Text(
                          "2:00 PM",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFF475569)
                          )
                      ),
                    ]
                  )
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFD0D5DD), width: 1),
                  ),
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset('assets/icons/hourglass-end.svg',
                            width: 24, height: 24, color: const Color(0xFF475569)),
                        const SizedBox(width: 12),
                        const Text(
                            "3:00 PM",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xFF475569)
                            )
                        ),
                      ]
                  )
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Color(0xFF9DCC18).withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFD0D5DD), width: 1),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                    "Find a Place on Campus",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.bold
                    )
                ),
                const SizedBox(width: 12),
                SvgPicture.asset('assets/icons/location-dot.svg',
                    width: 24, height: 24, color: const Color(0xFF475569)),
              ]
            ),
          ),
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


class EventColorInput extends StatefulWidget {
  const EventColorInput({Key? key}) : super(key: key);

  @override
  _EventColorInputState createState() => _EventColorInputState();
}

class _EventColorInputState extends State<EventColorInput> {

  Color currentColor = Colors.deepPurpleAccent;
  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    displayThumbColor: true,
                    enableAlpha: false,
                    paletteType: PaletteType.hsv,
                    pickerAreaBorderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              );
            },
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(currentColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        child: const SizedBox(
          width: 24,
          height: 24,
        )
    );
  }
}

