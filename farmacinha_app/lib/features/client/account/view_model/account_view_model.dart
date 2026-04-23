import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/features/auth/data/models/user_model.dart';
import 'package:farmacia_app/features/auth/data/mocks/mock_users.dart';
import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';

class AccountViewModel extends ChangeNotifier {
  final AuthSessionViewModel _authSession;
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isGuest => _authSession.isGuest || !_authSession.isAuthenticated;

  // Pontos de fidelidade (mock)
  int get loyaltyPoints => 450;
  String get loyaltyTier => 'Cliente Gold';

  AccountViewModel({AuthSessionViewModel? authSession})
      : _authSession = authSession ?? AuthSessionViewModel.instance {
    _authSession.addListener(_syncWithSession);
    _loadUser();
  }

  void _loadUser() {
    if (isGuest) {
      _currentUser = null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      _currentUser = _authSession.currentUser ??
          MockUsers.getUsers().firstWhere(
            (u) => u.role == UserRole.cliente,
          );
      _isLoading = false;
      notifyListeners();
    });
  }

  void _syncWithSession() {
    if (isGuest) {
      _currentUser = null;
    } else {
      _currentUser = _authSession.currentUser;
    }
    notifyListeners();
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.register);
  }

  void logout(BuildContext context) {
    _authSession.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  void dispose() {
    _authSession.removeListener(_syncWithSession);
    super.dispose();
  }
}
