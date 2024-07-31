import 'package:flutter/material.dart';

class Utils extends StatelessWidget {
  final String texto;
  const Utils({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            texto,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
