import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splooking3/components/colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar(
      {Key? key, this.radius = 54, this.borderColor = splatoonColorPink})
      : super(key: key);

  final double radius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(54.w),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.grey[300],
        radius: radius,
        child: Icon(
          Icons.person,
          size: radius * 1.1,
          color: Colors.black26,
        ),
      ),
    );
  }
}

class AvatarAndName extends StatelessWidget {
  const AvatarAndName({
    Key? key, 
    required this.text, 
    this.size = 16, 
    this.fontWeight = FontWeight.w500,
  })
      : super(key: key);

  final String text;
  final double size;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
          radius: size,
          borderColor: Colors.grey[700]!,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
