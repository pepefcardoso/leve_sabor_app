import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:my_app/bloc/business_index/business_index_bloc.dart';
import 'package:my_app/components/standard_app_bar.dart';
import 'package:my_app/components/item_lista_estabelecimentos.dart';
import 'package:my_app/components/search_field_and_button.dart';
import 'package:my_app/models/business.dart';
import 'package:my_app/services/business_service.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class BusinessesIndex extends StatefulWidget {
  const BusinessesIndex({super.key});

  @override
  State<BusinessesIndex> createState() => _BusinessesIndexState();
}

class _BusinessesIndexState extends State<BusinessesIndex> {
  late final BusinessIndexBloc _bloc;
  final KiwiContainer container = KiwiContainer();

  late final BusinessService _businessService;

  @override
  void initState() {
    super.initState();

    _businessService = container.resolve<BusinessService>();

    _bloc = BusinessIndexBloc(_businessService);

    _bloc.add(const RequestBusinesses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const StandardAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 8.0),
        child: BlocProvider.value(
          value: _bloc,
          child: BlocBuilder<BusinessIndexBloc, BusinessIndexState>(
            builder: (context, state) {
              if (state.status == BusinessIndexStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Buscar', style: Tipografia.titulo1),
                  const SizedBox(height: 12.0),
                  SearchFieldAndButton(
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 16.0),
                  if (state.count == 0) ...[
                    const Text('Nenhum estabelecimento encontrado', style: Tipografia.corpo2),
                    const SizedBox(height: 12.0),
                  ] else ...[
                    Text('${state.count} encontrados', style: Tipografia.corpo2),
                    const SizedBox(height: 12.0),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.count,
                        itemBuilder: (context, index) {
                          final Business business = state.businesses[index];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ItemListaEstabelecimentos(
                                estabelecimento: business,
                                onTap: () => GoRouter.of(context).go('/businesses/${business.id}'),
                              ),
                              const Divider(
                                height: 32.0,
                                thickness: 1.0,
                                color: CustomColors.cinza1,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
