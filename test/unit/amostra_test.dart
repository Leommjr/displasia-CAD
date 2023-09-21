import 'package:flutter_test/flutter_test.dart';
import 'package:displasia_cad/models/amostra.dart';

void main() {
  test('Amostras can be fetched', () {
    final amostras = AmostraModel.getAmostras();

    expect(amostras.length, greaterThan(0));
  });
}
