import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../../../utils/size.dart';

class InquiryShimmer extends StatelessWidget {
  const InquiryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: greyShadow,
        highlightColor: whitePrimary,
        child:Container(
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(
              left: setWidgetWidth(25), right: setWidgetWidth(25), top: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: whitePrimary,
            border: Border.all(width: 1, color: greyShadow),
            boxShadow: const [
              BoxShadow(color: greyShadow, blurRadius: 5, offset: Offset(1, 1))
            ],
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(15),
                        color: greyShadow,
                      ),
                      marginHeight(5),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(15),
                        color: greyShadow,
                      ),
                      marginHeight(12),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(10),
                        color: greyShadow,
                      ),
                      marginHeight(5),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(15),
                        color: greyShadow,
                      ),
                      marginHeight(12),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(10),
                        color: greyShadow,
                      ),
                      marginHeight(5),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(15),
                        color: greyShadow,
                      ),
                      marginHeight(12),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(10),
                        color: greyShadow,
                      ),
                      marginHeight(5),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(14),
                        color: greyShadow,
                      ),
                      marginHeight(12),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(10),
                        color: greyShadow,
                      ),
                      marginHeight(5),
                      Container(
                        width: double.infinity,
                        height: setWidgetHeight(50),
                        color: greyShadow,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    color: greyShadow,
                    width: setWidgetWidth(36),
                    height: setWidgetHeight(36),
                  ),
                )
              ]),
        ));
  }
}
