import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/colors.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  return Stack(
    children: <Widget>[
      pageFrame(
        context: context,
        padding: EdgeInsets.zero,
        children: [
          pageNavBar(
            FlutterI18n.translate(context, 'language'),
            padding: const EdgeInsets.all(20),
            onTap: () => Navigator.of(context).pop(),
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) =>
                _item(
                    name: 'Auto Detect',
                    type: AppLanguage.auto,
                    value: s.language,
                    onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.auto, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'English',
                type: AppLanguage.en,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.en, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: '简体中文',
                type: AppLanguage.zh_Hans_CN,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.zh_Hans_CN, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: '繁体中文',
                type: AppLanguage.zh_Hant_TW,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.zh_Hant_TW, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: '한국어',
                type: AppLanguage.ko,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.ko, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Türkçe',
                type: AppLanguage.tr,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.tr, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Deutsch',
                type: AppLanguage.de,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.de, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: '日本語',
                type: AppLanguage.ja,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.ja, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Русский',
                type: AppLanguage.ru,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.ru, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Español',
                type: AppLanguage.es,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.es, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Portugués',
                type: AppLanguage.pt,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.pt, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Indonesio',
                type: AppLanguage.id,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.id, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Tagalog',
                type: AppLanguage.tl,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.tl, context))),
          Divider(),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.language != b.language,
            builder: (ctx, s) => _item(
                name: 'Tiếng Việt',
                type: AppLanguage.vi,
                value: s.language,
                onTap: () => context.read<SettingsCubit>().updateLanguage(AppLanguage.vi, context))),
        ],
      ),
    ],
  );
}

  Widget _item({String name = '', String type, String value, Function onTap}) {
    return listItem(name,
        trailing: Icon(
          Icons.done,
          color: (type == 'auto' && (value == null)) || type == value
              ? selectedColor
              : Colors.grey,
          size: 28,
        ),
        onTap: onTap);
  }
}