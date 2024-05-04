import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/models/available_spaces/available_spaces_model.dart';
import 'rating_bottom_sheet.dart';

class PlaceRecommendationsDialog extends ConsumerStatefulWidget {
  const PlaceRecommendationsDialog({super.key});

  @override
  ConsumerState<PlaceRecommendationsDialog> createState() => _PlaceRecommendationsDialogState();
}

class _PlaceRecommendationsDialogState extends ConsumerState<PlaceRecommendationsDialog> {

  String? _building;

  @override
  Widget build(BuildContext context) {
    var availableSpacesProvider = ref.watch(fetchAvailableSpacesProvider);

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
            Text(
              StringConstants.placeRecommendations,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorConstants.black,
                  decoration: TextDecoration.none
              ),
            ),
            Expanded(
              child: availableSpacesProvider.when(
                data: (List<AvailableSpacesModel> availableSpaces) =>
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    separatorBuilder: (BuildContext context, int index) => const Divider(height: 1, color: ColorConstants.lightGrey),
                    itemCount: availableSpaces.length,
                    itemBuilder: (BuildContext context, int index) => Card(
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: _building == '${availableSpaces[index].building}-${availableSpaces[index].room}' ? ColorConstants.limerick : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _building = '${availableSpaces[index].building}-${availableSpaces[index].room}';
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${availableSpaces[index].building}-${availableSpaces[index].room}',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: ColorConstants.cloudyGrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    StringConstants.available(
                                      '${availableSpaces[index].availableFrom.substring(0, 2)}:${availableSpaces[index].availableFrom.substring(2)}',
                                      '${availableSpaces[index].availableUntil.substring(0, 2)}:${availableSpaces[index].availableUntil.substring(2)}',
                                    ),
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: ColorConstants.cloudyGrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 80,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(AssetConstants.imageBuilding(availableSpaces[index].building)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                error: (error, stackTrace) => Text(StringConstants.recommendationError(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              )
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
                      color: ColorConstants.gullGrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
                TextButton(
                  onPressed: () {
                    if (_building == null) {
                      return;
                    }
                    Navigator.of(context).pop();
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
                            child: RatingBottomSheet(building: _building!)
                          )
                        );
                      },
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: Text(
                    StringConstants.confirmButton,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _building != null ? ColorConstants.limerick : ColorConstants.gullGrey,
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