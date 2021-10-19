import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:patoburguer_admin/models/produto.dart';

Color corTexto = const Color(0xFF434343);

class TelaAlterarProduto extends StatelessWidget {
  const TelaAlterarProduto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference produtos =
        FirebaseFirestore.instance.collection('produtos');

    final String documentId =
        ModalRoute.of(context)!.settings.arguments! as String;

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
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Erro ao encontrar o item selecionado!',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            final Produto produto = Produto(
              documentId,
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
                      top: -(MediaQuery.of(context).size.height * 0.215),
                      left: 0,
                      right: 0,
                      bottom: (MediaQuery.of(context).size.height * 0.8),
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

  TextEditingController? _nomeProduto;
  TextEditingController? _detalhesProduto;
  TextEditingController? _ingredientesProduto;
  TextEditingController? _precoProduto;

  FormularioAlteracaoProduto(this.produto) {
    _nomeProduto = TextEditingController(text: produto.nome);
    _detalhesProduto = TextEditingController(text: produto.detalhes);
    _ingredientesProduto = TextEditingController(text: produto.ingredientes);
    _precoProduto =
        TextEditingController(text: produto.preco.toStringAsFixed(2));
  }

  final _formKey = GlobalKey<FormState>();

  CollectionReference produtos =
      FirebaseFirestore.instance.collection('produtos');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormInput(
            label: 'Nome',
            controller: _nomeProduto!,
          ),
          FormInput(
            label: 'Detalhes',
            controller: _detalhesProduto!,
            minLines: 3,
            maxLines: 3,
          ),
          FormInput(
            label: 'Ingredientes',
            controller: _ingredientesProduto!,
            minLines: 3,
            maxLines: 3,
          ),
          FormInput(
            label: 'Preço',
            controller: _precoProduto!,
            inputPrefix: Text(
              'R\$ ',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            fontSize: 25.0,
          ),
          ElevatedButton(
            onPressed: () async {
              await _atualizaProduto(context);
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
    );
  }

  Future<void> _atualizaProduto(BuildContext context) async {
    late String feedbackMessage;

    await produtos.doc(produto.documentId).update({
      'nome': _nomeProduto!.text,
      'detalhes': _detalhesProduto!.text,
      'ingredientes': _ingredientesProduto!.text,
      'preco': double.tryParse(_precoProduto!.text),
    }).then((value) {
      feedbackMessage = "Produto atualizado com sucesso!";
    }).catchError((error) {
      feedbackMessage = "Erro ao atualizar produto!";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          feedbackMessage,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  final String label;
  TextEditingController controller;
  Widget? inputPrefix;
  int minLines;
  int maxLines;
  double fontSize;

  FormInput(
      {Key? key,
      required this.label,
      required this.controller,
      this.inputPrefix = null,
      this.minLines = 1,
      this.maxLines = 1,
      this.fontSize = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            color: corTexto,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TextFormField(
            controller: controller,
            enableInteractiveSelection: false,
            style: TextStyle(
              color: corTexto.withOpacity(0.6),
              fontSize: fontSize,
            ),
            decoration: InputDecoration(
              prefix: inputPrefix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            minLines: minLines,
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }
}
