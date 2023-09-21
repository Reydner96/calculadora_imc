import 'dart:math';

import 'package:flutter/material.dart';

class Imc {
  final String _idImc = UniqueKey().toString();
  String _nome;
  double _altura;
  double _peso;
  double _imc = 0;
  DateTime? _data;
  String dataFormatada = "";
  String _classificacao = "";
  String sexo;

  Imc(this._nome, this._altura, this._peso, this.sexo) {
    _imc = peso / pow(_altura, 2);
    _classificacao = selecionaClassificacao();
    _data = DateTime.now();
  }

  String get idImc => _idImc;

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  bool isMulher(String sexo) {
    if (sexo.toLowerCase() == 'femenino') {
      return true;
    }
    return false;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get imc => double.parse(_imc.toStringAsFixed(2));

  String selecionaClassificacao() {
    String info = "Classificação:";
    if (imc < 16) {
      return '$info Magreza grave';
    } else if (imc < 17) {
      return '$info Magreza moderada';
    } else if (imc < 18.5) {
      return '$info Magreza leve';
    } else if (imc < 25) {
      return '$info Saudavel';
    } else if (imc < 30) {
      return '$info Sobrepeso';
    } else if (imc < 35) {
      return '$info Obesidade grau I';
    } else if (imc < 40) {
      return '$info Obesidade grau II (severa)';
    } else {
      return '$info Obesidade grau III (morbida)';
    }
  }

  String get classificacao => _classificacao;

  String retornaData() {
    if (_data == null) {
      return 'Data não registrada';
    } else {
      return '${_data!.day}/${_data!.month}/${_data!.year}';
    }
  }
}
