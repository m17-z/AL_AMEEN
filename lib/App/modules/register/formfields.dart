import 'package:al_ameen/App/helper/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FormFields {
  static Widget build({
    required int loginPage,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller0,
    required TextEditingController controller1,
    required TextEditingController controller2,
    required List<TextEditingController> controllers,
    required List<TextEditingController> conform,
    required List<FocusNode> focusNodes,
    required Function(void Function()) setState,
    required List<String> controllerTextForm,
    required List<String> conformTextForm,
    required int maxLength,
  }) {
    if (loginPage == 0) {
      return _buildCustomerNumberField(controller0);
    } else if (loginPage == 1) {
      return _buildPhoneNumberField(
        controller1, 
        maxLength,
        setState,
      );
    } else if (loginPage == 2) {
      return _buildIdentificationField(controller2);
    } else if (loginPage == 3 || loginPage == 4) {
      return _buildPasswordField(
        context,
        loginPage,
        controllers,
        conform,
        focusNodes,
        formKey,
        controllerTextForm,
        conformTextForm,
      );
    }
    return Container();
  }

  static Widget _buildCustomerNumberField(TextEditingController controller) {
    return CustomTextFormField.textFieldStyle(
      controller: controller,
      hintText: 'Customer Number'.tr,
      width: Get.width * 0.6,
      height: Get.height * 0.08,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
    );
  }

  static Widget _buildPhoneNumberField(
    TextEditingController controller,
    int maxLength,
    Function(void Function()) setState,
  ) {
    return CustomTextFormField.textFieldStyle(
      controller: controller,
      hintText: 'Phone Number'.tr,
      width: Get.width * 0.6,
      height: Get.height * 0.08,
      textAlign: TextAlign.center,
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the phone number'.tr;
        } else if (value.length < maxLength) {
          return 'Phone number must be $maxLength digits'.tr;
        } else if (!value.startsWith('07') && !value.startsWith('9627')) {
          return 'The value must start with "07" or "9627"'.tr;
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          if (value.startsWith('962')) {
            maxLength = 12;
          } else {
            maxLength = 10;
          }
        });
      },
    );
  }

  static Widget _buildIdentificationField(TextEditingController controller) {
    return CustomTextFormField.textFieldStyle(
      controller: controller,
      hintText: 'Identification Number'.tr,
      width: Get.width * 0.6,
      height: Get.height * 0.08,
      textAlign: TextAlign.center,
      maxLength: 6,
      keyboardType: TextInputType.number,
    );
  }

  static Widget _buildPasswordField(
    BuildContext context,
    int loginPage,
    List<TextEditingController> controllers,
    List<TextEditingController> conform,
    List<FocusNode> focusNodes,
    GlobalKey<FormState> formKey,
    List<String> controllerTextForm,
    List<String> conformTextForm,
  ) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
              child: TextFormField(
                controller: loginPage == 3 ? controllers[index] : conform[index],
                focusNode: focusNodes[index],
                maxLength: 1,
                obscureText: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  formKey.currentState!.validate();
                  if (value.length == 1) {
                    _handlePasswordInput(
                      context,
                      index,
                      loginPage,
                      controllers,
                      conform,
                      focusNodes,
                      controllerTextForm,
                      conformTextForm,
                    );
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  static void _handlePasswordInput(
    BuildContext context,
    int index,
    int loginPage,
    List<TextEditingController> controllers,
    List<TextEditingController> conform,
    List<FocusNode> focusNodes,
    List<String> controllerTextForm,
    List<String> conformTextForm,
  ) {
    if (loginPage == 3) {
      if (index < controllers.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
      controllerTextForm.clear();
      for (var ctrl in controllers) {
        controllerTextForm.add(ctrl.text);
      }
    } else {
      conformTextForm.clear();
      for (var conformCtrl in conform) {
        conformTextForm.add(conformCtrl.text);
      }
      if (index < conform.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    }
  }
}