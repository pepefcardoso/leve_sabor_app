import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/components/blog_posts/selectable_items_list.dart';
import 'package:my_app/models/blog_post_category.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class PostsFilters extends StatefulWidget {
  const PostsFilters({
    super.key,
  });

  @override
  State<PostsFilters> createState() => _PostsFiltersState();
}

class _PostsFiltersState extends State<PostsFilters> {
  late final SelectableItemsController<BlogPostCategory> _categoriesController;


  @override
  void initState() {
    super.initState();

    _categoriesController = SelectableItemsController();
    _categoriesController.items = [
      BlogPostCategory(id: 1, name: 'Tecnologia'),
      BlogPostCategory(id: 2, name: 'Saúde'),
      BlogPostCategory(id: 3, name: 'Educação'),
      BlogPostCategory(id: 4, name: 'Finanças'),
      BlogPostCategory(id: 5, name: 'Esportes'),
      BlogPostCategory(id: 6, name: 'Entretenimento'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _headers,
              ),
              const SizedBox(height: 16.0),
              SelectableItemsList<BlogPostCategory>(
                label: 'Categorias',
                controller: _categoriesController,
                labelBuilder: (category) => category.name!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get _headers {
    return [
      Expanded(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Resetar',
                    style: Tipografia.corpo2Bold,
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                'Filtros',
                style: Tipografia.titulo4,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: CustomColors.escuro,
                    size: 16.0,
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
