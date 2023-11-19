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
          return Container(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      amostra!.explicacoesComplementares[index].nome,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    subtitle: Text(
                      amostra!.explicacoesComplementares[index].descricao,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(10.0),
                      minScale: 0.1,
                      maxScale: 5,
                      child: Image.network(
                        amostra!.explicacoesComplementares[index].URL,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
