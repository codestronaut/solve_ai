import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';

@immutable
sealed class Attachment {
  const Attachment({required this.name});
  final String name;

  static String _mimeType(XFile file) =>
      file.mimeType ?? lookupMimeType(file.path) ?? 'application/octet-stream';

  static bool _isImage(String mimeType) =>
      mimeType.toLowerCase().startsWith('image/');
}

@immutable
final class FileAttachment extends Attachment {
  const FileAttachment({
    required super.name,
    required this.mimeType,
    required this.bytes,
  });

  final String mimeType;
  final Uint8List bytes;

  factory FileAttachment.fileOrImage({
    required String name,
    required String mimeType,
    required Uint8List bytes,
  }) =>
      Attachment._isImage(mimeType)
          ? ImageFileAttachment(name: name, mimeType: mimeType, bytes: bytes)
          : FileAttachment(name: name, mimeType: mimeType, bytes: bytes);

  @override
  String toString() => 'AttachmentFile('
      'name: $name, '
      'mimeType: $mimeType, '
      'bytes: ${bytes.length} bytes'
      ')';

  static Future<FileAttachment> fromFile(XFile file) async =>
      FileAttachment.fileOrImage(
        name: file.name,
        mimeType: Attachment._mimeType(file),
        bytes: await file.readAsBytes(),
      );
}

@immutable
final class ImageFileAttachment extends FileAttachment {
  const ImageFileAttachment({
    required super.name,
    required super.mimeType,
    required super.bytes,
  });

  @override
  String toString() => 'ImageFileAttachment('
      'name: $name, '
      'mimeType: $mimeType, '
      'bytes: ${bytes.length} bytes'
      ')';

  static Future<ImageFileAttachment> fromFile(XFile file) async {
    final mimeType = Attachment._mimeType(file);
    if (!Attachment._isImage(mimeType)) {
      throw Exception('Not an image: $mimeType');
    }

    return ImageFileAttachment(
      name: file.name,
      mimeType: mimeType,
      bytes: await file.readAsBytes(),
    );
  }
}

@immutable
final class LinkAttachment extends Attachment {
  LinkAttachment({required super.name, required this.url})
      : mimeType = lookupMimeType(url.path) ?? 'application/octet-stream';

  final Uri url;
  final String mimeType;

  @override
  String toString() => 'LinkAttachment('
      'name: $name, '
      'url: $url, '
      'mimeType: $mimeType'
      ')';
}
