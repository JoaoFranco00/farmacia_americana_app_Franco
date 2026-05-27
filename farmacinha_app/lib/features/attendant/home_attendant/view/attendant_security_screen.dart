import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view/utils/attendant_navigation.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view_model/attendant_personal_viewl_model.dart';

class AttendantSecurityScreen extends StatefulWidget {
  const AttendantSecurityScreen({super.key});

  @override
  State<AttendantSecurityScreen> createState() =>
      _AttendantSecurityScreenState();
}

class _AttendantSecurityScreenState extends State<AttendantSecurityScreen> {
  late final ChangePasswordViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ChangePasswordViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return PopScope<Object?>(
          canPop: Navigator.of(context).canPop(),
          onPopInvokedWithResult: (didPop, result) =>
              handleAttendantBack(context, didPop),
          child: Scaffold(
            backgroundColor: const Color(0xFFFFFAF7),
            appBar: AppBar(
              backgroundColor: const Color(0xFFFFFAF7),
              surfaceTintColor: const Color(0xFFFFFAF7),
              elevation: 0,
              leading: IconButton(
                onPressed: () => popOrGoToAttendantHome(context),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Pallete.primaryRed,
                ),
              ),
              titleSpacing: 0,
              title: const Text(
                'Seguran\u00e7a e Senha',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEDEE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.lock_reset_rounded,
                                  color: Pallete.primaryRed,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Alterar Senha',
                                style: TextStyle(
                                  color: Color(0xFF2A2525),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          _buildFieldLabel('Senha Atual'),
                          _PasswordField(
                            controller: _viewModel.currentPasswordController,
                            obscureText: _viewModel.hideCurrent,
                            onToggleVisibility:
                                _viewModel.toggleCurrentVisibility,
                          ),
                          const SizedBox(height: 18),
                          _buildFieldLabel('Nova Senha'),
                          _PasswordField(
                            controller: _viewModel.newPasswordController,
                            obscureText: _viewModel.hideNew,
                            onToggleVisibility: _viewModel.toggleNewVisibility,
                          ),
                          const SizedBox(height: 18),
                          _buildFieldLabel('Confirmar Senha'),
                          _PasswordField(
                            controller: _viewModel.confirmPasswordController,
                            obscureText: _viewModel.hideConfirm,
                            onToggleVisibility:
                                _viewModel.toggleConfirmVisibility,
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'A nova senha deve ter pelo menos 6 caracteres, com letra mai\u00fascula, min\u00fascula e n\u00famero.',
                            style: TextStyle(
                              color: Color(0xFF8C7A78),
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _updateCredentials,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Pallete.primaryRed,
                                foregroundColor: Colors.white,
                                elevation: 6,
                                shadowColor: Pallete.primaryRed.withOpacity(
                                  0.24,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Atualizar Credenciais',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Mantenha suas credenciais em sigilo e, em caso de d\u00favidas, entre em contato com o suporte t\u00e9cnico da rede.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9A8B89),
                          fontSize: 13,
                          height: 1.55,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF7E6A67),
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Future<void> _updateCredentials() async {
    final result = _viewModel.validate();

    if (!mounted) return;

    if (!result.shouldCloseSheet) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(result.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Pallete.primaryRed),
            ),
          ),
        ],
      ),
    );

    if (!mounted) return;
    popOrGoToAttendantHome(context);
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  const _PasswordField({
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF6F4F4),
        hintText: '********',
        hintStyle: const TextStyle(
          color: Color(0xFF9E9493),
          letterSpacing: 2,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Pallete.primaryRed, width: 1.2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xFF9A9A9A),
          ),
        ),
      ),
    );
  }
}
