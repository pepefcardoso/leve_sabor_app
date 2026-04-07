import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/favorite_post_button/favorite_post_button_bloc.dart';
import 'package:my_app/components/blog_posts/favorite_post_button_controller.dart';
import 'package:my_app/components/custom_icon_card_button.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/models/blog_post.dart';
import 'package:my_app/services/blog_posts_service.dart';

class FavoritePostButton extends StatefulWidget {
  final BlogPost post;
  final FavoritePostButtonController? controller;

  const FavoritePostButton({
    super.key,
    required this.post,
    this.controller,
  });

  @override
  State<FavoritePostButton> createState() => _FavoritePostButtonState();
}

class _FavoritePostButtonState extends State<FavoritePostButton> {
  final KiwiContainer _kiwiContainer = KiwiContainer();
  late final FavoritePostButtonBloc _bloc;
  late final BlogPostsService _service;
  late final FavoritePostButtonController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? FavoritePostButtonController();
    _controller.isFavorite = widget.post.isFavorite ?? false;

    _service = _kiwiContainer.resolve<BlogPostsService>();

    _bloc = FavoritePostButtonBloc(
      blogPostsService: _service,
      isFavorite: widget.post.isFavorite ?? false,
      postId: widget.post.id!,
    );

    _bloc.stream.listen((event) {
      _controller.isFavorite = event.isFavorite ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<FavoritePostButtonBloc, FavoritePostButtonState>(
        builder: (context, state) {
          if (state.status == DefaultBlocStatusEnum.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomIconCardButton(
            onPressed: state.isFavorite ?? false ? () => _bloc.add(const RequestUnfavoriteBlogPost()) : () => _bloc.add(const RequestFavoriteBlogPost()),
            iconSize: 24.0,
            icon: state.isFavorite ?? false ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
          );
        },
      ),
    );
  }
}
