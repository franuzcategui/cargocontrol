import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class InfoDescription extends StatelessWidget {
  final List<dynamic> jsonObject;
  final String title;
  const InfoDescription(
      {required this.jsonObject, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const constants.TextStyles().infoTitle1,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: jsonObject.length,
                itemBuilder: ((context, index) {
                  final item = jsonObject[index];
                  final title = item['title'];
                  final description = item['description'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const constants.TextStyles().bodyText1,
                        ),
                        Text(
                          description,
                          style: const constants.TextStyles().bodyText1,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
