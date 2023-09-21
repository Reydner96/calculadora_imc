import 'package:calculadora_imc/model/imc.dart';

class ImcRepository {
  final List<Imc> _listaImc = [];
  Future<void> adicionar(Imc imc) async {
    _listaImc.add(imc);
  }

  void deletar(String id) {
    _listaImc.remove(_listaImc.where((imc) => imc.idImc == id).first);
  }

  List<Imc> listarImcs() {
    return _listaImc;
  }
}
