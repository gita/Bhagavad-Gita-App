import 'package:flutter/cupertino.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.pagerIndex,
    required this.totalPages,
  }) : super(key: key);

  final totalPages;
  final int pagerIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < totalPages; i++)
              Row(
                children: [
                  Container(
                    width: pagerIndex == i ? 35 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: pagerIndex == i
                            ? Color.fromRGBO(26, 195, 175, 1)
                            : Color.fromRGBO(209, 243, 239, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
