import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Maining Calculate'),
          centerTitle: true,
        ),
        body: Center(
            child: Form(
              key: controller.form,
          autovalidateMode: AutovalidateMode.always,
          child: SizedBox(
            width: width - 75,
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    textfild(context,
                        textinputType: TextInputType.text,
                        textinputaction: TextInputAction.next,
                        controller: controller.set1,
                        Show_error: true,
                        labletext: "Set1(X)", fc: (value) {
                      if (!GetUtils.isNumericOnly(value!.replaceAll(",", "")) ||
                          value.length > 9) {
                        return "Please just enter number";
                      } else {
                        return null;
                      }
                    }),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    textfild(context,
                        textinputType: TextInputType.text,
                        textinputaction: TextInputAction.next,
                        controller: controller.set2,
                        Show_error: true,
                        labletext: "Set2(y)", fc: (value) {
                      if (!GetUtils.isNumericOnly(value!.replaceAll(",", "")) ||
                          value.length > 9) {
                        return "Please just enter number";
                      } else {
                        return null;
                      }
                    }),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    textfild(context,
                        textinputType: TextInputType.text,
                        textinputaction: TextInputAction.next,
                        controller: controller.number,
                        Show_error: false,
                        labletext: "YourNumber ", fc: (value) {
                      if (!GetUtils.isNumericOnly(value!.replaceAll(",", ""))) {
                        return "Please just enter number";
                      } else {
                        return null;
                      }
                    }),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    mybutton(context,
                        width: width / 2,
                        hight: height * 0.07,
                        color: const Color.fromARGB(255, 243, 193, 27),
                        icon: const Icon(
                          Icons.calculate_outlined,
                          color: Colors.black,
                        ),
                        text: const Text(
                          "Calculate",
                          style: TextStyle(color: Colors.black),
                        ), function: () {
                      controller.onclick();
                    
                    }),
                    SizedBox(
                      height: height * 0.02,
                    ),
                     Obx(()=> text_coustum("Set(X)", "${controller.list_X}")),
                    text_coustum("Set(Y)", "${controller.list_y}"),
                    text_coustum("Mean of (Y) ", "${controller.mean_of_y}"),
                    text_coustum("Mode of (Y) ", "${controller.Mode_of_y}"),
                    text_coustum("Median of (Y)", "${controller.median_of_y}"),
                    text_coustum("Geometric mean of (Y) ",
                        "${controller.Geo_mean_of_y}"),
                    text_coustum("Mean of (Y) if (x)weight ",
                        "${controller.mean_of_y_x_weight}"),
                    text_coustum("Median of (Y) if (x)weight ",
                        "${controller.median_of_y_x_weight}"),
                    text_coustum("Mode of (Y) if (x)weight ",
                        "${controller.Mode_of_y_x_weight}"),
                    text_coustum("Geometric mean of (Y) if (x)weight  ",
                        controller.Geo_mean_of_y_X_wegit.value),
                    text_coustum(
                        "Finde variance of (Y) ", "${controller.variance_y}"),
                    text_coustum("Finde STD of (Y) ", controller.STD_y.value),
                    text_coustum("Finde STD of (Y) if (x)weight ",
                        controller.STD_y_if_x_weight.value),
                 
                  ],
                ),
              ),
            ),
          ),
        )));
  }

  Widget text_coustum(String title2, String value2) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Text("${title2}= ",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            Text("${value2}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue))
          ],
        ),
      ),
    );
  }

  textfild(BuildContext ctx,
      {required TextEditingController controller,
      TextInputType? textinputType,
      TextInputAction? textinputaction,
      required String? Function(String?) fc,
      required bool Show_error,
      bool? isenable,
      bool? readOnly,
      Function()? onTap,
      String? labletext}) {
    return TextFormField(
      readOnly: readOnly ?? false,
      keyboardType: textinputType ?? TextInputType.text,
      textInputAction: textinputaction ?? TextInputAction.next,
      controller: controller,
      validator: fc,
      enabled: isenable ?? true,
      onTap: onTap,
      style: Theme.of(ctx).textTheme.titleMedium,
      decoration: InputDecoration(
          label: Text(labletext ?? ""),
          suffix:  Text(
           Show_error? "}":"",
            style: TextStyle(fontSize: 24),
          ),
          prefix:  Text(
            Show_error?  "{":"40 - ",
            style: TextStyle(fontSize: 24),
          ),
          labelStyle: TextStyle(
              fontSize: 16, color: Theme.of(ctx).appBarTheme.backgroundColor),
          errorStyle: TextStyle(fontSize: Show_error ? 12 : 0),
          filled: true,
          focusColor: const Color(0xff502F7A),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff502F7A), width: 2.0),
              borderRadius: BorderRadius.circular(15.0)),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xff502F7A), width: 2.0),
              borderRadius: BorderRadius.circular(15.0)),
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 15, 8)),
    );
  }

  mybutton(BuildContext ctx,
      {required double width,
      required double hight,
      required Function function,
      Color? color,
      Widget? icon,
      Widget? text}) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: width,
        height: hight,
        decoration: BoxDecoration(
            color: color ?? Theme.of(ctx).appBarTheme.backgroundColor,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 0.2,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(0, 1.8))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: icon == null || text == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
          children: [
            icon ?? Container(),
            text ?? Container(),
          ],
        ),
      ),
    );
  }
}
