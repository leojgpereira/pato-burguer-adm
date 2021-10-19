import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:patoburguer_admin/models/produto.dart';

Color corTexto = const Color(0xFF434343);

class TelaAlterarItem extends StatelessWidget {
  const TelaAlterarItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference produtos =
        FirebaseFirestore.instance.collection('produtos');

    final String documentId =
        ModalRoute.of(context)!.settings.arguments! as String;

    print(documentId);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Cardápio',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: produtos.doc(documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError ||
              (snapshot.hasData && !snapshot.data!.exists)) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 500.0),
                child: Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height * 0.6),
                  padding: EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.report,
                        size: 48.0,
                      ),
                      Text('Erro ao encontrar o item selecionado!')
                    ],
                  ),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            final Produto produto = Produto(
              data['imagem'],
              data['nome'],
              data['detalhes'],
              data['ingredientes'],
              data['preco'],
            );

            return Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height * 0.3),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      // height: (MediaQuery.of(context).size.height * 0.6),
                      padding: EdgeInsets.only(
                        top: 105.96,
                        left: 25.0,
                        right: 25.0,
                        bottom: 25.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: FormularioAlteracaoProduto(produto),
                    ),
                    Positioned(
                      top: -(MediaQuery.of(context).size.height * 0.3),
                      left: 0,
                      right: 0,
                      bottom: (MediaQuery.of(context).size.height * 0.715),
                      child: Image.asset(data['imagem']),
                    ),
                  ],
                ),
              ),
            );
          }

          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height * 0.6),
              padding: EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Color(0xFFF3F3F3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FormularioAlteracaoProduto extends StatelessWidget {
  final Produto produto;

  FormularioAlteracaoProduto(this.produto);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: corTexto,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextFormField(
                enableInteractiveSelection: false,
                initialValue: produto.nome,
                style: TextStyle(
                  color: corTexto.withOpacity(0.6),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                minLines: 1,
                maxLines: 1,
              ),
            ),
            Text(
              'Detalhes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: corTexto,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextFormField(
                enableInteractiveSelection: false,
                initialValue: produto.detalhes,
                style: TextStyle(
                  color: corTexto.withOpacity(0.6),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                minLines: 3,
                maxLines: 3,
              ),
            ),
            Text(
              'Ingredientes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: corTexto,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextFormField(
                enableInteractiveSelection: false,
                initialValue: produto.ingredientes,
                style: TextStyle(
                  color: corTexto.withOpacity(0.6),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                minLines: 3,
                maxLines: 3,
              ),
            ),
            Text(
              'Preço',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: corTexto,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextFormField(
                enableInteractiveSelection: false,
                initialValue: produto.preco.toStringAsFixed(2),
                style: TextStyle(
                  color: corTexto.withOpacity(0.6),
                  fontSize: 25.0,
                ),
                decoration: InputDecoration(
                  prefix: Text(
                    'R\$ ',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                minLines: 1,
                maxLines: 1,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("Atualizar");
              },
              child: Text(
                "Atualizar",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: Size(double.infinity, 55.0),
                primary: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
