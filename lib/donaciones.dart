import 'package:flutter/material.dart';

class Donaciones extends StatefulWidget {
  final double donado;
  final recibido;

  Donaciones({Key? key, required this.recibido, required this.donado})
      : super(key: key);

  @override
  State<Donaciones> createState() => _DonacionesState();
}

class _DonacionesState extends State<Donaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Donativos recibidos"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset("paypal.png"),
                trailing: Text(
                  "${widget.recibido["paypal"] ?? 0.0}",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              ListTile(
                leading: Image.asset("tarjeta-de-credito.png"),
                trailing: Text(
                  "${widget.recibido["tarjeta"] ?? 0.0}",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.attach_money_rounded,
                  size: 90,
                ),
                trailing: Text(
                  "${widget.recibido["total"] ?? 0.0}",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              (widget.recibido["100%"])
                  ? (Image.asset("gracias.png", scale: 1.5))
                  : Container(),
              (widget.recibido["100%"])
                  ? Text("¡Gracias por tu apoyo!",
                      style: TextStyle(fontSize: 20, color: Colors.green))
                  : Container()
            ],
          ),
        ));
  }
}
