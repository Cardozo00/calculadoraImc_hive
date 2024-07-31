// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PessoaModelHiveAdapter extends TypeAdapter<PessoaModelHive> {
  @override
  final int typeId = 0;

  @override
  PessoaModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PessoaModelHive()
      ..peso = fields[0] as double?
      ..altura = fields[1] as double?
      ..idade = fields[2] as int
      ..resultado = fields[3] as double?
      ..frase = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, PessoaModelHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.altura)
      ..writeByte(2)
      ..write(obj.idade)
      ..writeByte(3)
      ..write(obj.resultado)
      ..writeByte(4)
      ..write(obj.frase);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PessoaModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
