import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/bloc/login/login_bloc.dart';
import 'package:my_app/components/custom_text_formfield.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final String? _lastEmail;
  late final LoginBloc _loginBloc;

  String? _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _loginBloc.add(RequestLogin(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _lastEmail = _loginBloc.loginStore.getLastEmail();

    _emailController = TextEditingController(text: _lastEmail);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.verde1,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Olá! Seja bem vindo!',
                            style: Tipografia.titulo4.copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Card(
                          surfaceTintColor: Colors.grey[100],
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state.status == LoginStatus.loggingIn) ...[
                                  const Center(child: CircularProgressIndicator()),
                                ] else ...[
                                  CustomTextField(
                                    controller: _emailController,
                                    labelText: 'E-mail',
                                    hintText: 'Digite seu e-mail',
                                    icon: Icons.email,
                                    validator: (value) => EmailValidator.validate(value ?? '') ? null : "Email inválido",
                                  ),
                                  const SizedBox(height: 16.0),
                                  CustomTextField(
                                    controller: _passwordController,
                                    labelText: 'Senha',
                                    obscureText: true,
                                    hintText: 'Digite sua senha',
                                    icon: Icons.lock,
                                    validator: (value) {
                                      if (value == null || value.isEmpty || value.length < 8) {
                                        return 'Senha inválida';
                                      }

                                      return null;
                                    },
                                    onSubmitted: (_) => _onSubmit(),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: Text(
                                      'Esqueceu sua senha?',
                                      style: Tipografia.corpo2.copyWith(color: CustomColors.verde1),
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  SizedBox(
                                    height: 48.0,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 4.0,
                                        backgroundColor: CustomColors.verde1,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                      ),
                                      onPressed: _onSubmit,
                                      child: Text(
                                        'Entrar',
                                        style: Tipografia.titulo2.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Não possui uma conta? ',
                                          style: Tipografia.corpo2.copyWith(color: Colors.grey[700]),
                                        ),
                                        TextButton(
                                          onPressed: () => GoRouter.of(context).go('/signup'),
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          child: Text(
                                            'Cadastre-se',
                                            style: Tipografia.corpo2Bold.copyWith(color: CustomColors.verde1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
