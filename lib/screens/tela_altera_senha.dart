import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patoburguer_admin/models/auth_exception.dart';
import 'package:patoburguer_admin/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class TelaAlteraSenha extends StatelessWidget {
  const TelaAlteraSenha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Alterar Senha',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Container(
              width: (MediaQuery.of(context).size.width * 0.85),
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FormularioAlteracaoSenha(),
            ),
          ),
        ),
      ),
    );
  }
}

class FormularioAlteracaoSenha extends StatefulWidget {
  const FormularioAlteracaoSenha({Key? key}) : super(key: key);

  @override
  _FormularioAlteracaoSenhaState createState() =>
      _FormularioAlteracaoSenhaState();
}

class _FormularioAlteracaoSenhaState extends State<FormularioAlteracaoSenha> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _senhaAtual = TextEditingController();
  TextEditingController _novaSenha = TextEditingController();
  TextEditingController _confirmacaoSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CampoSenha(
            label: 'Senha Atual',
            controller: _senhaAtual,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Insira sua senha atual";
              }
            },
          ),
          CampoSenha(
            label: 'Nova Senha',
            controller: _novaSenha,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Insira sua nova senha";
              } else if (value != _confirmacaoSenha.text &&
                  _confirmacaoSenha.text.isNotEmpty) {
                return "Senhas diferentes";
              } else if (value.length < 6) {
                return "Deve conter pelo menos 6 caracteres";
              }
            },
          ),
          CampoSenha(
            label: 'Confirmar Senha',
            controller: _confirmacaoSenha,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirme sua nova senha";
              } else if (value != _novaSenha.text &&
                  _novaSenha.text.isNotEmpty) {
                return "Senhas diferentes";
              }
            },
          ),
          SizedBox(
            height: 64.0,
          ),
          ElevatedButton(
            onPressed: () async {
              await _updatePassword(context);
            },
            child: Text(
              'Salvar',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(8.0),
              primary: Theme.of(context).primaryColor,
              minimumSize: Size(
                double.infinity,
                20.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _updatePassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      late String feedbackMessage;

      try {
        await context
            .read<AuthService>()
            .updatePassword(_senhaAtual.text, _novaSenha.text)
            .then((value) {
          Navigator.pop(context);
          feedbackMessage = "Senha alterada com sucesso!";
        });
      } on AuthException catch (e) {
        feedbackMessage = e.message;
      }

      final feedbackAlteracaoSenha = SnackBar(
        content: Text(
          feedbackMessage,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(feedbackAlteracaoSenha);
    }
  }
}

class CampoSenha extends StatefulWidget {
  final String label;
  TextEditingController controller;
  bool textInvisible = true;
  final Function validator;

  CampoSenha({
    Key? key,
    required this.label,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  _CampoSenhaState createState() => _CampoSenhaState();
}

class _CampoSenhaState extends State<CampoSenha> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.textInvisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    widget.textInvisible = !widget.textInvisible;
                  });
                },
                icon: Icon(
                  widget.textInvisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              return widget.validator(value);
            },
          ),
        ),
      ],
    );
  }
}
