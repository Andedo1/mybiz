import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:majisoft/data/api/api_checker.dart';
import 'package:majisoft/data/repository/location_repo.dart';
import 'package:majisoft/models/response_model.dart';
import 'package:google_maps_webservice/src/places.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlaceMark = Placemark();
  bool get loading => _loading;
  // for service zone
  bool _isLoading = false;
  bool _inZone = false;
  bool _buttonDisabled = true;
  bool get isLoading => _isLoading;
  bool get inZone => _inZone;
  bool get buttonDisabled => _buttonDisabled;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList = [];
  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlaceMark;


  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressdata = true;
  bool _changeAddress = true;

  // Save google map suggestions for address
  List<Prediction> _predictions = [];


  void setMapController(GoogleMapController mapController){
    _mapController = mapController;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async{
    if(_updateAddressdata){
      _loading = true;
      update();
      try{
        if(fromAddress){
          _position = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1
          );
        }else{
          _pickPosition = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1
          );
        }
        ResponseModel responseModel = await getZone(
            cameraPosition.target.latitude.toString(),
            cameraPosition.target.longitude.toString(), false);
        // If button value is false we are in the service area.
        _buttonDisabled=!responseModel.isSuccess;

        if(_changeAddress){
          String address = await getAddressFromGeocode(
            LatLng(
              cameraPosition.target.latitude,
              cameraPosition.target.longitude,
            )
          );
          fromAddress?_placemark = Placemark(name: address):
              _pickPlaceMark = Placemark(name: address);
        } else{
          _changeAddress = true;
        }
      }catch(e){
        print(e);
      }
      _loading = false;
      update();
    }else{
      _updateAddressdata = true;
    }

  }


  Future<String> getAddressFromGeocode(LatLng latLng) async{
    String address = "Unknown Location found";
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if(response.body["status"]=='OK'){
      address = response.body["results"][0]["formatted_address"].toString();
    }else{
      print("Error getting data from api");
    }
    update();
    return address;
  }

  AddressModel getUserAddress(){
    late AddressModel _addressModel;
    // Convert to map using jsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    }catch(e){
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      await getAddressList(); //return address from server
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      // save user address
      await saveUserAddress(addressModel);
    }else{
      print("Could not save address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async{
    Response response = await locationRepo.getAllAddress();
    if(response.statusCode==200){
      _addressList=[];
      _allAddressList=[];
      response.body.forEach((address){
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    }else{
      _addressList=[];
      _allAddressList=[];
    }
    update();
  }

  saveUserAddress(AddressModel addressModel) async{
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList(){
    _addressList=[];
    _allAddressList=[];
    update();
  }

  getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddedAddressData(){
    _position = _pickPosition;
    _placemark = _pickPlaceMark;
    _updateAddressdata = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async{
    late ResponseModel responseModel;
    if(markerLoad){
      _loading=true;
    }else{
      _isLoading=true;
    }
    update();
    /*
    dummy network request.
    await Future.delayed(const Duration(seconds: 2), (){
      responseModel = ResponseModel(true, "success");
      if(markerLoad){
        _loading=false;
      }else{
        _isLoading=false;
      }
    });  */
    Response response = await locationRepo.getZone(lat, lng);
    if(response.statusCode == 200){
      _inZone = true;
      responseModel = ResponseModel(true, response.body["zone_id"].toString());
    }else{
      _inZone = false;
      responseModel = ResponseModel(true, response.statusText!);
    }
    if(markerLoad){
      _loading=false;
    }else{
      _isLoading=false;
    }
    update();
    return responseModel;
  }

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty){
      Response response = await locationRepo.searchLocation(text);
      if(response.statusCode==200 && response.body['status']=='OK'){
        _predictions = [];
        response.body['predictions'].forEach((prediction){
          _predictions.add(Prediction.fromJson(prediction));
        });
      }else{
        ApiChecker.checkApi(response);
      }
    }
    return _predictions;
  }

  setLocation(String placeID, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepo.setLocation(placeID);
    detail = PlacesDetailsResponse.fromJson(response.body);
    _pickPosition = Position(
      latitude: detail.result.geometry!.location.lat,
      longitude: detail.result.geometry!.location.lng,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
    );
    _pickPlaceMark = Placemark(name: address);
    _changeAddress = false;
    if(!mapController.isNull){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(
            detail.result.geometry!.location.lat,
            detail.result.geometry!.location.lng,
          ), zoom: 17)));
    }
    _loading = false;
    update();
  }
}