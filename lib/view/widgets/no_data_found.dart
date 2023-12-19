import 'package:flutter/cupertino.dart';
import 'package:immo/localization/app_localizations.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../provider/language_provider.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<LanguageProvider>(
        builder: (context, language, child) {
          return Text(translate(context, language.languageCode, noDataFound)!);
        },
      ),
    );
  }
}
