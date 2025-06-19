import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:village_wheels_delivery_boy/data/models/order/bill_item_model.dart';
import 'package:village_wheels_delivery_boy/data/models/order/order_model.dart';
import 'package:village_wheels_delivery_boy/data/repositories/order_repo.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  final int totalSteps = 5;

  var currentStep = 2;

  void gotoStep(int step) {
    if (step >= 0 && step < totalSteps) {
      currentStep = step;
      update();
    }
  }

  List<OrderModel> orderItems = [
    OrderModel(
      imageUrl: Assets.imagesDaal,
      name: "Tata Sampann Toor Dal",
      unit: "1kg",
      price: 120,
      quantity: 1,
    ),
    OrderModel(
      imageUrl: Assets.imagesMilk,
      name: "Nestle Milkmaid Condensed Milk",
      unit: "1L",
      price: 150,
      quantity: 2,
    ),
  ];
  List<BillItemModel> billItems = [
    BillItemModel(label: "Subtotal", value: "₹ 120", isFree: false, isTotal: false),
    BillItemModel(label: "Delivery Fee", value: "₹ 10", isFree: true, isTotal: true),
    BillItemModel(label: "Handling Fee", value: "₹ 10", isFree: true, isTotal: false),
    BillItemModel(label: "GST", value: "₹ 10", isFree: false, isTotal: false),
    BillItemModel(label: "Paid Amount", value: "₹ 130", isFree: false, isTotal: false),
  ];
}
