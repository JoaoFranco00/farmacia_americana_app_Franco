import 'package:flutter/material.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/mocks/mock_attendant_recent_clientes.dart';
import 'package:farmacia_app/features/attendant/home_attendant/data/models/attendant_search_client_model.dart';

class AttendantChatViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  final List<AttendantSearchClient> _allClients =
      MockAttendantRecentClients.getClients();
  List<AttendantSearchClient> _filteredClients = [];
  String? _selectedClientId;

  List<AttendantSearchClient> get clients => _filteredClients;
  String? get selectedClientId => _selectedClientId;

  AttendantChatViewModel() {
    _filteredClients = List<AttendantSearchClient>.from(_allClients);
    searchController.addListener(_applyFilters);
  }

  void selectClient(String clientId) {
    _selectedClientId = clientId;
    notifyListeners();
  }

  void _applyFilters() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      _filteredClients = List<AttendantSearchClient>.from(_allClients);
      notifyListeners();
      return;
    }

    _filteredClients = _allClients.where((client) {
      return client.name.toLowerCase().contains(query) ||
          client.cpf.toLowerCase().contains(query);
    }).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
