import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';

class RatingBottomSheet extends ConsumerStatefulWidget {
  const RatingBottomSheet({
    super.key,
    required this.building,
  });

  final String building;

  @override
  ConsumerState<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends ConsumerState<RatingBottomSheet> {

  double _rating = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            StringConstants.rateYourRecommendations,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ColorConstants.black,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating: _rating,
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
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                StringConstants.cancelButton,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorConstants.red,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(width: 32),
            ElevatedButton(
              onPressed: () {
                ref.read(registerButtonTapProvider(buttonName: AnalyticsConstants.SUBMIT_RATING_BUTTON));
                ref.read(submitRatingProvider(rating: _rating, classroom: widget.building));
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(ColorConstants.limerick),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                ),
              ),
              child: Text(
                StringConstants.submitButton,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorConstants.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}