import 'package:calculadora_imc_hive/pages/resultados.dart';
import 'package:calculadora_imc_hive/pages/tela_inicial_hive.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  final int initialPage;
  const TelaLogin({super.key, this.initialPage = 0});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPage = 0;

  @override
  void initState() {
    super.initState();
    posicaoPage = widget.initialPage;
    controller = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                posicaoPage = value;
              });
            },
            children: const [MyHomePageHive(), Resultados()],
          )),
          BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  posicaoPage = value;
                });
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPage,
              backgroundColor: const Color.fromRGBO(13, 13, 13, 0.965),
              selectedItemColor: const Color.fromRGBO(255, 0, 0, 10),
              unselectedItemColor: Colors.white,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.calculate), label: "Calculadora"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "Ressultados")
              ]),
        ],
      ),
    );
  }
}
