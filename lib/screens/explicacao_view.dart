import 'package:flutter/material.dart';
import '../models/amostra.dart';

class ExplicacaoComplementar extends StatelessWidget {
  const ExplicacaoComplementar({Key? key, required this.amostra})
      : super(key: key);

  final AmostraModel? amostra;
  @override
  Widget build(BuildContext context) {
    if (amostra == null) {
      return const SizedBox
          .shrink(); // Return an empty widget if amostra is null
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explicações Complementares"),
      ),
      body: ListView.builder(
        itemCount: amostra!.explicacoesComplementares.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    amostra!.explicacoesComplementares[index].nome,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  subtitle: Text(
                    amostra!.explicacoesComplementares[index].descricao,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
