import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/search_posts_page/search_posts_page_bloc.dart';
import 'package:my_app/components/blog_posts/posts_filters.dart';
import 'package:my_app/components/custom_icon_card_button.dart';
import 'package:my_app/components/search_field_and_button.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/models/blog_post.dart';
import 'package:my_app/components/blog_posts/posts_list_item.dart';
import 'package:my_app/services/blog_posts_service.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class SearchPostsPage extends StatefulWidget {
  const SearchPostsPage({super.key});

  @override
  State<SearchPostsPage> createState() => _SearchPostsPageState();
}

class _SearchPostsPageState extends State<SearchPostsPage> {
  final TextEditingController _wordController = TextEditingController();
  final KiwiContainer _kiwi = KiwiContainer();
  late final BlogPostsService _service;
  late final SearchPostsPageBloc _bloc;

  @override
  void initState() {
    super.initState();

    _service = _kiwi.resolve<BlogPostsService>();

    _bloc = SearchPostsPageBloc(_service);
    _bloc.add(const SearchPostsEvent());
  }

  @override
  void dispose() {
    _wordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<SearchPostsPageBloc, SearchPostsPageState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 6.0,
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.white,
              actions: _buildActions(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SearchFieldAndButton(
                    controller: _wordController,
                    hintText: 'Pesquise entre seus posts favoritos',
                    onPressed: () => _bloc.add(
                      SearchPostsEvent(queryParameters: _buildQueryParams()),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (state.status == DefaultBlocStatusEnum.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.posts.isEmpty)
                    const Center(
                      child: Text(
                        'Nenhum post encontrado',
                        style: Tipografia.titulo4,
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          final BlogPost post = state.posts[index];

                          return PostsItemList(
                            post: post,
                            color: CustomColors.randomColors[index % CustomColors.randomColors.length],
                            router: () => GoRouter.of(context).go(
                              '/blog-posts/search/${post.id}',
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Map<String, String> _buildQueryParams() {
    return {
      'title': _wordController.text,
    };
  }

  List<Widget> _buildActions() {
    return [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: CustomIconCardButton(
                onPressed: () => GoRouter.of(context).pop(),
              ),
            ),
            const Text(
              'Pesquisar',
              style: Tipografia.titulo4,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CustomIconCardButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  elevation: 6.0,
                  enableDrag: true,
                  builder: (context) => const PostsFilters(),
                ),
                icon: Icons.filter_list,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
