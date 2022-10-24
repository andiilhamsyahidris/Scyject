import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scyject/common/constant.dart';

class CustomInformation extends StatelessWidget {
  final String imgPath;
  final String title;
  final String subtitle;

  const CustomInformation({
    required this.imgPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: SizedBox(
        width: 300,
        height: 450,
        child: Column(
          children: <Widget>[
            Flexible(
              child: SvgPicture.asset(
                imgPath,
                width: 150,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: kDeepBlue, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Flexible(
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
