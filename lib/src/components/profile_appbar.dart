import 'package:flutter/material.dart';

class ProfileAppBar extends SliverPersistentHeaderDelegate {
  ProfileAppBar(
      {required this.expandedHeight,
      this.leading,
      this.title,
      this.avatarImage,
      this.backgroundImage,
      this.onAvatarTap});

  final double expandedHeight;
  final ImageProvider<Object>? avatarImage;
  final Widget? backgroundImage;
  final Widget? title;
  final Widget? leading;
  final Function()? onAvatarTap;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: SizedBox(
            height: expandedHeight,
            child: ColoredBox(
              color: Colors.white,
              child: Opacity(
                  opacity: (1 - shrinkOffset / expandedHeight),
                  child: backgroundImage),
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            left: 10,
            right: 10,
            child: Row(
              children: [
                if (leading != null) leading!,
                if (title != null)
                  Opacity(
                      opacity: shrinkOffset == expandedHeight ? 1 : 0,
                      child: title!),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            )),
        Positioned(
          bottom: -50,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: GestureDetector(
              onTap: onAvatarTap,
              child: CircleAvatar(
                radius: 75,
                backgroundImage: avatarImage,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
