// models/amostra.dart
import 'package:displasia_cad/models/descritor.dart';

import 'imagem.dart';
import 'explicacao.dart';

enum Classificacao { Saudavel, Leve, Moderada, Severa }

enum Confianca { Confiavel, Incerta, Inconclusiva }

class AmostraModel {
  final int id;
  final String nome;
  final List<Imagem> imagens;
  Classificacao classificacao;
  final Explicacao explicacaoPrincipal;
  final List<Explicacao> explicacoesComplementares;
  final List<int> amostrasSimilares;
  Confianca confianca;

  AmostraModel(
      this.id,
      this.nome,
      this.imagens,
      this.classificacao,
      this.explicacaoPrincipal,
      this.explicacoesComplementares,
      this.amostrasSimilares,
      this.confianca);

  static List<AmostraModel> getAmostras() {
    return [
      AmostraModel(
          1,
          'Amostra 290',
          [
            Imagem(
                1,
                'TesteImage',
                'http://localhost:8000/static/displasia1.jpg',
                'dog',
                [Descritor(1, "Media", 1.23, TipoDescritor.Morfologico)])
          ],
          Classificacao.Severa,
          Explicacao(
              1,
              "Anchor",
              "http://aaaa",
              """
--- classe predita (severa) ---
anchor:  StdDev_Avr_r <= 27.51 Median_Soliditys <= 0.97 StdDev_StdDev_b > 8.38
Quando estas condições são verdadeiras (0,9% dos casos), o modelo prediz Severa em 100% dos casos.

--- Porque não saudável ---
anchor:  Median_Max_r > 193.25 Avr_Areas <= 939.03
Quando estas condições são verdadeiras (15,3% dos casos), o modelo prediz diferente de Saudável em 100% dos casos;

--- Porque não leve ---
anchor:  Median_Soliditys <= 0.97 StdDev_Min_r > 29.85
Quando estas condições são verdadeiras (14,4% dos casos), o modelo prediz diferente de leve em 100% dos casos.

--- Porque não moderada ---
anchor:  Mode_Extents > 0.56 Avr_StdDev_b > 24.33
Quando estas condições são verdadeiras (14,7% dos casos), o modelo prediz diferente de moderada em 99,1% dos casos.
""",
              TipoExplicacao.Local),
          [
            Explicacao(
                1,
                "Shap Local",
                "http://localhost:8000/static/shap_local.jpg",
                "Valores Shap extraidos da amostra",
                TipoExplicacao.Local),
            Explicacao(
                1,
                "Shap Global",
                "http://localhost:8000/static/shap.jpg",
                "Valores Shap extraidos do modelo",
                TipoExplicacao.Global)
          ],
          [2, 3],
          Confianca.Incerta),
      AmostraModel(
          2,
          'Amostra 289',
          [
            Imagem(
                1,
                'TesteImage',
                'http://localhost:8000/static/displasia2.jpg',
                'dog',
                [Descritor(1, "Media", 1.23, TipoDescritor.Morfologico)])
          ],
          Classificacao.Severa,
          Explicacao(
              1,
              "Anchor",
              "http://localhost:8000/static/shap_local.jpg",
              """
--- classe predita (severa) ---
anchor:  Avr_Avr_r <= 79.98 StdDev_Min_gray > 25.39 StdDev_Median_g <= 24.60
precision:  1.0
coverage:  0.0253
--- saudavel ---
anchor:  StdDev_Min_r > 17.01 Avr_MinorAxisLengths <= 25.51
precision:  1.0
coverage:  0.2173
--- leve ---
anchor:  StdDev_MajorAxisLengths > 21.59 StdDev_Min_r > 29.85
precision:  1.0
coverage:  0.0987
--- moderada ---
anchor:  Avr_Avr_r <= 103.56 Avr_StdDev_b > 24.33
precision:  0.9895833333333334
coverage:  0.2441
""",
              TipoExplicacao.Local),
          [
            Explicacao(
                1,
                "Shap Local",
                "http://localhost:8000/static/shap_local.jpg",
                "Valores Shap extraidos da amostra",
                TipoExplicacao.Local),
            Explicacao(
                1,
                "Shap Global",
                "http://localhost:8000/static/shap.jpg",
                "Valores Shap extraidos do modelo",
                TipoExplicacao.Global)
          ],
          [1, 3, 4],
          Confianca.Confiavel),
      AmostraModel(
          3,
          'Amostra 284',
          [
            Imagem(
                1,
                'TesteImage',
                'http://localhost:8000/static/displasia3.jpg',
                'dog',
                [Descritor(1, "Media", 1.23, TipoDescritor.Morfologico)])
          ],
          Classificacao.Severa,
          Explicacao(
              1,
              "Anchor",
              "http://localhost:8000/static/shap_local.jpg",
              """
--- classe predita (severa) ---
anchor:  Avr_Min_g <= 32.94 Median_Soliditys <= 0.97 StdDev_Min_gray > 25.39
precision:  0.9711815561959655
coverage:  0.0709
--- saudavel ---
anchor:  Mode_Median_gray <= 67.00 Median_Max_r > 193.25
precision:  0.9975317348377997
coverage:  0.1007
--- leve ---
anchor:  StdDev_Avr_r > 22.87 StdDev_Min_r > 29.85
precision:  1.0
coverage:  0.2459
--- moderada ---
anchor:  Median_Min_g <= 38.62 Avr_Eccentricitys <= 0.76 Mode_Avr_b > 126.04
precision:  1.0
coverage:  0.0703

""",
              TipoExplicacao.Local),
          [
            Explicacao(
                1,
                "Shap Local",
                "http://localhost:8000/static/shap_local.jpg",
                "Valores Shap extraidos da amostra",
                TipoExplicacao.Local),
            Explicacao(
                1,
                "Shap Global",
                "http://localhost:8000/static/shap.jpg",
                "Valores Shap extraidos do modelo",
                TipoExplicacao.Global)
          ],
          [2, 1, 4],
          Confianca.Confiavel),
    ];
  }
}
