import 'package:calculadora_imc/data/sexo_repository.dart';
import 'package:calculadora_imc/model/imc.dart';
import 'package:flutter/material.dart';

class FormImc extends StatefulWidget {
  const FormImc({super.key});

  @override
  State<FormImc> createState() => _FormImcState();
}

class _FormImcState extends State<FormImc> {
  List<Imc> imcs = [];
  bool possuiItem = false;
  List<String> sexos = [];
  SexoRepository sexoRepository = SexoRepository();
  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  String? sexoSelecionado;

  @override
  void initState() {
    carregarSexos();
    super.initState();
  }

  void carregarSexos() {
    sexos = sexoRepository.retornaSexos();
  }

  bool validaNome(String? value) {
    if (value != null && value.length > 2) {
      return true;
    }
    return false;
  }

  bool validaDouble(String? value) {
    if (value != null && value.isNotEmpty) {
      double number = double.parse(value);
      if (number > 0) {
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _globalKey,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  const Text(
                    'Preencha os campos',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (validaNome(value)) {
                        return null;
                      } else {
                        if (nomeController.text.isEmpty) {
                          return 'O campo nome não pode ficar em branco';
                        }
                        return 'O campo nome deve ter no mínimo 2 caracteres';
                      }
                    },
                    controller: nomeController,
                    decoration: const InputDecoration(
                      hintText: 'Digite seu nome',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                      label: Text(
                        'Nome',
                        style: TextStyle(fontSize: 18),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (String? value) {
                      if (validaDouble(value)) {
                        return null;
                      } else {
                        if (alturaController.text.isEmpty) {
                          return 'O campo altura não pode ficar em branco';
                        }
                        return 'O campo altura não pode ser menor ou igual a zero';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: alturaController,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua altura',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                      label: Text(
                        'Altura',
                        style: TextStyle(fontSize: 18),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (String? value) {
                      if (validaDouble(value)) {
                        return null;
                      } else {
                        if (pesoController.text.isEmpty) {
                          return 'O campo peso não pode ficar em branco';
                        }
                        return 'O campo altura não pode ser menor ou igual a zero';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: pesoController,
                    decoration: const InputDecoration(
                      hintText: 'Digite seu peso',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                      label: Text(
                        'Peso',
                        style: TextStyle(fontSize: 18),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Escolha seu sexo: "),
                  Column(
                    children: sexos
                        .map(
                          (sexo) => RadioListTile(
                              dense: true,
                              selected: sexoSelecionado == sexo,
                              title: Text(sexo),
                              value: sexo,
                              groupValue: sexoSelecionado,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    sexoSelecionado = value;
                                  });
                                }
                              }),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate() &&
                            sexoSelecionado != null) {
                          Imc imc = Imc(
                            nomeController.text,
                            double.parse(alturaController.text),
                            double.parse(pesoController.text),
                            sexoSelecionado!,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Adicionando imc'),
                            backgroundColor: Colors.black87,
                            behavior: SnackBarBehavior.floating,
                            elevation: 150.0,
                          ));
                          Navigator.pop(context, imc);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: const Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
