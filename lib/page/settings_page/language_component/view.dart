import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LanguageState state, Dispatch dispatch, ViewService viewService) {
 return pageFrame(
    context: viewService.context,
    padding: EdgeInsets.zero,
    children: [
      pageNavBar(
        FlutterI18n.translate(viewService.context,'language'),
        padding: const EdgeInsets.all(20),
        onTap: () => Navigator.of(viewService.context).pop()
      ),
      _item(
        name: 'Auto Detect',
        type: AppLanguage.auto,
        value: state.language,
        onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.auto))
      ),
      Divider(),
      _item(
          name: 'English',
          type: AppLanguage.en,
          value: state.language,
          onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.en))
      ),

      Divider(),
      _item(
        name: '简体中文',
        type: AppLanguage.zh_Hans_CN,
        value: state.language,
        onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.zh_Hans_CN))
      ),
      Divider(),
      _item(
          name: '繁体中文',
          type: AppLanguage.zh_Hant_TW,
          value: state.language,
          onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.zh_Hant_TW))
      ),
      Divider(),
      _item(
        name: '한국어',
        type: AppLanguage.ko,
        value: state.language,
        onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.ko))
      ),
      Divider(),
      _item(
          name: 'Türkçe',
          type: AppLanguage.tr,
          value: state.language,
          onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.tr))
      ),
      Divider(),
      _item(
          name: 'Deutsch',
          type: AppLanguage.de,
          value: state.language,
          onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.de))
      ),
      Divider(),
      _item(
          name: '日本語',
          type: AppLanguage.ja,
          value: state.language,
          onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.ja))
      ),
      Divider(),
      _item(
          name: 'Русский',
          type: AppLanguage.ru,
          value: state.language,
          onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.ru))
      ),

      Divider(),
      _item(
          name: 'Tiếng Việt',
          type: AppLanguage.vi,
          value: state.language,
          onTap: () => dispatch(LanguageActionCreator.onChange(AppLanguage.vi))
      ),
    ]
  );
}

Widget _item({String name = '',String type,String value = '',Function onTap}){
  return listItem(
    name,
    trailing: Icon(
      Icons.done,
      color: (type == 'auto' && ( value == null  || value.isEmpty || value == 'auto' ) ) || type == value ? selectedColor : Colors.grey,
      size: 28,
    ),
    onTap: onTap
  );
}
