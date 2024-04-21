import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:unischedule/constants/constants.dart';

class ColorPickerButton extends StatefulWidget {
  final void Function(String) onColorSelected;  // Callback para devolver el color en formato HEX

  const ColorPickerButton({Key? key, required this.onColorSelected}) : super(key: key);

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  Color currentColor = ColorConstants.limerick; // Usa el color por defecto de tus constantes

  void changeColor(Color color) {
    setState(() => currentColor = color);
    widget.onColorSelected('#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}'); // Convierte a HEX y envía a través del callback
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
