import 'dart:ui';

import 'package:go_router/go_router.dart';
import 'package:my_app/screens/blog/favorites_index_page.dart';
import 'package:my_app/screens/blog/home_blog_page.dart';
import 'package:my_app/screens/blog/search_posts_page.dart';
import 'package:my_app/screens/business/visualizar_estabelecimento.dart';
import 'package:my_app/screens/home_page.dart';
import 'package:my_app/screens/business/businesses_index.dart';
import 'package:my_app/screens/login_page.dart';
import 'package:my_app/screens/signup_page.dart';
import 'package:my_app/screens/blog/view_post_page.dart';

class Routes {
  bool isLogged;

  Routes(this.isLogged);

  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: 'login',
                redirect: (_, __) {
                  if (isLogged) {
                    return '/';
                  }
                  return null;
                },
                builder: (context, state) => const LoginPage(),
              ),
              GoRoute(
                path: 'signup',
                redirect: (_, __) {
                  if (isLogged) {
                    return '/';
                  }
                  return null;
                },
                builder: (context, state) => const SignupPage(),
              ),
              GoRoute(
                path: 'blog-posts',
                builder: (context, state) => const HomeBlogPage(),
                routes: [
                  GoRoute(
                    path: 'search',
                    builder: (context, state) => const SearchPostsPage(),
                    routes: [
                      GoRoute(
                        path: ':index',
                        builder: (context, state) => ViewPostPage(
                          id: int.parse(state.pathParameters['index']!),
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'favorites',
                    builder: (context, state) => const FavoritePostsIndexPage(),
                    routes: [
                      GoRoute(
                        path: ':index',
                        builder: (context, state) => ViewPostPage(
                          id: int.parse(state.pathParameters['index']!),
                          onReturn: state.extra as VoidCallback?,
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: ':index',
                    builder: (context, state) => ViewPostPage(
                      id: int.parse(state.pathParameters['index']!),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'businesses',
                builder: (context, state) => const BusinessesIndex(),
                routes: [
                  GoRoute(
                    path: ':index',
                    builder: (context, state) => VisualizarEstabelecimento(
                      index: state.pathParameters['index']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
