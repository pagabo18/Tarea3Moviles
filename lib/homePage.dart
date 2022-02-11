import 'package:tarea_3/donaciones.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController _confettiController;

  var cantidad = [
    '100',
    '350',
    '850',
    '1050',
    '9999',
    '10000',
  ];

  var _radioValues = {
    0: "Paypal",
    1: "Tarjeta",
  };

  var assetsValues = {
    0: "paypal.png",
    1: "tarjeta-de-credito.png",
  };

  int? _pago;
  double total = 0;
  double totalPaypal = 0;
  double totalTarjeta = 0;
  String cantDonar = '';

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return homePage(context);
  }

  radioGroupGenerator() {
    return _radioValues.entries
        .map((item) => ListTile(
              leading: Image.asset(
                assetsValues[item.key]!,
                height: 40,
                width: 40,
              ),
              title: Text(
                "${item.value}",
                textAlign: TextAlign.left,
              ),
              trailing: Radio(
                value: item.key,
                groupValue: _pago,
                onChanged: (int? metodoPago) {
                  _pago = metodoPago!;
                  setState(() {});
                },
              ),
            ))
        .toList();
  }

  Scaffold homePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donaciones"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Es para una buena causa",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Elija modo de donativo",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(children: radioGroupGenerator()),
            ),
            SizedBox(height: 40.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    "Cantidad a donar:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Column(
                    children: [
                      DropdownButton(
                        value: cantDonar,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cantidad.map((String cantidades) {
                          return DropdownMenuItem(
                            value: cantidades,
                            child: Text(cantidades),
                          );
                        }).toList(),
                        onChanged: (String? Valor) {
                          cantDonar = Valor!;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    LinearPercentIndicator(
                      lineHeight: 30,
                      backgroundColor: Colors.white10,
                      animation: true,
                      animateFromLastPercent: true,
                      // ignore: deprecated_member_use
                      linearStrokeCap: LinearStrokeCap.butt,
                      percent: total / 10000 > 1 ? 1 : total / 10000,
                      progressColor:
                          (total > 0) ? Colors.purple[300] : Colors.white10,
                      center: (total / 100 < 100)
                          ? Text(
                              (total / 100).toString() + "%",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )
                          : Text(
                              "100%",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                            minimumSize: Size(1000, 50)),
                        onPressed: () {
                          if (_pago == 0 || _pago == 1) {
                            total += double.parse(cantDonar);
                            totalPaypal +=
                                _pago != 0 ? 0 : double.parse(cantDonar);
                            totalTarjeta +=
                                _pago != 1 ? 0 : double.parse(cantDonar);
                            _confettiController.play();
                            setState(() {});
                          }
                        },
                        child: Text("Donar")),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        shouldLoop: false,
                        blastDirection: -pi / 2,
                        colors: [
                          Colors.purpleAccent,
                          Colors.purple,
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
                          Colors.blue,
                        ],
                        numberOfParticles: (200),
                        gravity: 1,
                        blastDirectionality: BlastDirectionality.explosive,
                        displayTarget: false,
                        emissionFrequency: 0.01,
                        maxBlastForce: 800,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Donar",
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.text_format_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Donaciones(recibido: {
                      "100%": total < 10000 ? false : true,
                      "total": total,
                      "paypal": totalPaypal,
                      "tarjeta": totalTarjeta,
                    }, donado: double.parse(cantDonar))),
          );
          setState(() {});
        },
      ),
    );
  }
}
