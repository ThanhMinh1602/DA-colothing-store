import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';
import 'package:male_clothing_store/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';

class ProfileController extends BaseController {
  final Rxn<UserModel> user = Rxn<UserModel>();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  StreamSubscription? userSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      userSubscription = _userService.getUserByIdStream(uid).listen((u) {
        user.value = u;
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    final confirm = await CustomDialog.showConfirmDialog(
      context: context,
      title: "Đăng xuất",
      message: "Bạn chắc chắn muốn đăng xuất khỏi tài khoản?",
      confirmText: "Đăng xuất",
      confirmColor: Colors.red,
    );
    if (confirm == true) {
      showLoading(message: "Đang đăng xuất...");
      await _authService.signOut();
      hideLoading();
      goOffAll(AppRoutes.login);
      await showSuccess(message: "Bạn đã đăng xuất khỏi tài khoản!");
    }
  }

  @override
  void onClose() {
    userSubscription?.cancel();
    super.onClose();
  }
}
