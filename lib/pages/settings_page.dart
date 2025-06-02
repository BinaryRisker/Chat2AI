import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/theme_store.dart';
import 'package:chat2ai/stores/user_store.dart';
import 'package:chat2ai/widgets/settings_tile.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStoreProvider);
    final userState = ref.watch(userStoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SettingsTile(
            title: 'Theme',
            subtitle: themeState.themeMode.toString().split('.').last,
            icon: Icons.color_lens,
            onTap: () {
              ref.read(themeStoreProvider.notifier).toggleThemeMode();
            },
          ),
          SettingsTile(
            title: 'Primary Color',
            subtitle: themeState.primaryColor.value.toString(),
            icon: Icons.palette,
            onTap: () {
              // 实现打开颜色选择器功能，这里使用 Flutter 的 ColorPicker 组件
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('选择主色'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: themeState.primaryColor.value,
          onColorChanged: (Color color) {
            ref.read(themeStoreProvider.notifier).setPrimaryColor(color);
          },
        ),
      ),
      actions: <Widget>[ 
        TextButton(
          child: const Text('确定'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);
            },
          ),
          const Divider(),
          SettingsTile(
            title: 'Logout',
            subtitle: userState.user?.email ?? '',
            icon: Icons.logout,
            onTap: () {
              ref.read(userStoreProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}