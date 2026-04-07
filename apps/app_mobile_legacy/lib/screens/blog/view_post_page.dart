import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/view_blog_post/view_blog_post_bloc.dart';
import 'package:my_app/components/blog_posts/favorite_post_button.dart';
import 'package:my_app/components/blog_posts/favorite_post_button_controller.dart';
import 'package:my_app/components/custom_icon_card_button.dart';
import 'package:my_app/components/custom_network_image.dart';
import 'package:my_app/components/custom_text.dart';
import 'package:my_app/components/blog_posts/post_categories_list.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/services/blog_posts_service.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class ViewPostPage extends StatefulWidget {
  final int id;
  final VoidCallback? onReturn;

  const ViewPostPage({
    super.key,
    required this.id,
    this.onReturn,
  });

  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  final KiwiContainer _kiwiContainer = KiwiContainer();
  late final BlogPostsService _blogPostsService;
  late final ViewBlogPostBloc _viewBlogPostBloc;
  final FavoritePostButtonController _favoritePostButtonController = FavoritePostButtonController();

  @override
  void initState() {
    super.initState();

    _blogPostsService = _kiwiContainer.resolve<BlogPostsService>();

    _viewBlogPostBloc = ViewBlogPostBloc(blogPostsService: _blogPostsService);

    _viewBlogPostBloc.add(RequestBlogPost(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.verde2,
      body: BlocProvider.value(
        value: _viewBlogPostBloc,
        child: BlocBuilder<ViewBlogPostBloc, ViewBlogPostState>(
          builder: (context, state) {
            if (state.status == DefaultBlocStatusEnum.loading || state.blogPost == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Material(
                    elevation: 4.0,
                    child: CustomNetworkImage(
                      url: state.blogPost!.image!.url!,
                      size: MediaQuery
                          .of(context)
                          .size
                          .width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 48.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconCardButton(
                            iconSize: 24.0,
                            onPressed: () {
                              GoRouter.of(context).pop();
                              if (!_favoritePostButtonController.isFavorite) {
                                widget.onReturn?.call();
                              }
                            },
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FavoritePostButton(post: state.blogPost!, controller: _favoritePostButtonController,),
                              const SizedBox(width: 16.0),
                              CustomIconCardButton(
                                onPressed: () {},
                                iconSize: 24.0,
                                icon: Icons.share_outlined,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.38,
                  left: 8.0,
                  right: 8.0,
                  bottom: 0.0,
                  child: Material(
                    elevation: 6.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.62,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostCategoriesList(
                              post: state.blogPost!,
                            ),
                            const SizedBox(height: 16.0),
                            CustomText(
                              text: state.blogPost!.title!,
                              textStyle: Tipografia.titulo4,
                            ),
                            const SizedBox(height: 24.0),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: CustomColors.escuro,
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(state.blogPost!.user!.image!.url!),
                                  child: state.blogPost!.user?.image != null
                                      ? null
                                      : const Icon(
                                    Icons.person,
                                    color: CustomColors.claro,
                                    size: 32.0,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.blogPost!.user?.name ?? '',
                                      style: Tipografia.corpo2Bold,
                                    ),
                                    Text(
                                      'Publicado em ${state.blogPost!.formattedCreatedAt}',
                                      style: Tipografia.corpo2.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey[400],
                              height: 32.0,
                              thickness: 1.0,
                            ),
                            CustomText(
                              text: state.blogPost!.description!,
                              textStyle: Tipografia.titulo2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: CustomText(
                                text: state.blogPost!.content!,
                                textStyle: Tipografia.corpo2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
