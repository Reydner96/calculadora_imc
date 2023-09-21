import 'package:calculadora_imc/data/imc_repository.dart';
import 'package:calculadora_imc/model/imc.dart';
import 'package:calculadora_imc/widgets/card_imc.dart';
import 'package:calculadora_imc/widgets/form.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Imc> imcs = [];
  ImcRepository repositorioImc = ImcRepository();
  bool possuiItem = false;

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
  void initState() {
    obterDados();
    super.initState();
  }

  void obterDados() {
    imcs = repositorioImc.listarImcs();
    setState(() {});
  }

  void removerCard(String id) {
    repositorioImc.deletar(id);
    obterDados();
  }

  void verificaItem() {
    if (imcs.isEmpty) {
      possuiItem = false;
    }
    possuiItem = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros de IMCs'),
      ),
      body: possuiItem
          ? ListView.builder(
              itemCount: imcs.length,
              itemBuilder: (BuildContext bc, int index) {
                var imc = imcs[index];
                return Padding(
                    padding: const EdgeInsets.all(12),
                    child: CardImc(
                      imc: imc,
                      removerCard: removerCard,
                      verificarItem: verificaItem,
                    ));
              },
            )
          : const Center(
              child: Text('A lista não possui nenhum imc cadastrado')),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Adicionar'),
        onPressed: () async {
          final result = await showModalBottomSheet(
            elevation: 8,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            context: context,
            builder: (BuildContext bc) {
              return const FormImc();
            },
          );
          if (result != null) {
            repositorioImc.adicionar(result);
            verificaItem();
            setState(() {});
          }
        },
        tooltip: 'Adicionar imc',
        icon: const Icon(Icons.add),
      ),
    );
  }
}
