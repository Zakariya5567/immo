import 'package:flutter/material.dart';
import 'package:immo/provider/property_apraisal_provider.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/size.dart';

class AppraisalStepBar extends StatelessWidget {
  const AppraisalStepBar(
      {super.key, required this.steps, this.rightbuttonName});
  final String steps;
  final String? rightbuttonName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setWidgetHeight(130),
      child: Consumer<PropertyAppraisalProvider>(
        builder: (context, propertyAppraisal, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Step 1
              Container(
                height: setWidgetHeight(39),
                width: setWidgetWidth(39),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      steps == '1' ? bluePrimary.withOpacity(0.4) : bluePrimary,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '1',
                    style: textStyle(
                      fontSize: 16,
                      color: whitePrimary,
                      fontFamily: satoshiMedium,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: setWidgetWidth(2), right: setWidgetWidth(2)),
                child: SizedBox(
                  height: setWidgetHeight(2),
                  width: setWidgetWidth(50),
                  child: LinearProgressIndicator(
                    value: 1,
                    color: steps == '1'
                        ? bluePrimary.withOpacity(0.4)
                        : bluePrimary,
                  ),
                ),
              ),
              //Step 2
              Container(
                height: setWidgetHeight(39),
                width: setWidgetWidth(39),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: steps == '2'
                      ? bluePrimary.withOpacity(0.4)
                      : steps == '3'
                          ? bluePrimary
                          : steps == '4' || steps == '5'
                              ? bluePrimary
                              : whiteShadow,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '2',
                    style: textStyle(
                      fontSize: 16,
                      color: steps == '1' ? blackPrimary : whitePrimary,
                      fontFamily: satoshiMedium,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: setWidgetWidth(2), right: setWidgetWidth(2)),
                child: SizedBox(
                  height: setWidgetHeight(2),
                  width: setWidgetWidth(50),
                  child: LinearProgressIndicator(
                    value: 1,
                    color: steps == '3'
                        ? bluePrimary.withOpacity(0.4)
                        : steps == '4' || steps == '5'
                            ? bluePrimary
                            : whiteShadow,
                  ),
                ),
              ),
              // Step 3
              Container(
                height: setWidgetHeight(39),
                width: setWidgetWidth(39),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: steps == '3'
                      ? bluePrimary.withOpacity(0.4)
                      : steps == '4' || steps == '5'
                          ? bluePrimary
                          : whiteShadow,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '3',
                    style: textStyle(
                        fontSize: 16,
                        color: steps == '3'
                            ? whitePrimary
                            : steps == '4' || steps == '5'
                                ? whitePrimary
                                : blackPrimary,
                        fontFamily: satoshiMedium),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: setWidgetWidth(2), right: setWidgetWidth(2)),
                child: SizedBox(
                  height: setWidgetHeight(2),
                  width: setWidgetWidth(50),
                  child: LinearProgressIndicator(
                    value: 1,
                    color: steps == '4'
                        ? bluePrimary.withOpacity(0.4)
                        : steps == '5'
                            ? bluePrimary
                            : whiteShadow,
                  ),
                ),
              ),
              //Step 4
              Container(
                height: setWidgetHeight(39),
                width: setWidgetWidth(39),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: steps == '4'
                      ? bluePrimary.withOpacity(0.4)
                      : propertyAppraisal.currentStep == 5
                          ? bluePrimary
                          : whiteShadow,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '4',
                    style: textStyle(
                        fontSize: 16,
                        color: steps == '4' || steps == '5'
                            ? whitePrimary
                            : blackPrimary,
                        fontFamily: satoshiMedium),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
