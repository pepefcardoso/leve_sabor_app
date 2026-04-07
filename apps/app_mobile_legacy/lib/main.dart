import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/app_initialization.dart';
import 'package:my_app/bloc/login/login_bloc.dart';
import 'package:my_app/utils/routes.dart';

void main() async {
  await AppInitialization().initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Routes routes = Routes(false);
  final kiwi = KiwiContainer();
  late final LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();

    loginBloc = kiwi.resolve<LoginBloc>();

    if (loginBloc.state.isLoggedIn) {
      routes.isLogged = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.loggedOut) {
            routes.isLogged = false;
          } else if (state.status == LoginStatus.loggedIn) {
            routes.isLogged = true;
          } else {
            return;
          }
          setState(() {
            routes.router.go('/');
          });
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Healthy Food App',
          routerConfig: routes.router,
        ),
      ),
    );
  }
}
