import 'package:flutter/material.dart';
import '../models/amostra.dart';

class ComparacaoAmostras extends StatelessWidget {
  const ComparacaoAmostras(
      {Key? key, required this.amostra, required this.amostraSelecionada})
      : super(key: key);

  final AmostraModel? amostra;
  final AmostraModel? amostraSelecionada;
  @override
  Widget build(BuildContext context) {
    if (amostra == null || amostraSelecionada == null) {
      return const SizedBox
          .shrink(); // Return an empty widget if amostra is null
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparação de Amostras"),
      ),
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.lightBlueAccent,
                        width: 2.0), // Add border properties here
                  ),
                  child: InteractiveViewer(
                    child: Image.network(
                      amostra!.imagens.first.URL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.lightBlueAccent,
                        width: 2.0), // Add border properties here
                  ),
                  child: InteractiveViewer(
                    child: Image.network(
                      amostraSelecionada!.imagens.first.URL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${amostra!.nome} - ${amostra!.classificacao.name}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.lightBlueAccent),
          ),
        ],
      ),
    );
  }
}
