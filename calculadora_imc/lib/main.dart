import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  String resultadoImc = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Calculadora IMC',
              ),
              const SizedBox(width: 16, height: 16),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: controllerPeso,
                decoration: const InputDecoration(
                    labelText: 'Peso *',
                    hintText: 'Digite o seu Peso',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              ),
              const SizedBox(
                width: 16,
                height: 16,
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: controllerAltura,
                decoration: const InputDecoration(
                    labelText: 'Altura *',
                    hintText: 'Digite a sua Altura',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                resultadoImc,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 16,
                height: 32,
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        num numAux = (num.parse(controllerPeso.text) /
                            (num.parse(controllerAltura.text) *
                                num.parse(controllerAltura.text)));

                        resultadoImc = numAux.toStringAsFixed(2);
                      });
                    },
                    child: const Text('Calcular')),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          setState(() {
            resultadoImc = '';
          });
        },
        child: const Text('Limpar'),
      ),
    );
  }
}
