// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zylu/view_model/providers/image_provider.dart';

class CustomImageDisplay extends StatelessWidget {
  const CustomImageDisplay({
    Key? key,
    required this.kPrimaryBoxColor,
    required this.kBorderRadius,
    required this.context,
    required this.height,
    required this.width,
    required this.photoUrl,
    this.color = Colors.black,
    this.boxColor = Colors.white,
    this.last = false,
    this.iconSize=80,
  }) : super(key: key);

  final Color kPrimaryBoxColor;
  final double kBorderRadius;
  final BuildContext context;
  final double height;
  final double width;
  final Color color;
  final Color boxColor;
  final bool last;
  final double iconSize;
  final String photoUrl;


  Future getImage() async {

    FocusScope.of(context).requestFocus(FocusNode());
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    var getImageProvider = Provider.of<MyImageProvider>(context, listen: false);

    getImageProvider.changeProfilePic(tempImage);
  }



  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Provider.of<MyImageProvider>(
                  context,
                ).getProfilePic() ==
                null
            ? Container(

                height: height,
                width: width,

                decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(kBorderRadius),),
                  image: photoUrl.isNotEmpty ? DecorationImage(
                      image: NetworkImage(
                          photoUrl
                      ),
                      fit: BoxFit.cover
                  ) : null),
                child: photoUrl.isEmpty ?  Icon(
                    Icons.person,
                    size: iconSize,
                  color: color,
                  ) : null,
              )
            : Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
            image: DecorationImage(
              image: Image.file(
                File(Provider.of<MyImageProvider>(
                  context,
                ).getProfilePic()!.path),
              ).image,
              fit: BoxFit.contain
            )
          ),
        ),
        //
        Positioned(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(kBorderRadius),),
              onTap: getImage,
              child: SizedBox(
                height: height,
                width: width,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
