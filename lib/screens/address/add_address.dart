import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:majisoft/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/user_controller.dart';
import 'package:majisoft/models/address_model.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/screens/address/pick_address_map.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/text_field.dart';

import '../../controllers/location_controller.dart';
import '../../root/custom_appbar.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;
  // Initial Camera position
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
      -1.286389, 36.817223
  ), zoom: 17);

  late LatLng _initialPosition = const LatLng(
      -1.286389, 36.817223
  );

  @override
  void initState(){
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(
            Get.find<LocationController>().addressList.last
        );
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My address",
      ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text = userController.userModel.name;
          _contactPersonNumber.text = userController.userModel.phone;
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = '${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: Colors.green,
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17),
                        onTap: (latLng){
                          Get.toNamed(RoutesHelper.getPickAddressMapPage(), arguments: PickAddressMap(
                            fromAddress: true,
                            fromSignUp: false,
                            googleMapController: locationController.mapController,
                          ));
                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position) => _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                        },
                      )
                    ],
                  ),
                ),
                // Address Icons
                Padding(
                  padding: EdgeInsets.only(left: Dimension.width20, top: Dimension.height30),
                  child: SizedBox(
                    height: Dimension.height10*5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            locationController.setAddressTypeIndex(index);
                          },
                          highlightColor: Colors.white,
                          child: Container(
                            margin: EdgeInsets.only(right: Dimension.width20),
                            padding: EdgeInsets.symmetric(horizontal: Dimension.width20, vertical: Dimension.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimension.radius20/4),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(1,1),
                                  color: Colors.grey[200]!,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                )
                              ]
                            ),
                            child: Icon(
                              index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                              color: locationController.addressTypeIndex==index?Colors.green:Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      },
                    )
                  ),
                ),
                SizedBox(height: Dimension.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimension.width20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimension.height20,),
                AppTextField(
                  textEditingController: _addressController,
                  hintText: "Your address",
                  icon: Icons.map,
                ),
                SizedBox(height: Dimension.height10,),
                Padding(
                  padding: EdgeInsets.only(left: Dimension.width20),
                  child: BigText(text: "Contact person"),
                ),
                SizedBox(height: Dimension.height20,),
                AppTextField(
                  textEditingController: _contactPersonName,
                  hintText: "Your Name",
                  icon: Icons.person,
                ),
                SizedBox(height: Dimension.height10,),
                Padding(
                  padding: EdgeInsets.only(left: Dimension.width20),
                  child: BigText(text: "Contact number"),
                ),
                SizedBox(height: Dimension.height10,),
                AppTextField(
                  textEditingController: _contactPersonNumber,
                  hintText: "Your number",
                  icon: Icons.phone,
                ),
              ],
            ),
          );
        });
      },),
      bottomNavigationBar: GetBuilder<LocationController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: Dimension.width20*2.5,
                    right: Dimension.width20*2.5,
                    top: Dimension.height10,
                    bottom: Dimension.height10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          AddressModel addressModel = AddressModel(
                            addressType: controller.addressTypeList[controller.addressTypeIndex],
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            address: _addressController.text,
                            latitude: controller.position.latitude.toString(),
                            longitude: controller.position.longitude.toString(),
                          );
                          controller.addAddress(addressModel).then((response){
                            if(response.isSuccess){
                              Get.toNamed(RoutesHelper.getCart());
                              Get.snackbar("Address", "Address saved Successfully");
                            }else{
                              Get.snackbar("Address", "Could not save address to server");
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimension.width20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimension.radius20),
                            color: Colors.green,
                          ),
                          child: Center(child: BigText(text: "Save address", color: Colors.white,)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}
