import 'package:calculadora_imc_hive/model/pessoa_model_hive.dart';
import 'package:calculadora_imc_hive/repository/pessoa_repository.dart';
import 'package:flutter/material.dart';

class Resultados extends StatefulWidget {
  const Resultados({super.key});

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  late PessoaRepository pessoaRepository;
  var pessoaModel = PessoaModelHive();
  var _resultados = <PessoaModelHive>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    pessoaRepository = await PessoaRepository.carregar();
    _resultados = pessoaRepository.obterDadosList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(13, 13, 13, 0.965),
        title: const Text(
          "Resultados",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: const Color.fromRGBO(13, 13, 13, 0.965),
        child: ListView.builder(
            itemCount: _resultados.length,
            itemBuilder: (BuildContext bc, int index) {
              var results = _resultados[index];
              return Dismissible(
                key: Key(results.altura!.toString()),
                onDismissed: (DismissDirection dismissDirection) async {
                  pessoaRepository.excluir(results);
                  carregarDados();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    color: const Color.fromRGBO(44, 44, 44, 0.996),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Idade: ${results.idade} anos ",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Peso: ${results.peso?.toStringAsFixed(1) ?? 0} Kg ",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Altura: ${results.altura?.toStringAsFixed(2) ?? 0} m",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Seu IMC é de: ${results.resultado?.toStringAsFixed(2) ?? 0}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${results.frase}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
