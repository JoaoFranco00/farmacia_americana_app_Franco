import 'package:flutter/material.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view_model/attendant_profile_data_store.dart';

class AttendantPersonalDataViewModel extends ChangeNotifier {
  AttendantPersonalDataViewModel({AttendantProfileDataStore? profileStore})
    : _profileStore = profileStore ?? AttendantProfileDataStore.instance {
    final profile = _profileStore.data;

    nameController = TextEditingController(text: profile.fullName);
    emailController = TextEditingController(text: profile.email);
    cpfController = TextEditingController(text: profile.cpf);
    phoneController = TextEditingController(text: profile.phone);

    _nameFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _nameFocusNode,
        controller: nameController,
        isPrefilled: _isNamePrefilled,
        onChanged: (value) => _isNamePrefilled = value,
      ),
    );
    _emailFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _emailFocusNode,
        controller: emailController,
        isPrefilled: _isEmailPrefilled,
        onChanged: (value) => _isEmailPrefilled = value,
      ),
    );
    _cpfFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _cpfFocusNode,
        controller: cpfController,
        isPrefilled: _isCpfPrefilled,
        onChanged: (value) => _isCpfPrefilled = value,
      ),
    );
    _phoneFocusNode.addListener(
      () => _clearPrefilledOnFocus(
        focusNode: _phoneFocusNode,
        controller: phoneController,
        isPrefilled: _isPhonePrefilled,
        onChanged: (value) => _isPhonePrefilled = value,
      ),
    );
  }

  final AttendantProfileDataStore _profileStore;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController cpfController;
  late final TextEditingController phoneController;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _cpfFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  bool _isNamePrefilled = true;
  bool _isEmailPrefilled = true;
  bool _isCpfPrefilled = true;
  bool _isPhonePrefilled = true;

  FocusNode get nameFocusNode => _nameFocusNode;
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get cpfFocusNode => _cpfFocusNode;
  FocusNode get phoneFocusNode => _phoneFocusNode;

  bool get isNamePrefilled => _isNamePrefilled;
  bool get isEmailPrefilled => _isEmailPrefilled;
  bool get isCpfPrefilled => _isCpfPrefilled;
  bool get isPhonePrefilled => _isPhonePrefilled;

  void savePersonalData() {
    _profileStore.updatePersonalData(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      cpf: cpfController.text.trim(),
      phone: phoneController.text.trim(),
    );
  }

  void _clearPrefilledOnFocus({
    required FocusNode focusNode,
    required TextEditingController controller,
    required bool isPrefilled,
    required ValueChanged<bool> onChanged,
  }) {
    if (!focusNode.hasFocus || !isPrefilled) return;
    controller.clear();
    onChanged(false);
    notifyListeners();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _cpfFocusNode.dispose();
    _phoneFocusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    cpfController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

class ChangePasswordViewModel extends ChangeNotifier {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _hideCurrent = true;
  bool _hideNew = true;
  bool _hideConfirm = true;

  bool get hideCurrent => _hideCurrent;
  bool get hideNew => _hideNew;
  bool get hideConfirm => _hideConfirm;

  bool get hasMinLength => newPasswordController.text.length >= 6;
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(newPasswordController.text);
  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(newPasswordController.text);
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(newPasswordController.text);

  ChangePasswordViewModel() {
    newPasswordController.addListener(notifyListeners);
  }

  void toggleCurrentVisibility() {
    _hideCurrent = !_hideCurrent;
    notifyListeners();
  }

  void toggleNewVisibility() {
    _hideNew = !_hideNew;
    notifyListeners();
  }

  void toggleConfirmVisibility() {
    _hideConfirm = !_hideConfirm;
    notifyListeners();
  }

  PasswordSaveResult validate() {
    final hasAllRules = hasMinLength && hasUppercase && hasLowercase && hasNumber;

    if (currentPasswordController.text.isEmpty) {
      return const PasswordSaveResult(
        message: 'Informe a senha atual.',
        shouldCloseSheet: false,
      );
    }

    if (!hasAllRules) {
      return const PasswordSaveResult(
        message: 'A nova senha não atende aos requisitos.',
        shouldCloseSheet: false,
      );
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      return const PasswordSaveResult(
        message: 'A confirmação da senha não confere.',
        shouldCloseSheet: false,
      );
    }

    return const PasswordSaveResult(
      message: 'Senha alterada com sucesso!',
      shouldCloseSheet: true,
    );
  }

  @override
  void dispose() {
    newPasswordController.removeListener(notifyListeners);
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

class PasswordSaveResult {
  final String message;
  final bool shouldCloseSheet;

  const PasswordSaveResult({
    required this.message,
    required this.shouldCloseSheet,
  });
}
