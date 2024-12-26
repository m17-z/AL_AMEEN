import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class HomeController extends GetxController {
  final String fileUrl = 'https://pdfdrive.com.co/wp-content/pdfh/accounts_payable.pdf'; // استبدل هذا الرابط برابط الملف الحقيقي الذي ترغب في تنزيله
  var loading = false.obs; // Use RxBool to track loading state
  var error = false.obs; // Use RxBool to track loading state
  Future<void> downloadFile() async {
    try{
      final response = await http.get(Uri.parse(fileUrl));

      if (response.statusCode == 200) {

        loading.value = true;

        final appDirectory = await getApplicationDocumentsDirectory();
        final filePath = '${appDirectory.path}/downloaded_file.pdf'; // استبدل 'downloaded_file.pdf' باسم وامتداد الملف المطلوب

        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await OpenFile.open(filePath); // فتح الملف المنزل
        Get.back();
        loading.value = false;
        error.value=false;
        print('تم تنزيل الملف إلى: $filePath');


      } else {
        loading.value = false;
        error.value=true;
        print('فشل تنزيل الملف: ${response.statusCode}');
      }
    }catch(e){
      error.value=true;
      loading.value = false;
      return print("error is "+ '$e');
    }
  }

}