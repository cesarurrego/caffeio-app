import 'package:auto_route/auto_route.dart';
import 'package:caffeio/app/mvvm/view_state.abs.dart';
import 'package:caffeio/app/settings/settings_vm.dart';
import 'package:caffeio/app/settings/widgets/version_card_wd.dart';
import 'package:caffeio/design_system/atoms/buttons/caffeio_button.dart';
import 'package:caffeio/design_system/design_system.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ViewState<SettingsPage, SettingsViewModel> {
  @override
  void initState() {
    super.initState();
    listenToNavigation(viewModel.router);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return StreamBuilder<SettingsPageState>(
      stream: viewModel.state,
      builder: (context, snapshot) {
        final state = snapshot.data ?? const SettingsPageState();
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            width: double.infinity,
            padding: theme.insets.xxs,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: state.userProfile == null,
                  replacement: _UserCard(
                    name: state.userProfile?.email?.split('@').first ?? '',
                    email: state.userProfile?.email ?? '',
                  ),
                  child: Center(
                    child: CaffeioButton(
                      callback: viewModel.onLoginPressed,
                      text: 'Login',
                    ),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: state.userProfile != null,
                  child: Container(
                    alignment: Alignment.center,
                    padding: theme.insets.xs,
                    child: ElevatedButton(
                      onPressed: viewModel.onLogOut,
                      child: const Text('Log out'),
                    ),
                  ),
                ),
                const VersionCard(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UserCard extends StatelessWidget {
  final String name;
  final String email;

  const _UserCard({
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: theme.insets.xs,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ///TODO: Move this logic to vm
                  name,
                  style: theme.typo.title,
                ),
                Text(email),
              ],
            ),
          ),
          const CircleAvatar(
            child: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}
