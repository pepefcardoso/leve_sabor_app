import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/login/login_bloc.dart';
import 'package:my_app/bloc/signup/signup_bloc.dart';
import 'package:my_app/components/custom_text_formfield.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/services/user_service.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final SignupBloc _signupBloc;
  final KiwiContainer _kiwi = KiwiContainer();
  late final UserService _userService;
  late final LoginBloc _loginBloc;

  String? _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _signupBloc.add(
        RequestSignup(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        ),
      );
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();

    _userService = _kiwi.resolve<UserService>();
    _loginBloc = _kiwi.resolve<LoginBloc>();
    _signupBloc = SignupBloc(
      userService: _userService,
      loginBloc: _loginBloc,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

    _signupBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.verde1,
      body: BlocProvider.value(
        value: _signupBloc,
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.status == DefaultBlocStatusEnum.error) {
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
                              'Cadastre-se',
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
                                  if (state.status == DefaultBlocStatusEnum.loading) ...[
                                    const Center(child: CircularProgressIndicator()),
                                  ] else ...[
                                    CustomTextField(
                                      controller: _nameController,
                                      labelText: 'Nome',
                                      hintText: 'Insira seu nome',
                                      icon: Icons.person,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Nome inválido';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    CustomTextField(
                                      controller: _emailController,
                                      labelText: 'E-mail',
                                      hintText: 'Insira seu e-mail',
                                      icon: Icons.email,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) => EmailValidator.validate(value ?? '') ? null : "Email inválido",
                                    ),
                                    const SizedBox(height: 16.0),
                                    CustomTextField(
                                      controller: _phoneController,
                                      labelText: 'Telefone',
                                      hintText: 'Insira seu telefone',
                                      icon: Icons.phone,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        TelefoneInputFormatter(),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Telefone inválido';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    CustomTextField(
                                      controller: _passwordController,
                                      labelText: 'Senha',
                                      obscureText: true,
                                      hintText: 'Insira sua senha',
                                      icon: Icons.lock,
                                      validator: (value) {
                                        if (value == null || value.isEmpty || value.length < 8) {
                                          return 'Senha inválida';
                                        }

                                        return null;
                                      },
                                      onSubmitted: (_) => _onSubmit(),
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
                                          'Cadastrar',
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
                                            'Já possui conta? ',
                                            style: Tipografia.corpo2.copyWith(color: Colors.grey[700]),
                                          ),
                                          TextButton(
                                            onPressed: () => GoRouter.of(context).go('/login'),
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              alignment: Alignment.centerLeft,
                                            ),
                                            child: Text(
                                              'Entre aqui',
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
      ),
    );
  }
}
