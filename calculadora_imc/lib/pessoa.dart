import 'dart:ffi';

class Pessoa {
  String nome = "";
  late Double peso;
  late Double altura;

  void setNome(String nome) {
    nome = nome;
  }

  String getNome() {
    return nome;
  }

  void setPeso(Double peso) {
    peso = peso;
  }

  Double getPeso() {
    return peso;
  }

  void setAltura(Double altura) {
    altura = altura;
  }

  Double getAltura() {
    return altura;
  }
}
