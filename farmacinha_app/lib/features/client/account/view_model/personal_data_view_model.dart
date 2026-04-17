import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalDataViewModel extends ChangeNotifier {
  PersonalDataViewModel() {
    _bindPrefilledClearBehavior(
      focusNode: nameFocusNode,
      controller: nameController,
      isPrefilled: () => _isNamePrefilled,
      setPrefilled: (value) => _isNamePrefilled = value,
    );
    _bindPrefilledClearBehavior(
      focusNode: emailFocusNode,
      controller: emailController,
      isPrefilled: () => _isEmailPrefilled,
      setPrefilled: (value) => _isEmailPrefilled = value,
    );
    _bindPrefilledClearBehavior(
      focusNode: cpfFocusNode,
      controller: cpfController,
      isPrefilled: () => _isCpfPrefilled,
      setPrefilled: (value) => _isCpfPrefilled = value,
    );
    _bindPrefilledClearBehavior(
      focusNode: phoneFocusNode,
      controller: phoneController,
      isPrefilled: () => _isPhonePrefilled,
      setPrefilled: (value) => _isPhonePrefilled = value,
    );
    newPasswordController.addListener(_handlePasswordChange);
  }

  final TextEditingController nameController =
      TextEditingController(text: 'Mariana Silva Oliveira');
  final TextEditingController emailController =
      TextEditingController(text: 'mariana.silva@email.com');
  final TextEditingController cpfController =
      TextEditingController(text: '123.456.789-00');
  final TextEditingController phoneController =
      TextEditingController(text: '(11) 98765-4321');

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode cpfFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  bool _isNamePrefilled = true;
  bool _isEmailPrefilled = true;
  bool _isCpfPrefilled = true;
  bool _isPhonePrefilled = true;

  bool _hideCurrentPassword = true;
  bool _hideNewPassword = true;
  bool _hideConfirmPassword = true;

  bool get isNamePrefilled => _isNamePrefilled;
  bool get isEmailPrefilled => _isEmailPrefilled;
  bool get isCpfPrefilled => _isCpfPrefilled;
  bool get isPhonePrefilled => _isPhonePrefilled;

  bool get hideCurrentPassword => _hideCurrentPassword;
  bool get hideNewPassword => _hideNewPassword;
  bool get hideConfirmPassword => _hideConfirmPassword;

  bool get hasMinLength => newPasswordController.text.length >= 6;
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(newPasswordController.text);
  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(newPasswordController.text);
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(newPasswordController.text);

  List<TextInputFormatter> get cpfInputFormatters => <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        const CpfInputFormatter(),
      ];

  List<TextInputFormatter> get phoneInputFormatters => <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        const PhoneInputFormatter(),
      ];

  void toggleCurrentPasswordVisibility() {
    _hideCurrentPassword = !_hideCurrentPassword;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _hideNewPassword = !_hideNewPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _hideConfirmPassword = !_hideConfirmPassword;
    notifyListeners();
  }

  String savePersonalData() => 'Dados salvos com sucesso!';

  PasswordSaveResult saveNewPassword() {
    final hasAllRules =
        hasMinLength && hasUppercase && hasLowercase && hasNumber;

    if (currentPasswordController.text.isEmpty) {
      return const PasswordSaveResult(message: 'Informe a senha atual.');
    }

    if (!hasAllRules) {
      return const PasswordSaveResult(
        message: 'A nova senha não atende aos requisitos.',
      );
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      return const PasswordSaveResult(
        message: 'A confirmação da senha não confere.',
      );
    }

    return const PasswordSaveResult(
      message: 'Senha alterada com sucesso!',
      shouldCloseSheet: true,
    );
  }

  void resetPasswordForm() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    _hideCurrentPassword = true;
    _hideNewPassword = true;
    _hideConfirmPassword = true;
    notifyListeners();
  }

  void _bindPrefilledClearBehavior({
    required FocusNode focusNode,
    required TextEditingController controller,
    required bool Function() isPrefilled,
    required ValueChanged<bool> setPrefilled,
  }) {
    focusNode.addListener(() {
      if (!focusNode.hasFocus || !isPrefilled()) {
        return;
      }

      controller.clear();
      setPrefilled(false);
      notifyListeners();
    });
  }

  void _handlePasswordChange() {
    notifyListeners();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    cpfFocusNode.dispose();
    phoneFocusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    cpfController.dispose();
    phoneController.dispose();
    currentPasswordController.dispose();
    newPasswordController.removeListener(_handlePasswordChange);
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
    this.shouldCloseSheet = false,
  });
}

class CpfInputFormatter extends TextInputFormatter {
  const CpfInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 11 ? digits.substring(0, 11) : digits;
    final buffer = StringBuffer();

    for (int i = 0; i < limited.length; i++) {
      if (i == 3 || i == 6) {
        buffer.write('.');
      }
      if (i == 9) {
        buffer.write('-');
      }
      buffer.write(limited[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  const PhoneInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 11 ? digits.substring(0, 11) : digits;
    final buffer = StringBuffer();

    for (int i = 0; i < limited.length; i++) {
      if (i == 0) {
        buffer.write('(');
      }
      if (i == 2) {
        buffer.write(') ');
      }
      if (i == 7) {
        buffer.write('-');
      }
      buffer.write(limited[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
