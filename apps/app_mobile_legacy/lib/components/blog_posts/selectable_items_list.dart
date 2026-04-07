import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/posts_filters/posts_filters_bloc.dart';
import 'package:my_app/services/blog_post_category_service.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

typedef LabelBuilder<T> = String Function(T item);

class SelectableItemsList<T> extends StatefulWidget {
  final String label;
  final LabelBuilder<T> labelBuilder;
  final SelectableItemsController<T> controller;

  const SelectableItemsList({
    super.key,
    required this.label,
    required this.labelBuilder,
    required this.controller,
  });

  @override
  State<SelectableItemsList<T>> createState() => _SelectableItemsListState();
}

class _SelectableItemsListState<T> extends State<SelectableItemsList<T>> {
  @override
  void initState() {
    super.initState();

    _categoriesService = _kiwi.resolve<BlogPostCategoriesService>();

    _bloc = PostsFiltersBloc(_categoriesService);

    widget.controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<PostsFiltersBloc, PostsFiltersState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: Tipografia.titulo2,
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 32.0,
                child: ListView.builder(
                  itemCount: widget.controller.items.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final T item = widget.controller.items[index];

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _SelectableItem(
                          label: widget.labelBuilder(item),
                          isSelected: widget.controller.isSelected(item),
                          onTap: () => widget.controller.toggleItem(item),
                        ),
                        if (index < widget.controller.items.length - 1) const SizedBox(width: 8.0),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SelectableItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.verde1 : CustomColors.verde2,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          label,
          style: Tipografia.corpo2Bold.copyWith(
            color: isSelected ? CustomColors.claro : CustomColors.escuro,
          ),
        ),
      ),
    );
  }
}

class SelectableItemsController<T> extends ChangeNotifier {
  List<T> _items = [];

  List<T> get items => _items;

  set items(List<T> items) {
    _items = items;
    notifyListeners();
  }

  final List<T> _selectedItems = [];

  List<T> get selectedItems => _selectedItems;

  void toggleItem(T item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }
    notifyListeners();
  }

  bool isSelected(T item) => _selectedItems.contains(item);
}
