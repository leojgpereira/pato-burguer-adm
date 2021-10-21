import 'package:flutter/material.dart';

class AlterarCardapio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alterar Cardápio',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFFFFF),
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xFFFFFFFF),),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Color(0xFFFFFFFF),),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 32, right: 45, left: 45),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 32,
                children: [
                  ItemCardapio(),
                  ItemCardapio(),
                  ItemCardapio(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCardapio extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      height: 168,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
        gradient: SweepGradient(
          startAngle: 0.0,
          endAngle: 31.45,
          stops: [
            0.1,
            0.1,
          ],
          colors: [Color(0xFFFFFFFF), Color(0xFFFFCB82)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.9,
            blurRadius: 1,
            offset: Offset(0, 3.5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(Colors.transparent),
          shadowColor:
          MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {},
        child: Column(
          children: [
            //IconButton(
              //icon: Image.asset("assets/images/guarana.png"),
              //iconSize: 120,
              //onPressed: () {},
            //),
            Text(
              "Guaraná Lata",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            Text(
              'RS 0,00',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}