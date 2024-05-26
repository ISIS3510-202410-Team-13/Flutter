import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/feature_analytics/feature_analytics_provider.dart';

class ColorPickerButton extends ConsumerStatefulWidget {
  final void Function(String) onColorSelected;

  const ColorPickerButton({super.key, required this.onColorSelected});

  @override
  ConsumerState<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends ConsumerState<ColorPickerButton> {
  Color currentColor = ColorConstants.limerick;

  void changeColor(Color color) {
    setState(() => currentColor = color);
    widget.onColorSelected('#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          ref.read(registerButtonTapProvider(buttonName: AnalyticsConstants.COLOR_PICKER_BUTTON));
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
                    pickerAreaBorderRadius:
                    const BorderRadius.all(Radius.circular(16)),
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
        child: const SizedBox(width: 24, height: 24));
  }
}
