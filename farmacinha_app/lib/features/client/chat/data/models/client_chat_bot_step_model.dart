import 'package:farmacia_app/features/client/chat/data/models/client_chat_option_model.dart';

class ClientChatBotStep {
  final String id;
  final String message;
  final List<ClientChatOption> options;
  final bool enablesManualInput;
  final bool startsHumanAttendance;

  const ClientChatBotStep({
    required this.id,
    required this.message,
    required this.options,
    this.enablesManualInput = false,
    this.startsHumanAttendance = false,
  });
}
