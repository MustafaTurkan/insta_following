import 'package:flutter/material.dart';
import 'package:insta_following/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:insta_following/helpers/extensions/string_extensions.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key key, this.title, this.subTitle, this.images, this.onPressed}) : super(key: key);
  final String title;
  final String subTitle;
  final List<Widget> images;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Column(
            children: <Widget>[
              if (!title.isNullOrEmpty()) ...[
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: appTheme.data.textTheme.subtitle1
                          .copyWith(color: appTheme.colors.fontDark, fontWeight: FontWeight.bold),
                    )),
                Divider(),
              ],
              if (!subTitle.isNullOrEmpty()) ...[
                Padding(
                  padding: title.isNullOrEmpty() ? const EdgeInsets.all(10) : const EdgeInsets.all(5),
                  child: Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: appTheme.data.textTheme.bodyText2
                        .copyWith(color: appTheme.colors.font, fontWeight: FontWeight.normal),
                  ),
                ),
                Divider(),
              ],
              if (images != null) ...[
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(images.length, (index) {
                          return CircleAvatar(
                              backgroundColor: appTheme.colors.canvas, radius: 10, child: images[index]);
                        })))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
