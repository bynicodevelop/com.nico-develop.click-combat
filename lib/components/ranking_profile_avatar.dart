import 'package:com_nico_develop_click_combat/helpers/svc_wrapper.dart';
import 'package:com_nico_develop_click_combat/widgets/svg_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';

class RankingProfileAvatar extends StatefulWidget {
  final String username;

  const RankingProfileAvatar({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<RankingProfileAvatar> createState() => _RankingProfileAvatarState();
}

class _RankingProfileAvatarState extends State<RankingProfileAvatar> {
  DrawableRoot? _drawableRoot;

  Future<DrawableRoot> _generateSvgRoot(String id) async =>
      SvgWrapper(multiavatar(id)).generateLogo();

  @override
  void initState() {
    super.initState();

    _generateSvgRoot(widget.username).then((drawableRoot) {
      setState(() {
        _drawableRoot = drawableRoot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _drawableRoot != null
        ? Container(
            constraints: const BoxConstraints(
              minWidth: 45,
              minHeight: 45,
            ),
            child: SvgAvatar(
              size: 45.0,
              svgRoot: _drawableRoot!,
            ),
          )
        : Container();
  }
}
