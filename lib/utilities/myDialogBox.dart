import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class MyDialogBox {
  static void normalDialog() {
    showDefaultDialog(
      'OOPS',
      'Sorry, something went wrong please try again after some time while we resolve your issue.',
    );
  }

  static void showDefaultDialog(String title, String midText) {
    Get.defaultDialog(
      title: title,
      titleStyle: kBigSizeBoldTextStyle.copyWith(
        color: Colors.purple,
      ),
      middleText: midText,
      titlePadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text(
          'OK',
          style: kNormalSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  static Widget loadingScreen() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          width: 200,
          height: 105,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 12),
                Text(
                  'Loading',
                  style: kNormalSizeTextStyle.copyWith(
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void loading({String message = 'Loading...'}) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.only(top: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            width: 200,
            height: 105,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: kNormalSizeTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  static void showConfirmDialogBox({
    required String message,
    required noFun,
    required String noName,
    required yesFun,
    required String yesName,
  }) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(10),
      middleText: message,
      middleTextStyle: kSmallSizeBoldTextStyle,
      title: 'OOPS',
      titleStyle: kBigSizeBoldTextStyle.copyWith(
        color: Colors.purple,
      ),
      titlePadding: const EdgeInsets.only(top: 10, bottom: 10),
      confirm: ElevatedButton.icon(
        icon: const Icon(Icons.check),
        onPressed: yesFun,
        label: Text(
          yesName,
          style: kSmallSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      cancel: ElevatedButton.icon(
        icon: const Icon(Icons.close),
        onPressed: noFun,
        label: Text(
          noName,
          style: kSmallSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
