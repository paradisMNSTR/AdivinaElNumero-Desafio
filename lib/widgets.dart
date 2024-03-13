import 'package:adivina_el_numero/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogo extends StatefulWidget {
  String content;
  Dialogo({super.key,required this.content});

  @override
  State<Dialogo> createState() => DialogoState();
}

class DialogoState extends State<Dialogo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.content}'),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('OK!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class List_Container extends StatefulWidget {
  String tipo;
  List<number_item> lista;
  List_Container({super.key,required this.tipo,required this.lista});

  @override
  State<List_Container> createState() => _List_ContainerState();
}

class _List_ContainerState extends State<List_Container> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: white_color,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Text('${widget.tipo}')),
              Expanded(
                flex: 9,
                child: ListView.builder(
                    itemCount: widget.lista.length,
                    itemBuilder: (BuildContext context ,int index){
                      return Center(
                          child: Text('${widget.lista[index].number}',
                            style: TextStyle(
                                color: widget.lista[index].color,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),));
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class number_item{
  int number;
  Color color;
  number_item({required this.number,required this.color});
}
showSnack(String text){
  return SnackBar(
      content: Text(text),
  );
}

