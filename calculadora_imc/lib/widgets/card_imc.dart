import 'package:calculadora_imc/model/imc.dart';
import 'package:flutter/material.dart';

class CardImc extends StatelessWidget {
  final Imc imc;
  final Function(String id) removerCard;
  final Function verificarItem;
  const CardImc(
      {required this.imc,
      required this.removerCard,
      required this.verificarItem,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 0.7, color: Colors.black38),
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.black26,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  imc.nome,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: imc.isMulher(imc.sexo) ? Colors.pink : Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IMC: ${imc.imc}',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      imc.classificacao,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      imc.retornaData(),
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext bc) {
                          return AlertDialog(
                            title: const Text("Excluir IMC registrado?"),
                            content: const Text(
                                "Voce deseja realmente excluir este registro?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.black87),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    removerCard(imc.idImc);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Removendo registro'),
                                      backgroundColor: Colors.black87,
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 150.0,
                                    ));
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Excluir",
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          );
                        });
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
