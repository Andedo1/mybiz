import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/location_controller.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/screens/address/widgets/search_dialogue_page.dart';
import 'package:majisoft/utils/dimensions.dart';

import '../../widgets/custom_button.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({Key? key,
    required this.fromSignUp,
    required this.fromAddress,
    required this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  
  @override
  void initState(){
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = const LatLng(-1.286389, 36.817223);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition position){
                      _cameraPosition = position;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController = mapController;
                      if(!widget.fromAddress){
                        // TO DO
                      }
                    },
                  ),
                  Center(
                    child: !locationController.loading? Image.asset(
                      "assets/images/map_pin.png",
                      height: 50,
                      width: 50,
                    ): const CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimension.height45,
                    left: Dimension.height20,
                    right: Dimension.height20,
                    child: InkWell(
                      onTap: ()=> Get.dialog(AddressDialogue(googleMapController: _mapController)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimension.width10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(Dimension.radius20/2),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, size: 25, color: Colors.amber,),
                            Expanded(child: Text(
                              locationController.pickPlacemark.name??'',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimension.font20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            SizedBox(width: Dimension.width10,),
                            const Icon(Icons.search, size: 25, color: Colors.amber,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: Dimension.width20,
                    right: Dimension.width20,
                    child: locationController.isLoading?const Center(child: CircularProgressIndicator(),):
                    CustomButton(
                      onPressed: (locationController.buttonDisabled||locationController.loading)?null:(){
                        if(locationController.pickPosition.latitude!=0&&
                            locationController.pickPlacemark.name!=null){
                          if(widget.fromAddress){
                            if(widget.googleMapController!=null){
                              print("Now you clicked on this");
                              widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(
                                  CameraPosition(target: LatLng(
                                    locationController.pickPosition.latitude,
                                    locationController.pickPosition.longitude,
                                  ))
                              ));
                              locationController.setAddedAddressData();
                            }
                            Get.toNamed(RoutesHelper.getAddressPage());
                          }
                        }
                      },
                      buttonText: locationController.inZone?widget.fromAddress?'Pick Address':'Pick location':'Service is not available in your area',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
