import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController set1 = TextEditingController();
  TextEditingController set2 = TextEditingController();
  TextEditingController number = TextEditingController();
    var list_X = [].obs;
  var list_y = [].obs;
  var mean_of_y = 0.0.obs;
  var median_of_y = 0.0.obs;
  var Mode_of_y = "".obs;
  var Geo_mean_of_y = 0.0.obs;
  var mean_of_y_ = 0.0.obs;
  var mean_of_y_x_weight = 0.0.obs;
  var median_of_y_x_weight = "".obs;
  var Mode_of_y_x_weight = "".obs;
  var Geo_mean_of_y_X_wegit = "".obs;
  var variance_y = 0.0.obs;
  var STD_y = "".obs;
  var STD_y_if_x_weight = "".obs;

  calculate( List xi ,List yi) async {
    mean_of_y_x_weight.value =
        mean_of_y_if_x_weight(li_x: xi, li_y: yi);
    mean_of_y.value = mean_of_y_method(yi);

    Mode_of_y.value = mode_of_y_method(yi);
    Geo_mean_of_y.value = geomatric_of_y_method(yi);
    median_of_y_x_weight.value = await median_if_x_weight(li_x: xi, li_y: yi);
    Mode_of_y_x_weight.value = mode_y_if_x_isweight(li_x: xi, li_y: yi);
    Geo_mean_of_y_X_wegit.value =
        geomatric_of_y_method_if_x_weight(li_x: xi, li_y: yi).toString();
    median_of_y.value=median_of_y_method(yi);
    variance_y.value = await find_variance_y(li_y: yi);
    STD_y.value = pow(variance_y.value, 1 / 2).toString();
    STD_y_if_x_weight.value = await STD_y_if_xweight(li_x: xi, li_y: yi);

 
  }

  double mean_of_y_method(List x) {
    double resolt = 0.0;
    for (var element in x) {
      resolt += element;
    }

    return (resolt / x.length).toDouble();
  }

  double median_of_y_method(List input) {
      double median=0.0;

    if(input.length % 2 == 0){
    	 //2.0 needs the decimal value so it doesn't truncate the result
        median =  (input[input.length ~/ 2 - 1] + input[input.length ~/ 2]) / 2;
    }else{
        median =input[(input.length / 2).toInt()].toDouble();;
    }

    return median;
  
  }
List insertionSort(List arr) {
  int n = arr.length;
  for (int i = 1; i < n; i++) {
    int key = arr[i];
    int j = i - 1;

    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j = j - 1;
    }
    arr[j + 1] = key;
  }
  return arr;
}
  String mode_of_y_method(List input) {
    Map<dynamic, int> frecuencia = {};
    var resolt;
    for (var num in input) {
      frecuencia[num] = (frecuencia[num] ?? 0) + 1;
    } //for
    int frecenciaMax = 0;

    for (var num in frecuencia.keys) {
      if (frecuencia[num]! > frecenciaMax) {
        frecenciaMax = frecuencia[num]!;
        resolt = num;
      } //if
    } //for

    if (frecenciaMax == 1) {
      resolt = 0.0;
    }
    return resolt.toString();
  }

  double geomatric_of_y_method(List x) {
    double resolt = 1.0;
    for (var element in x) {
      resolt *= element;
    }
    return pow(resolt, (1 / x.length)).toDouble();
  }

  double mean_of_y_if_x_weight({required List li_y, required List li_x}) {
    double resolt = 0.0;
    double sum_x = 0.0;
    for (var i = 0; i < li_y.length; i++) {
      resolt += li_x[i] * li_y[i];
      sum_x += li_x[i];
    }

    return (resolt / sum_x).toDouble();
  }

  median_if_x_weight({required List li_y, required List li_x}) {
    List newlist = [];
    for (var i = 0; i < li_x.length; i++) {
      for (var j = 1; j <= li_x[i]; j++) {
        newlist.add(li_y[i]);
      }
    }
    if (newlist.length % 2 == 0) {
      return ((newlist[(newlist.length / 2).toInt()] +
                  newlist[(newlist.length / 2).toInt()]) /
              2)
          .toString();
    } else {
      return newlist[(newlist.length ~/ 2) - 1].toString();
    }
  }

  String mode_y_if_x_isweight({required List li_y, required List li_x}) {
    dynamic max_value = -14589540.0;
    int modeindex = 0;
    for (var i = 0; i < li_x.length; i++) {
      if (li_x[i] > max_value) {
        max_value = li_x[i];
        modeindex = i;
      }
    }
    return li_y[modeindex].toString();
  }

  geomatric_of_y_method_if_x_weight({required List li_y, required List li_x}) {
    List newlist = [];
    for (var i = 0; i < li_x.length; i++) {
      for (var j = 1; j <= li_x[i]; j++) {
        newlist.add(li_y[i]);
      }
    }
    var resolt = geomatric_of_y_method(newlist);
    return resolt.toStringAsFixed(2);
  }

  find_variance_y({required List li_y}) async {
    double mean = 0.0;
    mean = mean_of_y_method(li_y);

    double up_rull = 0.0;
    for (var element in li_y) {
      up_rull += (element - mean) * (element - mean);
    }
    return up_rull / (li_y.length) - 1;
  }

  STD_y_if_xweight({required List li_y, required List li_x}) async {
    List newlist = [];
    for (var i = 0; i < li_x.length; i++) {
      for (var j = 1; j <= li_x[i]; j++) {
        newlist.add(li_y[i]);
      }
    }
    double resolt = await find_variance_y(li_y: newlist);
    return pow(resolt, 1 / 2).toStringAsFixed(3);
  }

  onclick()async {
    if (form.currentState!.validate()) {
      List x = [];
      List y = [];
   set1.text.length==set2.text.length ? {  
     set1.text.split(",").forEach((element) {
        x.add(int.parse(element));
      }),
      
     set2.text.split(",").forEach((element) {
        y.add(int.parse(element));
      }),

           x.insert(4, int.parse(number.text)),
     y.insert(2, 44 - int.parse(number.text)),
      list_X.value = x,
      list_y.value = y,
     
     await calculate( x,  y),
 
    }:Get.defaultDialog(
              title: "Unsuccessful",
              middleText: "For Set X and Set Y Should be Same length",
              backgroundColor: const Color.fromARGB(255, 175, 91, 76),
              titleStyle: TextStyle(color: Colors.white),
              middleTextStyle: TextStyle(color: Colors.white),

            );}
  }
}
