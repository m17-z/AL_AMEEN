import 'package:get/get.dart';

import '../modules/unused_filles/splash/auth_view_model.dart';
import '../modules/Home/controller/home_controller.dart';

class Binding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(()=>AuthViewModel());
    Get.lazyPut(()=>HomeController());
    // Get.lazyPut(()=>TablesViewModel());
    // Get.lazyPut(()=>PaymentViewModel());
    // Get.lazyPut(()=>WorkPeriodViewModel());
    // Get.lazyPut(()=>InvoiceViewModel());
    // Get.lazyPut(()=>ItemsViewModel());
    // Get.lazyPut(()=> SearchControllerView());
    // Get.lazyPut(()=>CashViewModel());
    // Get.lazyPut(()=>CurrencyViewModel());
    // Get.lazyPut(()=>DepartmentViewModel());
    // Get.lazyPut(()=>QrCodeController());
    // Get.put(LocalStorageData());

  }

}