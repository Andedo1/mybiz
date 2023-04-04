import 'package:get/get.dart';
import 'package:majisoft/models/order_model.dart';
import 'package:majisoft/models/place_order_model.dart';

import '../data/repository/order_repo.dart';

class OrderController extends GetxController implements GetxService{
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  String _orderType = 'delivery';
  String get orderType => _orderType;

  String _itemNote = '';
  String get itemNote => _itemNote;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List <OrderModel> get currentOrderList => _currentOrderList;
  List <OrderModel> get historyOrderList => _historyOrderList;

  Future<void> placeOrder(PlaceOrderModel placeOrder, Function callBack) async{
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if(response.statusCode==200){
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callBack(true, message, orderID);
    }else{
      callBack(false, response.statusText!, '-1');
    }
  }

  Future<void> getOrderList() async{
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if(response.statusCode == 200){
      _historyOrderList = [];
      _currentOrderList = [];
      response.body.forEach((element) {
        OrderModel orderModel = OrderModel.fromJson(element);
        if(orderModel.orderStatus == 'pending' || orderModel.orderStatus == 'accepted'
        || orderModel.orderStatus == 'handover' || orderModel.orderStatus == 'processing'
        || orderModel.orderStatus == 'picked_up'){
          _currentOrderList.add(orderModel);
        }else{
          _historyOrderList.add(orderModel);
        }
      });
    }else{
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;
    update();
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type){
    _orderType = type;
    update();
  }

  void setItemNote(String note){
    _itemNote = note;
  }

}