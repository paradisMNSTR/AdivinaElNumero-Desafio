import 'dart:math';

import 'package:adivina_el_numero/constants.dart';
import 'package:adivina_el_numero/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class adivina extends StatefulWidget {
  const adivina({super.key});

  @override
  State<adivina> createState() => _adivinaState();
}

class _adivinaState extends State<adivina> {
  Random random = new Random();
  FocusNode myNode = FocusNode();
  int ranmdom_Number = 0;
  TextEditingController numeros = TextEditingController();
  int intentos = 0;
  double slider_value = 0.0;
  List<number_item> historial = <number_item>[];
  List<number_item> mayor_que = <number_item>[];
  List<number_item> menor_que = <number_item>[];
  String dificultad = 'Facil';
  @override
  void initState() {
    start_game(slider_value.toStringAsFixed(1));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }

  _AppBar(){
    return AppBar(
      title: Center(child: Text('Adivina el Numero')),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.menu))

      ],
    );
  }
  _Body(){
    return Container(
      padding: EdgeInsets.fromLTRB(5, 20, 5, 16),
      child: ListView(
        children: [
      _Header_Content(),
      _Mid_Content(),
      _Slider_content(),
        ],
      ),
    );
  }
  _Header_Content(){
   return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Container(
          width: 200,
          padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
          child: TextField(
            controller: numeros,
            decoration: InputDecoration(
              hintText: '####',
              labelText: 'Numbers',
              border: OutlineInputBorder(

              ),
            ),
            onSubmitted: (text){
              Parse_text();
            },
            keyboardType: TextInputType.number,
            focusNode: myNode,
          ),
        ),
           Text('Intentos\n${intentos}',textAlign: TextAlign.center,)
      ],
      );
  }
  _Mid_Content(){
    return Container(
      height: 300,
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          List_Container(tipo: 'Mayor que',
              lista: mayor_que,
          ),
          List_Container(tipo: 'Menor que',
            lista: menor_que,
          ),
          List_Container(tipo: 'Historial',
            lista: historial,
          ),
        ],
      ),
    );
  }
  _Slider_content(){
    return Column(
      children: [
        Text('${dificultad}'),
        Slider(
            value: slider_value,
            min: 0,
            max: 1,
            divisions: 3,
            onChanged: (double value){
              setState(() {
                slider_value = value;
                start_game(slider_value.toStringAsFixed(1));
              });
            })
      ],
    );
  }

  start_game(String slider_val){
    intentos=0;
    setState(() {
      mayor_que.clear();
      menor_que.clear();
    });
    switch(slider_val){
      case '0.0':
        setState(() {
          dificultad = 'Facil';
          ranmdom_Number = random.nextInt(10)+1;
          intentos = 5;
        });

        break;
      case '0.3':
        setState(() {
          dificultad = 'Medio';
          ranmdom_Number = random.nextInt(20)+1;
          intentos = 8;
        });
        break;
      case '0.7':
        setState(() {
          dificultad = 'Avanzado';
          ranmdom_Number = random.nextInt(100)+1;
          intentos = 15;
        });
        break;
      case '1.0':
        setState(() {
          dificultad = 'Extremo';
          ranmdom_Number = random.nextInt(1000)+1;
          intentos = 25;
        });
        break;
    }
  }
  
  guessing(int numero){
    if(numero==ranmdom_Number){
      setState(() {
        historial.add(number_item(number: numero, color: green_color));
        ScaffoldMessenger.of(context).showSnackBar(showSnack('Adivinaste!!'));
        start_game(slider_value.toStringAsFixed(1));
      });
    }else if(ranmdom_Number>numero){
      setState(() {
        mayor_que.add(number_item(number: numero, color: white_color));
        intentos = intentos-1;
      });
    } else if(numero>ranmdom_Number){
      setState(() {
        menor_que.add(number_item(number: numero, color: white_color));
        intentos = intentos-1;
      });
    }
    if(intentos==0){
      historial.add(number_item(number: numero, color: red_color));
      start_game(slider_value.toStringAsFixed(1));
    }
  }
  Parse_text(){
    if(numeros.text.trim()==''){
          _Alert('Ingresa cualquier numero');
      }else{
      try{
        int value = int.parse(numeros.text);
        guessing(value);
      }on Exception catch(_){
        _Alert('Ingresa unicamente numeros enteros!');
      }
    }
    numeros.text='';
    myNode.requestFocus();
  }
  _Alert(String content) async {
    await showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialogo(content: '${content}');
      }
    );
  }
}

