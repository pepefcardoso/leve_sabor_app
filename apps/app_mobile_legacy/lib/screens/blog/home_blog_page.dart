import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/home_blog/home_blog_page_bloc.dart';
import 'package:my_app/components/custom_icon_card_button.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/models/blog_post.dart';
import 'package:my_app/components/blog_posts/posts_list_item.dart';
import 'package:my_app/services/blog_posts_service.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class HomeBlogPage extends StatefulWidget {
  const HomeBlogPage({super.key});

  @override
  State<HomeBlogPage> createState() => _HomeBlogPageState();
}

class _HomeBlogPageState extends State<HomeBlogPage> {
  final KiwiContainer _kiwi = KiwiContainer();
  late final HomeBlogPageBloc _bloc;
  late final BlogPostsService _service;

  @override
  void initState() {
    super.initState();

    _service = _kiwi.resolve<BlogPostsService>();

    _bloc = HomeBlogPageBloc(_service);

    _bloc.add(const RequestPosts());
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
        child: BlocBuilder<HomeBlogPageBloc, HomeBlogPageState>(
          builder: (context, state) {
            if (state.status == DefaultBlocStatusEnum.loading || state.posts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
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
                'Blog Leve Sabor',
                style: Tipografia.titulo4,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconCardButton(
                        onPressed: () => GoRouter.of(context).go('/blog-posts/favorites'),
                        icon: Icons.bookmark,
                      ),
                      CustomIconCardButton(
                        onPressed: () => GoRouter.of(context).go('/blog-posts/search'),
                        icon: Icons.search,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
