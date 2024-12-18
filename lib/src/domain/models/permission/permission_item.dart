import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_item.freezed.dart';

@freezed
class PermissionItem with _$PermissionItem {
  const PermissionItem._();
  const factory PermissionItem({
    required String iconPath,
    required String title,
    required String description,
  }) = _PermissionItem;
}
