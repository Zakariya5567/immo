import 'package:flutter/material.dart';
import 'package:immo/provider/post_an_ad_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';

class AdCheckBox extends StatefulWidget {
  const AdCheckBox({super.key, required this.name});
  final String name;

  @override
  State<AdCheckBox> createState() => _AdCheckBoxState();
}

class _AdCheckBoxState extends State<AdCheckBox> {
  @override
  Widget build(BuildContext context) {
    final postAdProvider =
        Provider.of<PostAnAdProvider>(context, listen: false);
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (postAdProvider.checkValues.containsKey(widget.name)) {
              postAdProvider.setCheckBoxValue(widget.name);
              debugPrint(
                  "This is Check Box Value.............  :${widget.name} ,${postAdProvider.checkValues[widget.name]}");
            }
          },
          child: (postAdProvider.checkValues[widget.name] ?? false)
              ? const Icon(
                  Icons.check_box,
                  size: 30.0,
                  color: bluePrimary,
                )
              : const ImageIcon(
                  AssetImage(
                    Images.iconCheckboxUnfilled,
                  ),
                  size: 30,
                ),
        ),
        marginWidth(13),
        Consumer<LanguageProvider>(
          builder: (context, language, child) {
            return Text(
              translate(
                context,
                language.languageCode,
                widget.name,
              )!,
              style: textStyle(
                fontSize: 14,
                color: blackPrimary,
                fontFamily: satoshiRegular,
              ),
            );
          },
        ),
      ],
    );
  }
}
