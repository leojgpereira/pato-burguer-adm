import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patoburguer_admin/models/informacoes.dart';

class Contato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contato',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFFFFF),
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 44.0,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
            ),
            child: FutureBuilder(
              future:
                  FirebaseFirestore.instance.collection('informacoes').get(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Informacoes informacoes = Informacoes(
                    id: snapshot.data.docs[0].id,
                    endereco: snapshot.data.docs[0].get('endereco'),
                    horarioSegSex: snapshot.data.docs[0].get('horarioSegSex'),
                    horarioSab: snapshot.data.docs[0].get('horarioSab'),
                    horarioDomFer: snapshot.data.docs[0].get('horarioDomFer'),
                    whatsapp: snapshot.data.docs[0].get('whatsapp'),
                    facebook: snapshot.data.docs[0].get('facebook'),
                    instagram: snapshot.data.docs[0].get('instagram'),
                  );

                  return ContatoDetalhes(informacoes);
                }

                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ContatoDetalhes extends StatelessWidget {
  final Informacoes informacoes;

  TextEditingController? _campoEndereco;
  TextEditingController? _campoHorarioSegSex;
  TextEditingController? _campoHorarioSab;
  TextEditingController? _campoHorarioDomFer;
  TextEditingController? _campoWhatsapp;
  TextEditingController? _campoFacebook;
  TextEditingController? _campoInstagram;

  ContatoDetalhes(this.informacoes) {
    _campoEndereco = TextEditingController(text: informacoes.endereco);
    _campoHorarioSegSex =
        TextEditingController(text: informacoes.horarioSegSex);
    _campoHorarioSab = TextEditingController(text: informacoes.horarioSab);
    _campoHorarioDomFer =
        TextEditingController(text: informacoes.horarioDomFer);
    _campoWhatsapp = TextEditingController(text: informacoes.whatsapp);
    _campoFacebook = TextEditingController(text: informacoes.facebook);
    _campoInstagram = TextEditingController(text: informacoes.instagram);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Endereço:',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFB54B),
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 32, right: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextFormField(
                      controller: _campoEndereco,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 1,
                          bottom: 1,
                          right: 10,
                          left: 10,
                        ),
                        suffixIcon: Image.asset('assets/imagens/edit.png'),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFB54B),
                        fontSize: 15.0,
                      ),
                      minLines: 2,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha esta informação';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xFFC4C4C4),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Horário de Funcionamento:',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFB54B),
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: _campoHorarioSegSex,
                  decoration: InputDecoration(
                    prefixText: 'Segunda à Sexta',
                    prefixStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: Image.asset('assets/imagens/edit.png'),
                    contentPadding:
                        EdgeInsets.only(top: 1, bottom: 1, right: 10, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFB54B),
                    fontSize: 13.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha esta informação';
                    }

                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: _campoHorarioSab,
                  decoration: InputDecoration(
                    prefixText: 'Sábado',
                    prefixStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: Image.asset('assets/imagens/edit.png'),
                    contentPadding:
                        EdgeInsets.only(top: 1, bottom: 1, right: 10, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFB54B),
                    fontSize: 13.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha esta informação';
                    }

                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: _campoHorarioDomFer,
                  decoration: InputDecoration(
                    prefixText: 'Domingo e Feriados',
                    prefixStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: Image.asset('assets/imagens/edit.png'),
                    contentPadding:
                        EdgeInsets.only(top: 1, bottom: 1, right: 10, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFB54B),
                    fontSize: 13.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha esta informação';
                    }

                    return null;
                  },
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xFFC4C4C4),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Faça seu pedido em:',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFB54B),
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset('assets/imagens/Whats.png'),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _campoWhatsapp,
                        decoration: InputDecoration(
                          suffixIcon: Image.asset('assets/imagens/edit.png'),
                          contentPadding: EdgeInsets.only(
                              top: 1, bottom: 1, right: 10, left: 10),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFB54B),
                          fontSize: 15.0,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha esta informação';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Redes Sociais:',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFB54B),
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset('assets/imagens/Facebook.png'),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _campoFacebook,
                        decoration: InputDecoration(
                          suffixIcon: Image.asset('assets/imagens/edit.png'),
                          contentPadding: EdgeInsets.only(
                              top: 1, bottom: 1, right: 10, left: 10),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFB54B),
                          fontSize: 15.0,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha esta informação';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 32, right: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset('assets/imagens/Instagram.png'),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _campoInstagram,
                        decoration: InputDecoration(
                          suffixIcon: Image.asset('assets/imagens/edit.png'),
                          contentPadding: EdgeInsets.only(
                              top: 1, bottom: 1, right: 10, left: 10),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFB54B),
                          fontSize: 15.0,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha esta informação';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _salvaInformacoes(context);
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(313, 54),
              ),
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _salvaInformacoes(BuildContext context) async {
    late String feedbackMessage;

    await FirebaseFirestore.instance
        .collection('informacoes')
        .doc(informacoes.id)
        .update({
      'endereco': _campoEndereco!.text,
      // 'cidade': _campoCidade!.text,
      // 'estado': _campoEstado!.text,
      'horarioSegSex': _campoHorarioSegSex!.text,
      'horarioSab': _campoHorarioSab!.text,
      'horarioDomFer': _campoHorarioDomFer!.text,
      'whatsapp': _campoWhatsapp!.text,
      'facebook': _campoFacebook!.text,
      'instagram': _campoInstagram!.text,
    }).then((value) {
      feedbackMessage = "Informações atualizadas com sucesso!";
    }).catchError((error) {
      feedbackMessage = "Erro ao atualizar as informações!";
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
