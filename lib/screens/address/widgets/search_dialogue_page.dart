import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:majisoft/controllers/location_controller.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/src/places.dart';

class AddressDialogue extends StatelessWidget {
  final GoogleMapController googleMapController;
  const AddressDialogue({Key? key, required this.googleMapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimension.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimension.radius20/2),
        ),
        child: SizedBox(
          width: Dimension.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: "search location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimension.radius20/2),
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimension.font16,
                ),
              ),
            ),
            onSuggestionSelected: (Prediction suggestion){
              Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, googleMapController);
              Get.back();
            },
            suggestionsCallback: (pattern) async {
              return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimension.width10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    SizedBox(width: Dimension.width10/2,),
                    Expanded(
                      child: Text(
                        suggestion.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).textTheme.bodyText1?.color,
                          fontSize: Dimension.font16,
                        ),
                      )
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
