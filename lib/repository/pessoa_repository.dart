import 'package:hive/hive.dart';

import '../model/pessoa_model_hive.dart';

class PessoaRepository {
  static late Box box;
  var pessoaModel = PessoaModelHive();

  PessoaRepository._criar();

  static Future<PessoaRepository> carregar() async {
    if (Hive.isBoxOpen('pessoaModel1')) {
      box = Hive.box('pessoaModel1');
    } else {
      box = await Hive.openBox('pessoaModel1');
    }
    return PessoaRepository._criar();
  }

  salvar(PessoaModelHive pessoaModel) {
    box.put('pessoaModel1', pessoaModel);
  }

  adicionar(PessoaModelHive pessoaModel) {
    box.add(pessoaModel);
  }

  alterar(PessoaModelHive pessoaModel) {
    pessoaModel.save();
  }

  excluir(PessoaModelHive pessoaModel) {
    pessoaModel.delete();
  }

  PessoaModelHive obterDados() {
    var pessoaModel = box.get('pessoaModel1');

    if (pessoaModel == null) {
      return PessoaModelHive();
    }

    return pessoaModel;
  }

  List<PessoaModelHive> obterDadosList() {
    return box.values.cast<PessoaModelHive>().toList();
  }

  String frase = "";

  double calcularIMC(double altura, double peso) {
    pessoaModel.resultado = peso / (altura * altura);
    if (pessoaModel.resultado! < 16) {
      frase = ("Você está com margreza grave");
    }
    if (pessoaModel.resultado! >= 16 && pessoaModel.resultado! < 17) {
      frase = ("Você está co margreza moderada");
    }
    if (pessoaModel.resultado! >= 17 && pessoaModel.resultado! < 18.5) {
      frase = ("você está co, margreza leve");
    }
    if (pessoaModel.resultado! >= 18.5 && pessoaModel.resultado! < 25) {
      frase = ("Você está saudável");
    }
    if (pessoaModel.resultado! >= 25 && pessoaModel.resultado! < 30) {
      frase = ("Você está com obesidade grau 1");
    }
    if (pessoaModel.resultado! >= 30 && pessoaModel.resultado! < 40) {
      frase = ("Você está com obesidade grau 2");
    }
    if (pessoaModel.resultado! >= 40) {
      frase = ("Você está com obesidade grau 3");
    }

    return pessoaModel.resultado!;
  }
}
