import 'dart:developer';
import 'dart:io' as dart_io;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/login/login_bloc.dart';
import 'package:my_app/components/login_store.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/blog_post_category_service.dart';
import 'package:my_app/services/blog_posts_service.dart';
import 'package:my_app/services/business_service.dart';
import 'package:my_app/services/login_service.dart';
import 'package:my_app/services/user_service.dart';
import 'package:my_app/utils/api_config.dart';
import 'package:my_app/utils/http.dart';

class AppInitialization {
  static const _apiHost = ApiConfig.host;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

// Setting up login flow
    LoginService loginService = const LoginService();
    final LoginStore loginStore = LoginStore();
    await loginStore.onReady;
    late LoginState initialLoginState;

    if (loginStore.isLogged()) {
      final String token = loginStore.getToken();

      try {
        User user = await loginService.getUserData(token: token);

        initialLoginState = LoginState(
          status: LoginStatus.loggedIn,
          user: user,
        );
      } on HttpException catch (httpException) {
        if (kDebugMode) {
          log('[AppInitialization.initialize]: Generic error in app initialization: "${httpException.mensagem}"');
        }

        initialLoginState = const LoginState(status: LoginStatus.loggedOut);
      } catch (e) {
        if (kDebugMode) {
          print('[AppInitialization.initialize]: Generic error in app initialization: "$e"');
        }

        initialLoginState = const LoginState(status: LoginStatus.loggedOut);
      }
    } else {
      initialLoginState = const LoginState(status: LoginStatus.loggedOut);
    }

    final LoginBloc loginBloc = LoginBloc(
      loginService: loginService,
      loginStore: loginStore,
      state: initialLoginState,
    );

    final Http http = Http(
      dio: Dio(BaseOptions(baseUrl: _apiHost)),
      loginBloc: loginBloc,
      loginStore: loginStore,
    );

    final KiwiContainer kiwi = KiwiContainer();

    try {
      kiwi.registerSingleton<Http>((c) => http);

      final Http kiwiHttp = kiwi.resolve<Http>();

      kiwi.registerSingleton<LoginStore>((c) => loginStore);

      kiwi.registerSingleton<LoginBloc>((c) => loginBloc);

      kiwi.registerFactory<BusinessService>((c) => BusinessService(http: kiwiHttp));

      kiwi.registerFactory<UserService>((c) => UserService(http: kiwiHttp));

      kiwi.registerFactory<BlogPostsService>((c) => BlogPostsService(http: kiwiHttp));

      kiwi.registerFactory<BlogPostCategoriesService>((c) => BlogPostCategoriesService(http: kiwiHttp));
    } on HttpException catch (httpException) {
      if (kDebugMode) {
        print('[AppInitialization.initialize]: [HttpException] error in app initialization: "${httpException.mensagem}"');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('[AppInitialization.initialize]: Generic error in app initialization: "$error"\nstackTrace: $stackTrace');
      }

      dart_io.exit(1);
    }
  }
}
