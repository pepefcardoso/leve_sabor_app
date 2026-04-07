import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/components/blog_posts/post_categories_list.dart';
import 'package:my_app/components/custom_image_card.dart';
import 'package:my_app/components/custom_text.dart';
import 'package:my_app/models/blog_post.dart';

class PostsItemList extends StatelessWidget {
  final BlogPost post;
  final Color color;
  final VoidCallback? router;

  const PostsItemList({
    super.key,
    required this.post,
    required this.color,
    this.router,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: InkWell(
        onTap: router ?? () => GoRouter.of(context).go('/blog-posts/${post.id}'),
        child: Card(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
          child: Stack(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                    ),
                    color: color.withOpacity(0.4)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CustomImageCard(url: post.image!.url!),
                    const SizedBox(width: 12.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: post.title!,
                          ),
                          PostCategoriesList(
                            post: post,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
