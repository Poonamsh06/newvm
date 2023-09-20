import 'package:VMedia/controllers/Auth/email_controller.dart';
import 'package:VMedia/controllers/Auth/google_auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/userModel.dart';
import '../../utilities/constants.dart';
import '../../utilities/myDialogBox.dart';
import '../../views/home.dart';

class PhoneController {
  String verificationIdReceived = '';
  UserModel? userModel;

  Future<void> verifyWithPhoneCredentials(String number) async {
    auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // log('-----------login success fullly-------------------');
      },
      verificationFailed: (FirebaseAuthException exception) async {
        MyDialogBox.showDefaultDialog(
          exception.code.toString(),
          exception.message.toString(),
        );
        // log('-----------exception-----------${exception.code}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationIdReceived = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        verificationIdReceived = verificationId;
      },
      timeout: const Duration(seconds: 40),
    );
  }

  void verifyPhoneNumberWithOtp({
    required String otp,
  }) async {
    if (otp == '' || otp.toString().length != 6) {
      return;
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdReceived,
      smsCode: otp,
    );
    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user == null) return;

      final beforeUserModel =
          await GoogleAuthController.checkWhetherUserIsPresent(
              userCredential.user!);
      if (beforeUserModel == null) {
        userModel = UserModel(
          uid: userCredential.user!.uid,
          name: '',
          profilepic: '',
          email: '',
          phone: userCredential.user!.phoneNumber,
          aboutme: '',
          followers: 0,
          following: 0,
          success: true,
          isprofilecomplete: false,
        );

        await EmailController.uploadUserDataToFirestore(
          userCredential.user,
          userModel!,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setStringList('listOfMyModel', userModel!.toList());
      } else {
        await EmailController.uploadUserDataToFirestore(
          userCredential.user,
          beforeUserModel,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setStringList('listOfMyModel', beforeUserModel.toList());
      }

      Get.offAll(Home(user: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      Get.back();
      MyDialogBox.showDefaultDialog(
        e.code == 'invalid-verification-code' ? 'invalid otp' : e.code,
        e.code == 'invalid-verification-code'
            ? 'Otp you have entered is invalid.Please check once more and try again.'
            : e.message.toString(),
      );
    } catch (e) {
      Get.back();
      MyDialogBox.showDefaultDialog('OOPS', e.toString());
    }
  }
}
