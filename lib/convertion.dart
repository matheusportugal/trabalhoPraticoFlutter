import 'package:flutter/material.dart';

class Convertion extends StatefulWidget {
  const Convertion({Key key}) : super(key: key);

  @override
  _ConvertionState createState() => _ConvertionState();
}

class _ConvertionState extends State<Convertion> {
  final TextEditingController _qtdeReaisController = TextEditingController();
  final TextEditingController _cotacaoDolarController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var _resultado = '';
  var _situacao = '';

  _onItemTapped(int index) {
    if (index == 0) {
      _qtdeReaisController.clear();
      _cotacaoDolarController.clear();
      setState(() {
        _resultado = '';
        _situacao = '';
      });

    } else if (_qtdeReaisController.text.isEmpty || _cotacaoDolarController.text.isEmpty) {
      key.currentState.showSnackBar(SnackBar(
        content: Text('Quantidade em Reais e Cotação do Dólar são obrigatórios.'),
      ));
    } else {
      try {
        var qtdeReais = double.parse(_qtdeReaisController.text);
        var cotacaoDolar = double.parse(_cotacaoDolarController.text);
        var convertion = qtdeReais / cotacaoDolar;
        setState(() {
          _resultado = 'Com ${qtdeReais.toStringAsFixed(2)} reais é possível comprar ${convertion.toStringAsFixed(2)} dólares a ${cotacaoDolar.toStringAsFixed(2)} cada';

        });

      } catch (e) {
        key.currentState.showSnackBar(SnackBar(
          content: Text('Quantidade em Reais e Cotação do Dólar foram informados em formato inválido.'),
        ));
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Reais para Dólar', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.amber,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/dollar.png", width: 90),
            TextField(
              controller: _qtdeReaisController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  hintText: 'Quantidade em Reais',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
              ),
            ),
            TextField(
              controller: _cotacaoDolarController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  hintText: 'Cotação do Dólar',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
              ),
            ),
            Text('$_resultado', style: TextStyle(fontSize: 30)),
            Text('$_situacao', style: TextStyle(fontSize: 30))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amberAccent,
        onTap:_onItemTapped,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.clear, color: Colors.black, size: 20,),
              title: Text('Limpar', style: TextStyle(color: Colors.black, fontSize: 20))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.check, color: Colors.black, size: 20),
              title: Text('Calcular', style: TextStyle(color: Colors.black, fontSize: 20))
          )
        ],
      ),
    );
  }
}
