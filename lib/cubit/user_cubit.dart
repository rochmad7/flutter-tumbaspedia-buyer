import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tumbaspedia/models/models.dart';
import 'package:tumbaspedia/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:tumbaspedia/shared/shared.dart';

part '../state/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> userInitial() async {
    emit(UserInitial());
  }

  Future<void> signIn(
      String email, String password, bool initialLogin) async {
    ApiReturnValue<User> result =
        await UserServices.signIn(email, password);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      if (initialLogin) {
        emit(UserInitial());
      } else {
        emit(UserLoadingFailed(result.message, result.error));
      }
    }
  }

  Future<void> signUp(User user, String password, {File pictureFile}) async {
    ApiReturnValue<User> result =
        await UserServices.signUp(user, password, pictureFile: pictureFile);

    if (result.error == null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

  Future<void> forgotPassword(String email) async {
    ApiReturnValue<bool> result = await UserServices.forgotPassword(email);

    if (result.error == null) {
      emit(UserForgotPassword(result.message, email));
    } else {
      emit(UserForgotPasswordFailed(result.message, result.error));
    }
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String confPassword) async {
    ApiReturnValue<User> result = await UserServices.changePassword(
        oldPassword, newPassword, confPassword);

    if (result.error == null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

  Future<void> getMyProfile(int id) async {
    ApiReturnValue<User> result = await UserServices.getMyProfile(id);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

  Future<void> update(User user, int id) async {
    ApiReturnValue<User> result = await UserServices.update(user, id);
    if (result.error == null && !result.isException) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

  Future<void> uploadProfilePicture(File pictureFile) async {
    ApiReturnValue<String> result =
        await UserServices.uploadProfilePicture(pictureFile);

    if (result.value != null) {
      emit(UserLoaded((state as UserLoaded)
          .user
          .copyWith(picturePath: baseURLAPI + "storage/" + result.value)));
    }
  }

  Future<void> logOut() async {
    ApiReturnValue<User> result = await UserServices.logOut();

    if (result.isException == false) {
      emit(UserInitial());
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }
}
