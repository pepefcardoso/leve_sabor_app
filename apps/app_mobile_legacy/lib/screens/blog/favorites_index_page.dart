import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/favorite_posts_index_page/favorite_posts_index_page_bloc.dart';
import 'package:my_app/components/custom_icon_card_button.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/models/blog_post.dart';
import 'package:my_app/components/blog_posts/posts_list_item.dart';
import 'package:my_app/services/blog_posts_service.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class FavoritePostsIndexPage extends StatefulWidget {
  const FavoritePostsIndexPage({super.key});

  @override
  State<FavoritePostsIndexPage> createState() => _FavoritePostsIndexPageState();
}

class _FavoritePostsIndexPageState extends State<FavoritePostsIndexPage> {
  final KiwiContainer _kiwi = KiwiContainer();
  late final FavoritePostsIndexPageBloc _bloc;
  late final BlogPostsService _service;

  @override
  void initState() {
    super.initState();

    _service = _kiwi.resolve<BlogPostsService>();

    _bloc = FavoritePostsIndexPageBloc(_service);

    _bloc.add(const RequestFavoritePosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6.0,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        actions: _buildActions(),
      ),
      body: BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<FavoritePostsIndexPageBloc, FavoritePostsIndexPageState>(
          builder: (context, state) {
            if (state.status == DefaultBlocStatusEnum.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.posts.isEmpty) {
              return const Center(
                child: Text(
                  'Você ainda não favoritou nenhum post.',
                  style: Tipografia.titulo4,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final BlogPost post = state.posts[index];

                  return PostsItemList(
                    post: post,
                    color: CustomColors.randomColors[index % CustomColors.randomColors.length],
                    router: () => GoRouter.of(context).go(
                      '/blog-posts/favorites/${post.id}',
                      extra: () => _bloc.add(const RequestFavoritePosts()),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      Expanded(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: CustomIconCardButton(
                    onPressed: () => GoRouter.of(context).pop(),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                'Favoritos',
                style: Tipografia.titulo4,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
