// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppThemeSettingsModelAdapter extends TypeAdapter<AppThemeSettingsModel> {
  @override
  final int typeId = 2;

  @override
  AppThemeSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppThemeSettingsModel(
      colorIndex: fields[0] as int,
      variantIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppThemeSettingsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.colorIndex)
      ..writeByte(1)
      ..write(obj.variantIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppThemeSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
