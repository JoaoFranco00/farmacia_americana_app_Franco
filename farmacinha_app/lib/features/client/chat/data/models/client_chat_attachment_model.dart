enum ClientAttachmentType { photo, document }

class ClientChatAttachment {
  final String id;
  final ClientAttachmentType type;
  final String fileName;
  final String fileDetails;
  final String? filePath;
  final String? fileExtension;
  final int? sizeInBytes;

  const ClientChatAttachment({
    required this.id,
    required this.type,
    required this.fileName,
    required this.fileDetails,
    this.filePath,
    this.fileExtension,
    this.sizeInBytes,
  });
}
