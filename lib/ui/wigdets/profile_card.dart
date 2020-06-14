import 'package:flutter/material.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard({Key key, @required this.profileUrl,@required this.title,@required this.subTitle,@required this.isFollow,@required this.onTabFollowButton}) : super(key: key);
  final String profileUrl;
  final String title;
  final String subTitle;
  final bool isFollow;
  final VoidCallback onTabFollowButton;
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  AppTheme _appTheme;
  Localizer _localizer;

  @override
  void didChangeDependencies() {
    _appTheme = Provider.of<AppTheme>(context);
    _localizer = Localizer.of(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.5),
      elevation: 0.5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage(widget.profileUrl),
          ),
          title: Text(
           widget.title,
            style: _appTheme.data.textTheme.subtitle1
                .copyWith(color: _appTheme.colors.fontDark, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          subtitle: Text(widget.subTitle),
          trailing: widget.isFollow == true
              ? _followButton(
                  backcolor: _appTheme.colors.canvasDark,
                  value:_localizer.unfollow,
                )
              : _followButton(textColor: _appTheme.colors.fontLight, value: _localizer.follow)),
    );
  }

   Widget _followButton({Color backcolor, Color textColor, String value}) {
    return GestureDetector(
      onTap: widget.onTabFollowButton,      
      child:   Container(
      height: 35,
      width: 100,
      decoration: BoxDecoration(      
        color: backcolor,
        borderRadius: _appTheme.data.buttonBorderRadius(),
        gradient: backcolor == null ? WhiteThemeUtils.linearGradient() : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Center(
          child: Text(
            value,
            style: _appTheme.data.textTheme.caption.copyWith(color: textColor, fontSize: 11),
          ),
        ),
      ),
    )
    );
  }

}