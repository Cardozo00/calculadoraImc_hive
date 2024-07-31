import 'package:hive/hive.dart';

part 'pessoa_model_hive.g.dart';

@HiveType(typeId: 0)
class PessoaModelHive extends HiveObject {
  @HiveField(0)
  double? peso;

  @HiveField(1)
  double? altura;

  @HiveField(2)
  int idade = 0;

  @HiveField(3)
  double? resultado;

  @HiveField(4)
  String? frase;

  PessoaModelHive.criar(
      this.peso, this.altura, this.idade, this.resultado, this.frase);

  PessoaModelHive();

  void aumentarIdade() {
    idade++;
  }

  void diminuirIdade() {
    idade--;
  }
}
