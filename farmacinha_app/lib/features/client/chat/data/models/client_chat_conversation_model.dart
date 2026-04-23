import 'package:farmacia_app/features/client/chat/data/models/client_chat_message_model.dart';

class ClientChatConversation {
  final String pharmacyName;
  final String statusLabel;
  final bool isSupportTyping;
  final List<ClientChatMessage> messages;

  const ClientChatConversation({
    required this.pharmacyName,
    required this.statusLabel,
    required this.messages,
    this.isSupportTyping = false,
  });

  ClientChatConversation copyWith({
    String? pharmacyName,
    String? statusLabel,
    bool? isSupportTyping,
    List<ClientChatMessage>? messages,
  }) {
    return ClientChatConversation(
      pharmacyName: pharmacyName ?? this.pharmacyName,
      statusLabel: statusLabel ?? this.statusLabel,
      isSupportTyping: isSupportTyping ?? this.isSupportTyping,
      messages: messages ?? this.messages,
    );
  }
}
