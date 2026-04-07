import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/bloc/login/login_bloc.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StandardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<LoginBloc>(context),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return AppBar(
            backgroundColor: CustomColors.verde1,
            actionsIconTheme: const IconThemeData(color: Colors.white),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.user != null) ...[
                  CircleAvatar(
                    radius: 16.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 15.0,
                      // backgroundImage: NetworkImage(state.user!.profilePicUrl ?? ''), //TODO FIX THIS
                      backgroundColor: Colors.white,
                      child: state.user!.image == null ? const Icon(Icons.person, color: CustomColors.verde1) : null,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                ],
                Text(
                  state.user != null ? 'Olá, ${state.user!.firstName}' : 'Leve Sabor',
                  style: Tipografia.corpo2Bold.copyWith(color: Colors.white),
                ),
              ],
            ),
            actions: _buildActionsBasedOnState(context, state),
          );
        },
      ),
    );
  }

  List<Widget> _buildActionsBasedOnState(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.loggedIn) {
      return [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => BlocProvider.of<LoginBloc>(context).add(const RequestLogout()),
        ),
      ];
    } else {
      return [
        TextButton(
          onPressed: () => GoRouter.of(context).go('/login'),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.login, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(
                'Login',
                style: Tipografia.corpo2Bold.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      ];
    }
  }
}
