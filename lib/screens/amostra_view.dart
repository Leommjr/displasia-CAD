import 'package:flutter/material.dart';
import '../models/amostra.dart';
import './explicacao_view.dart';
import './comparacao_view.dart';
import 'package:auto_size_text/auto_size_text.dart';

String ExplicacaoRoute = '/explicacao';
String ComparacaoRoute = '/comparacao';

class Amostra extends StatefulWidget {
  final Color _color;

  const Amostra(this._color);

  @override
  State<Amostra> createState() => _AmostraState(_color);
}

class _AmostraState extends State<Amostra> {
  final Color _color;

  _AmostraState(this._color);

  var _amostraSelecionada;
  var _amostraSelecionadaIndex = 0;

  @override
  Widget build(BuildContext context) {
    final amostras = AmostraModel.getAmostras();
    final secundaryColor = Colors.lightBlueAccent.withOpacity(0.3);
    final amostra1 = amostras.first; //amostra selecionada
    var amostrasSimilares = amostra1.amostrasSimilares
        .map((id) => amostras.firstWhere((amostra) => amostra.id == id))
        .toList();
    amostrasSimilares = amostrasSimilares.isNotEmpty ? amostrasSimilares : [];
    _amostraSelecionada = amostrasSimilares.isNotEmpty
        ? amostrasSimilares[_amostraSelecionadaIndex]
        : null;

    return Column(
      children: [
        Expanded(
          child: AmostraDetails(
            color: _color,
            amostra: amostra1,
          ),
        ),
        const Text("Amostras Similares",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.lightBlueAccent)),
        ElevatedButton(
          child: const Text('Comparar amostras'),
          onPressed: () {
            Navigator.of(context).push<void>(_createRoute(
                amostra: amostra1,
                amostraSelecionada: _amostraSelecionada,
                routeName: ComparacaoRoute));
          },
        ),
        Row(
          children: amostrasSimilares.asMap().entries.map((entry) {
            final index = entry.key;
            final amostra = entry.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _amostraSelecionadaIndex = index;
                });
              },
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300), // Animation duration
                color:
                    _amostraSelecionadaIndex == index ? secundaryColor : _color,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("${amostra.classificacao.name} - ${amostra.nome}"),
                ),
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: AmostraDetails(
            color: secundaryColor,
            amostra: _amostraSelecionada,
          ),
        ),
      ],
    );
  }
}

class AmostraDetails extends StatelessWidget {
  const AmostraDetails({
    Key? key,
    required this.color,
    required this.amostra,
  }) : super(key: key);

  final Color color;
  final AmostraModel? amostra;

  @override
  Widget build(BuildContext context) {
    if (amostra == null) {
      return const SizedBox
          .shrink(); // Return an empty widget if amostra is null
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // For larger screens (tablets), use a Row
          return ColoredBox(
            color: color,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(10.0),
                      minScale: 0.1,
                      maxScale: 5,
                      child: Image.network(
                        amostra!.imagens.first.URL,
                        width: constraints.maxWidth * 0.35,
                        height: constraints.maxHeight * 0.35,
                        fit: BoxFit.contain,
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(amostra!.nome,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Classificação: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 30),
                        Text(amostra!.classificacao.name,
                            textAlign: TextAlign.center),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Confiança: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 30),
                        Text(amostra!.confianca.name),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text("Porque: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      amostra!.explicacaoPrincipal.descricao,
                      maxLines: 16,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        child: const Text('Explicações Complementares'),
                        onPressed: () {
                          Navigator.of(context).push<void>(_createRoute(
                              amostra: amostra!, routeName: ExplicacaoRoute));
                        },
                      ),
                    ),
                    SizedBox(height: 350),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        child: const Text('Reclassificar'),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomBottomSheet(); // Use your custom bottom sheet widget
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // For smaller screens (phones), use a Column
          return ColoredBox(
            color: color,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(10.0),
                    minScale: 0.1,
                    maxScale: 5,
                    child: Image.network(
                      amostra!.imagens.first.URL,
                      width: constraints.maxWidth * 0.35,
                      height: constraints.maxHeight * 0.35,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(amostra!.nome,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.left),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Classificação: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 30),
                    Text(amostra!.classificacao.name,
                        textAlign: TextAlign.center),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Confiança: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 30),
                    Text(amostra!.confianca.name),
                  ],
                ),
                SizedBox(height: 10),
                Text("Porque: ", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                AutoSizeText(
                  amostra!.explicacaoPrincipal.descricao,
                  maxLines: 16,
                ),
                ElevatedButton(
                  child: const Text('Explicações Complementares'),
                  onPressed: () {
                    Navigator.of(context).push<void>(_createRoute(
                        amostra: amostra!, routeName: ExplicacaoRoute));
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Reclassificar'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomBottomSheet(); // Use your custom bottom sheet widget
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Route _createRoute(
    {AmostraModel? amostra,
    AmostraModel? amostraSelecionada,
    String? routeName}) {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) {
      switch (routeName) {
        case "/explicacao":
          return ExplicacaoComplementar(amostra: amostra);
        case "/comparacao":
          return ComparacaoAmostras(
              amostra: amostra, amostraSelecionada: amostraSelecionada);
        default:
          return Placeholder();
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween =
          Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Adjust the height as needed
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Reclassificar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            buildClassificationButton(context, 'Saudável', Colors.green),
            SizedBox(height: 10),
            buildClassificationButton(context, 'Leve', Colors.yellow),
            SizedBox(height: 10),
            buildClassificationButton(context, 'Moderada', Colors.orange),
            SizedBox(height: 10),
            buildClassificationButton(context, 'Severa', Colors.red),
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context, String classification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text(
              'Você tem certeza que deseja classificar a amostra como $classification?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                // Perform classification logic here
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildClassificationButton(
      BuildContext context, String label, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color, // Change button color
      ),
      child: Text(label),
      onPressed: () {
        showConfirmationDialog(context, label);
      },
    );
  }
}
