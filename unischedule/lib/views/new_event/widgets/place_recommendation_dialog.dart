import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/models/available_spaces/available_spaces_model.dart';

class PlaceRecommendationsDialog extends ConsumerStatefulWidget {
  const PlaceRecommendationsDialog({super.key});

  @override
  ConsumerState<PlaceRecommendationsDialog> createState() => _PlaceRecommendationsDialogState();
}

class _PlaceRecommendationsDialogState extends ConsumerState<PlaceRecommendationsDialog> {

  @override
  Widget build(BuildContext context) {
    var availableSpaces = ref.watch(fetchAvailableSpacesProvider).value ?? <AvailableSpacesModel>[];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 24,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Place Recommendations', // TODO use StringConstants
                style: TextStyle( // TODO use text theme
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.black,
                  decoration: TextDecoration.none,
                )),
            Expanded(
              child: ListView.separated(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  itemBuilder: (BuildContext context, int index) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${availableSpaces[index].building}-${availableSpaces[index].room}',
                                style: const TextStyle( // TODO use text theme
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: Color(0xFF475569), // TODO use ColorConstants
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 4),
                            Text(
                              // TODO use String Constants
                                'Available from ${availableSpaces[index].availableFrom.substring(0, 2)}:${availableSpaces[index].availableFrom.substring(2)} to ${availableSpaces[index].availableUntil.substring(0, 2)}:${availableSpaces[index].availableUntil.substring(2)}',
                                style: const TextStyle( // TODO use text theme
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Color(0xFF475569), // TODO use ColorConstants
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8), // Borde redondeado
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/buildings/${availableSpaces[index].building}.jpg'), // TODO use AssetConstants
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1, color: Color(0xFFD0D5DD)), // TODO use ColorConstants
                  itemCount: availableSpaces.length),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel', // TODO use StringConstants
                      style: TextStyle( // TODO use text theme
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Color(0xFF9FA5C0), // TODO use ColorConstants
                        decoration: TextDecoration.none,
                      )),
                ),
                const SizedBox(width: 48),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    // Muestra el nuevo ModalBottomSheet desde abajo
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: const BoxDecoration(
                              color: ColorConstants.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'Rate your recommendations', // TODO use StringConstants
                                    style: TextStyle( // TODO use text theme
                                      fontFamily: 'Poppins',
                                      fontSize: 28,
                                      color: ColorConstants.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 1,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          RatingBar.builder(
                                            initialRating: 5,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                                            itemBuilder: (context, index) {
                                              switch (index) {
                                                case 0:
                                                  return const Icon(
                                                    Icons.sentiment_very_dissatisfied,
                                                    color: Colors.red,
                                                  );
                                                case 1:
                                                  return const Icon(
                                                    Icons.sentiment_dissatisfied,
                                                    color: Colors.redAccent,
                                                  );
                                                case 2:
                                                  return const Icon(
                                                    Icons.sentiment_neutral,
                                                    color: Colors.amber,
                                                  );
                                                case 3:
                                                  return const Icon(
                                                    Icons.sentiment_satisfied,
                                                    color: Colors.lightGreen,
                                                  );
                                                case 4:
                                                  return const Icon(
                                                    Icons.sentiment_very_satisfied,
                                                    color: Colors.green,
                                                  );
                                                default:
                                                  return Container();
                                              }
                                            },
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel', // TODO use StringConstants
                                        style: TextStyle( // TODO use text theme
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color: ColorConstants.red, // Cambiar el color deseado
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.green), // TODO use ColorConstants
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Submit', // TODO use StringConstants
                                        style: TextStyle( // TODO use text theme
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color: ColorConstants.white,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: const Text(
                    'Confirm', // TODO use StringConstants
                    style: TextStyle( // TODO use text theme
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Color(0xFF9DCC18), // TODO use ColorConstants
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}