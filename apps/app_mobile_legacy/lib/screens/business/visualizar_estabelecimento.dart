import 'package:flutter/material.dart';
import 'package:my_app/components/botao_contornado.dart';
import 'package:my_app/components/circulo_com_icone.dart';
import 'package:my_app/components/custom_icon_card_button.dart';
import 'package:my_app/components/custom_list_tag.dart';
import 'package:my_app/components/custom_text.dart';
import 'package:my_app/models/business.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class VisualizarEstabelecimento extends StatefulWidget {
  final String index;

  const VisualizarEstabelecimento({
    super.key,
    required this.index,
  });

  @override
  State<VisualizarEstabelecimento> createState() => _VisualizarEstabelecimentoState();
}

class _VisualizarEstabelecimentoState extends State<VisualizarEstabelecimento> {
  late final Business _estabelecimento;

  @override
  void initState() {
    super.initState();

    _estabelecimento = const Business();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: CustomColors.verde3,
        actions: [
          CustomIconCardButton(
            icon: Icons.share,
            iconColor: CustomColors.verde3,
            onPressed: () => debugPrint('Compartilhar'),
            iconSize: 24.0,
            padding: const EdgeInsets.only(right: 12.0),
          ),
          CustomIconCardButton(
            icon: Icons.favorite_border_outlined,
            iconColor: CustomColors.verde3,
            onPressed: () => debugPrint('Favoritar'),
            iconSize: 24.0,
            padding: const EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              _estabelecimento.images![0].url!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: _estabelecimento.name ?? '',
                      textStyle: Tipografia.titulo3,
                    ),
                    BotaoContornado(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      onTap: () => debugPrint('Ver avaliações'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18.0,
                            color: CustomColors.verde3,
                          ),
                          const SizedBox(width: 4.0),
                          CustomText(
                            text: _estabelecimento.ratingsInfo?.average?.toString() ?? '',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  height: 32.0,
                  child: ListView.builder(
                    itemCount: _estabelecimento.diets?.length ?? 0,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final dieta = _estabelecimento.diets?[index];

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomListTag(
                            label: dieta?.name,
                          ),
                          if (index < _estabelecimento.diets!.length - 1) const SizedBox(width: 8.0),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 32.0,
                  child: ListView.builder(
                    itemCount: _estabelecimento.cookingStyles?.length ?? 0,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final dieta = _estabelecimento.cookingStyles?[index];

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomListTag(
                            label: dieta?.name,
                          ),
                          if (index < _estabelecimento.cookingStyles!.length - 1) const SizedBox(width: 8.0),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _IconeComDescricao(
                      icone: Icons.watch_later_outlined,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _estabelecimento.openNow ?? false ? 'Aberto' : 'Fechado',
                            style: Tipografia.titulo2,
                          ),
                          Text(
                            _estabelecimento.openingHours?[0].toString() ?? 'Não Informado',
                            style: Tipografia.corpo2,
                          ),
                        ],
                      ),
                      onTap: () => debugPrint('Ver horários'),
                    ),
                    const SizedBox(
                      height: 40.0,
                      child: VerticalDivider(
                        width: 32.0,
                        thickness: 1.6,
                        color: CustomColors.cinza1,
                      ),
                    ),
                    _IconeComDescricao(
                      icone: Icons.pin_drop_rounded,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Localização',
                            style: Tipografia.titulo2,
                          ),
                          Text(
                            _estabelecimento.address!.city ?? 'Não Informado',
                            style: Tipografia.corpo2,
                          ),
                        ],
                      ),
                      onTap: () => debugPrint('Ver localização'),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: CustomColors.verde2,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: [
                            Icon(
                              Icons.list_alt,
                              color: CustomColors.verde3,
                            ),
                            CustomText(
                              text: 'Ver todos os contatos',
                              textStyle: Tipografia.corpo2Bold,
                            ),
                          ],
                        ),
                        CustomIconCardButton(
                          icon: Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 36.0,
                  thickness: 1.6,
                  color: CustomColors.cinza1,
                ),
                const Text(
                  'Informações',
                  style: Tipografia.titulo3,
                ),
                const SizedBox(height: 8.0),
                Text(
                  _estabelecimento.description ?? 'Não há informações disponíveis',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconeComDescricao extends StatelessWidget {
  final IconData icone;
  final Widget child;
  final VoidCallback? onTap;

  const _IconeComDescricao({
    required this.icone,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CirculoComIcone(
            icone: icone,
          ),
          const SizedBox(width: 16.0),
          child,
        ],
      ),
    );
  }
}
