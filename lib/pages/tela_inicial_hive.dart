import 'package:calculadora_imc_hive/pages/tela_login.dart';
import 'package:calculadora_imc_hive/utils/utils.dart';
import 'package:flutter/material.dart';

import '../model/pessoa_model_hive.dart';
import '../repository/pessoa_repository.dart';

class MyHomePageHive extends StatefulWidget {
  const MyHomePageHive({
    super.key,
  });

  @override
  State<MyHomePageHive> createState() => _MyHomePageHiveState();
}

enum Genero { masculino, feminino }

class _MyHomePageHiveState extends State<MyHomePageHive> {
  late PessoaRepository pessoaRepository;
  var pessoaModel = PessoaModelHive();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Genero generoView = Genero.masculino;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    pessoaRepository = await PessoaRepository.carregar();
    pessoaModel = pessoaRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Calculadora IMC ",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(13, 13, 13, 0.965),
      ),
      body: Container(
        color: const Color.fromRGBO(13, 13, 13, 0.965),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton(
                  showSelectedIcon: false,
                  style: SegmentedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    selectedForegroundColor: Colors.white,
                    selectedBackgroundColor:
                        const Color.fromRGBO(255, 0, 0, 10),
                  ),
                  segments: const <ButtonSegment<Genero>>[
                    ButtonSegment<Genero>(
                        value: Genero.masculino,
                        label: Text(
                          "Masculino",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                    ButtonSegment<Genero>(
                      value: Genero.feminino,
                      label: Text(
                        "Feminino",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                  selected: <Genero>{generoView},
                  onSelectionChanged: (Set<Genero> newGenero) {
                    setState(() {
                      generoView = newGenero.first;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: Card(
                  color: const Color.fromRGBO(44, 44, 44, 0.996),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        const Utils(
                          texto: "Altura",
                        ),
                        Text(
                          "${pessoaModel.altura?.toStringAsFixed(2) ?? 0} m",
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Slider(
                            thumbColor: const Color.fromRGBO(255, 0, 0, 10),
                            activeColor: Colors.white,
                            min: 0,
                            max: 2.5,
                            value: pessoaModel.altura ?? 0,
                            onChanged: (double value) {
                              setState(() {
                                pessoaModel.altura = value;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Card(
                        color: const Color.fromRGBO(44, 44, 44, 0.996),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              const Utils(
                                texto: "Peso",
                              ),
                              Text(
                                "${pessoaModel.peso?.toStringAsFixed(1) ?? 0} Kg",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Slider(
                                  thumbColor:
                                      const Color.fromRGBO(255, 0, 0, 10),
                                  activeColor: Colors.white,
                                  min: 0,
                                  max: 150,
                                  value: pessoaModel.peso ?? 0,
                                  onChanged: (double value) {
                                    setState(() {
                                      pessoaModel.peso = value;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: const Color.fromRGBO(44, 44, 44, 0.996),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              const Utils(
                                texto: "Idade",
                              ),
                              Text(
                                "${pessoaModel.idade.toString()} anos",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: TextButton(
                                        style: ButtonStyle(
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    const Color.fromRGBO(
                                                        0, 0, 0, 0.922))),
                                        onPressed: () {
                                          if (pessoaModel.idade <= 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Idade não pode ser menor que 0")));
                                            return;
                                          }
                                          setState(() {
                                            pessoaModel.diminuirIdade();
                                          });
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: TextButton(
                                        style: ButtonStyle(
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    const Color.fromRGBO(
                                                        0, 0, 0, 19))),
                                        onPressed: () {
                                          setState(() {
                                            pessoaModel.aumentarIdade();
                                          });
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              )
                              /*Slider(
                                  thumbColor: Colors.red,
                                  activeColor: Colors.white,
                                  min: 0,
                                  max: 100,
                                  value: idadeEscolhida,
                                  onChanged: (double value) {
                                    setState(() {
                                      idadeEscolhida = value;
                                    });
                                  })*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(255, 0, 0, 10))),
                    onPressed: () async {
                      pessoaModel.resultado = pessoaRepository.calcularIMC(
                          pessoaModel.altura!, pessoaModel.peso!);
                      pessoaModel.frase = pessoaRepository.frase;

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(255, 0, 0, 10),
                            ),
                          );
                        },
                      );

                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context).pop();

                        showDialog(
                            context: context,
                            builder: (BuildContext bc) {
                              return AlertDialog(
                                elevation: 18,
                                shadowColor:
                                    const Color.fromRGBO(255, 0, 0, 10),
                                backgroundColor:
                                    const Color.fromRGBO(44, 44, 44, 0.996),
                                title: const Text(
                                  "Resultado",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                content: SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Idade: ${pessoaModel.idade} anos ",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "Peso: ${pessoaModel.peso!.toStringAsFixed(1)} Kg ",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Altura: ${pessoaModel.altura!.toStringAsFixed(2)} m",
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "Seu IMC é de: ${pessoaModel.resultado!.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${pessoaModel.frase}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancelar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17))),
                                  TextButton(
                                      style: ButtonStyle(
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  const Color.fromRGBO(
                                                      255, 0, 0, 10))),
                                      onPressed: () async {
                                        await pessoaRepository.adicionar(
                                            PessoaModelHive.criar(
                                                pessoaModel.peso,
                                                pessoaModel.altura,
                                                pessoaModel.idade,
                                                pessoaModel.resultado,
                                                pessoaModel.frase));

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TelaLogin(initialPage: 1),
                                          ),
                                        );
                                        carregarDados();
                                        setState(() {});
                                      },
                                      child: const Text(
                                        "Salvar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ))
                                ],
                              );
                            });
                      });
                    },
                    child: const Utils(texto: "Calcular IMC")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
