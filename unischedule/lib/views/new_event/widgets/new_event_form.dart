import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';
import 'place_recommendation_dialog.dart';
import 'color_picker_button.dart';
import 'package:uuid/uuid.dart';
import '';

class NewEventForm extends ConsumerStatefulWidget {
  const NewEventForm({super.key});

  @override
  ConsumerState<NewEventForm> createState() => _NewEventFormState();
}

class _NewEventFormState extends ConsumerState<NewEventForm> {
  DateTime _eventStartTime = DateTime.now();
  String _selectedDuration = '1 Hour';
  String? _selectedReminder;
  String _eventName = ''; // Almacenar el nombre del evento
  String _eventDescription = ''; // Almacenar la descripción del evento
  final Uuid _uuid = Uuid();
  String _eventColor = '#9DCC18'; // Color por defecto en formato HEX
  List<String> _selectedLabels = [];

  int _getReminderMinutes(String? reminder) {
    switch (reminder) {
      case '5 minutes before':
        return 5;
      case '15 minutes before':
        return 15;
      case '30 minutes before':
        return 30;
      case '1 hour before':
        return 60;
      default:
        return 0; // No reminder or unhandled value
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    const assistants = <String>[
      'Laura',
      'Gotty',
      'Sebastian',
      'Juan',
    ];
    final MultiSelectController assistantsMultiSelectController =
        MultiSelectController();

    const reminders = <String>[
      'No reminder',
      'At time of event',
      '5 minutes before',
      '15 minutes before',
      '30 minutes before',
      '1 hour before',
    ];

    const labels = <String>[
      'Uniandes 📚',
      'Work 👩‍💻',
      'Personal ✨',
      'Family 👨‍👩‍👧‍👦',
      'Friends 👯‍',
    ];
    final MultiSelectController labelsMultiSelectController =
        MultiSelectController();

    var availableSpacesParams = ref.watch(availableSpacesParamsProvider);
    _eventStartTime = DateTime(
      _eventStartTime.year,
      _eventStartTime.month,
      _eventStartTime.day,
      availableSpacesParams.start.hour,
      availableSpacesParams.start.minute,
    );
    _selectedDuration =
        '${availableSpacesParams.duration.inHours} Hour${availableSpacesParams.duration.inHours > 1 ? 's' : ''}';

    // TODO Split into components an move form elements to widgets to make them reusable
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              // TODO add a toggle to switch between one-time and recurrent events
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.limerick,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: ColorConstants.limerick,
                        width: 1), // TODO replace with Color Constant
                  ),
                  child: const Text(
                    'One-Time', // TODO replace with String Constant
                    style: TextStyle(
                      // TODO replace with text theme Constant
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: ColorConstants.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color:  ColorConstants.white,
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: const Color(0xFFD0D5DD), width: 1),
                  ),
                  child: const Text(
                    'Recurrent', // TODO replace with String Constant
                    style: TextStyle(
                      fontFamily:
                          'Poppins', // TODO replace with text theme Constant
                      fontSize: 14,
                      color: Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFFD0D5DD),
                    width: 1), // TODO replace with Color Constant
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 56, // TODO replace with Style Constant
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLength: 50,
                            buildCounter: (BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
                            onChanged: (value) =>
                                setState(() => _eventName = value),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFF475569),
                            ),
                            decoration: const InputDecoration(
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
                          child: SvgPicture.asset(
                              'assets/icons/signature.svg', // TODO replace with Asset Constant
                              width: 24, // TODO replace with Style Constant
                              height: 24, // TODO replace with Style Constant
                              color: const Color(
                                  0xFF475569)), // TODO replace with Color Constant
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(
                            0xFFD0D5DD), // TODO replace with Color Constant
                        width: 1,
                      ),
                    ),
                    height: 1,
                  ),
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        Expanded(
                          child: MultiSelectDropDown(
                            controller: assistantsMultiSelectController,
                            onOptionSelected:
                                (List<ValueItem> selectedOptions) {
                              // TODO Implement logic to handle selected assistants
                            },
                            options: assistants
                                .map((key) => ValueItem(label: key, value: key))
                                .toList(),
                            selectionType: SelectionType.multi,
                            chipConfig: const ChipConfig(
                              wrapType: WrapType.scroll,
                              labelStyle: TextStyle(
                                // TODO replace with text theme Constant
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(
                                    0xFFFFFFFF), // TODO replace with Color Constant
                              ),
                            ),
                            optionTextStyle: const TextStyle(
                              // TODO replace with text theme Constant
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(
                                  0xFF475569), // TODO replace with Color Constant
                            ),
                            borderColor: Colors.transparent,
                            focusedBorderColor: Colors.transparent,
                            borderWidth: 0,
                            focusedBorderWidth: 0,
                            clearIcon: const Icon(Icons.clear),
                            padding: const EdgeInsets.all(0),
                            hint: 'Assistants', // TODO replace with String Constant
                            hintStyle: const TextStyle(
                              // TODO replace with text theme Constant
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFF475569), // TODO replace with Color Constant
                            ),
                            hintPadding: const EdgeInsets.all(0),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: SvgPicture.asset(
                              'assets/icons/person-chalkboard.svg', // TODO replace with Asset Constant
                              width: 24, // TODO replace with Style Constant
                              height: 24, // TODO replace with Style Constant
                              color: const Color(
                                  0xFF475569)), // TODO replace with Color Constant
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(
                            0xFFD0D5DD), // TODO replace with Color Constant
                        width: 1,
                      ),
                    ),
                    height: 1,
                  ),
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  'Reminder', // TODO replace with String Constant
                              hintStyle: TextStyle(
                                // TODO replace with text theme Constant
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xFF475569), // TODO replace with Color Constant
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            items: reminders.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    // TODO replace with text theme Constant
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Color(
                                        0xFF475569), // TODO replace with Color Constant
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedReminder = newValue;
                              });
                            },
                            value: _selectedReminder,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: SvgPicture.asset(
                              'assets/icons/stopwatch.svg', // TODO replace with Asset Constant
                              width: 24, // TODO replace with Style Constant
                              height: 24, // TODO replace with Style Constant
                              color: const Color(
                                  0xFF475569)), // TODO replace with Color Constant
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(
                            0xFFD0D5DD), // TODO replace with Color Constant
                        width: 1,
                      ),
                    ),
                    height: 1,
                  ),
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        Expanded(
                          child: MultiSelectDropDown(
                            controller: labelsMultiSelectController,
                            onOptionSelected:
                                (List<ValueItem> selectedOptions) {
                              setState(() {
                                _selectedLabels = selectedOptions
                                    .map((item) => item.value as String)
                                    .toList();
                              });
                            },
                            options: labels
                                .map((key) => ValueItem(label: key, value: key))
                                .toList(),
                            selectionType: SelectionType.multi,

                            chipConfig: const ChipConfig(
                              wrapType: WrapType.scroll,
                              labelStyle: TextStyle(
                                // TODO replace with text theme Constant
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(
                                    0xFFFFFFFF), // TODO replace with Color Constant
                              ),
                            ),
                            optionTextStyle: const TextStyle(
                              // TODO replace with text theme Constant
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(
                                  0xFF475569), // TODO replace with Color Constant
                            ),
                            borderColor: Colors.transparent,
                            focusedBorderColor: Colors.transparent,
                            borderWidth: 0,
                            focusedBorderWidth: 0,
                            clearIcon: const Icon(Icons.clear),
                            padding: const EdgeInsets.all(0),
                            hint: 'Labels', // TODO replace with String Constant
                            hintStyle: const TextStyle(
                              // TODO replace with text theme Constant
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(
                                  0xFF475569), // TODO replace with Color Constant
                            ),
                            hintPadding: const EdgeInsets.all(0),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: SvgPicture.asset(
                              'assets/icons/tag.svg', // TODO replace with Asset Constant
                              width: 24, // TODO replace with Style Constant
                              height: 24, // TODO replace with Style Constant
                              color: const Color(
                                  0xFF475569)), // TODO replace with Color Constant
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
                color:
                    const Color(0xFFFFFFFF), // TODO replace with Color Constant
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFFD0D5DD),
                    width: 1), // TODO replace with Color Constant
              ),
              width: double.infinity,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                  child: Text(
                      'Event Color', // TODO replace with String Constant
                      style: TextStyle(
                          // TODO replace with text theme Constant
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color(
                              0xFF475569))), // TODO replace with Color Constant
                ),
                ColorPickerButton(
                  onColorSelected: (colorHex) {
                    setState(() {
                      _eventColor =
                          colorHex; // Actualiza el color del evento con el seleccionado
                    });
                  },
                ),
              ]),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  onConfirm: (date) {
                    setState(() {
                      _eventStartTime = date;
                      ref.read(availableSpacesParamsProvider.notifier).state =
                          AvailableSpacesParamsModel(
                        duration: availableSpacesParams.duration,
                        start: date,
                      );
                    });
                  },
                  currentTime: _eventStartTime,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(
                      0xFFFFFFFF), // TODO replace with Color Constant
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color(0xFFD0D5DD),
                      width: 1), // TODO replace with Color Constant
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(
                        'assets/icons/hourglass-start.svg', // TODO replace with Asset Constant
                        width: 24, // TODO replace with Style Constant
                        height: 24, // TODO replace with Style Constant
                        color: const Color(
                            0xFF475569) // TODO replace with Color Constant
                        ),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('MMMM dd - HH:mm').format(_eventStartTime),
                      style: const TextStyle(
                          // TODO replace with text theme Constant
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color(
                              0xFF475569)), // TODO replace with Color Constant
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24), // Ajustado para aumentar la altura
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFFFFFFF), // TODO replace with Color Constant
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFD0D5DD),
                          width: 1), // TODO replace with Color Constant
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset(
                            'assets/icons/calendar-day.svg', // TODO replace with Asset Constant
                            width: 24, // TODO replace with Style Constant
                            height: 24, // TODO replace with Style Constant
                            color: const Color(
                                0xFF475569)), // TODO replace with Color Constant
                        const SizedBox(width: 12),
                        Text(
                          DateFormat('EEEE').format(_eventStartTime),
                          style: const TextStyle(
                              // TODO replace with text theme Constant
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(
                                  0xFF475569)), // TODO replace with Color Constant
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFFFFFFF), // TODO replace with Color Constant
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFD0D5DD),
                          width: 1), // TODO replace with Color Constant
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            'assets/icons/clock.svg', // TODO replace with Asset Constant
                            width: 24, // TODO replace with Style Constant
                            height: 24, // TODO replace with Style Constant
                            color: const Color(
                                0xFF475569)), // TODO replace with Color Constant
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedDuration,
                              items: <String>[
                                '1 Hour',
                                '2 Hours',
                                '3 Hours',
                                '4 Hours'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedDuration = newValue!;
                                  ref
                                      .read(availableSpacesParamsProvider
                                          .notifier)
                                      .state = AvailableSpacesParamsModel(
                                    duration: Duration(
                                        hours:
                                            int.parse(newValue.split(' ')[0])),
                                    start: availableSpacesParams.start,
                                  );
                                });
                              },
                              style: const TextStyle(
                                // TODO replace with text theme Constant
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(
                                    0xFF475569), // TODO replace with Color Constant
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
              if (connectivityStatus == ConnectivityStatus.isConnected) {
              showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: MaterialLocalizations.of(context)
                .modalBarrierDismissLabel,
              barrierColor: Colors.black45,
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
                return Center(
                child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const PlaceRecommendationsDialog(),
                ),
                );
              },
              );
              }
              },
              child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
              color: connectivityStatus == ConnectivityStatus.isConnected
                ? const Color(0xFF9DCC18).withOpacity(0.15)
                : Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD0D5DD),
                width: 1),
              ),
              width: double.infinity,
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                connectivityStatus == ConnectivityStatus.isConnected
                ? 'Find a Place on Campus' 
                : 'No Internet Connection',
                style: TextStyle(
                fontFamily: 'Poppins', 
                fontSize: 16,
                color: Color(0xFF475569),
                fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              connectivityStatus == ConnectivityStatus.isConnected
                ? SvgPicture.asset(
                    'assets/icons/location-dot.svg',
                    width: 24,
                    height: 24,
                    color: const Color(0xFF475569))
                : Icon(
                    Icons.signal_wifi_off,
                    size: 24,
                    color: const Color(0xFF475569),
                  ),
              ]),
              ),
            ),
            // TODO this is a temporal button to create the event
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                DateTime notificationTime = _eventStartTime.subtract(
                    Duration(minutes: _getReminderMinutes(_selectedReminder)));
                String eventId = _uuid.v4();

                EventModel event = EventModel(
                  id: eventId,
                  color: _eventColor,
                  reminder: _getReminderMinutes(_selectedReminder),
                  endDate: {
                    '_seconds': _eventStartTime
                            .add(Duration(
                                hours:
                                    int.parse(_selectedDuration.split(' ')[0])))
                            .millisecondsSinceEpoch ~/
                        1000,
                    '_nanoseconds': _eventStartTime
                            .add(Duration(
                                hours:
                                    int.parse(_selectedDuration.split(' ')[0])))
                            .microsecondsSinceEpoch *
                        1000,
                  },
                  name: _eventName,
                  description: _eventDescription,
                  startDate: {
                    '_seconds': _eventStartTime.millisecondsSinceEpoch ~/ 1000,
                    '_nanoseconds':
                        _eventStartTime.microsecondsSinceEpoch * 1000,
                  },
                  labels:
                      _selectedLabels, // Utiliza las etiquetas seleccionadas
                );
                ref.read(addEventProvider(event: event).future);
                NotificationService().scheduleNotification(
                    title: 'Scheduled Event Reminder',
                    body:
                        'Your event $_eventName is about to start at ${DateFormat('HH:mm').format(_eventStartTime)}',
                    scheduledNotificationDateTime: notificationTime);
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF9DCC18),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF9DCC18), width: 1),
                ),
                width: double.infinity,
                child: const Text('Create Event',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xFFFFFFFF))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
