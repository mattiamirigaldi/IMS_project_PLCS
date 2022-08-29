import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  const ProfileWidget({
    Key? key,
    required this.imagePath,
    //Note: by not using required now the var che be initalized with default one
    // isEdit used to build different profile UI if we are in the setting page
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Center(
      child: Stack(
        // Stack allows to put multiple widget on top of each other
        children : [
          buildImage(),
          // on top of image place the edit button
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon()) ,
          ]),
    ); 
  }

  // oval picture
  Widget buildImage() {
  final image = NetworkImage(imagePath);

  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image,
        width: 100,
        height: 100,
        // to create a splash effect when image clicked
        child: InkWell(onTap: onClicked),
        ),
    ),
  );
}
  // edit button
  Widget buildEditIcon() => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: Colors.blue,
      all: 8,
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.edit,
        color: Colors.white,
        size: 20,),
    ),
  );
  
  Widget buildCircle({
    required color, 
    required double all, 
    required Widget child}) => 
    ClipOval(
      child: Container(
        color: color,
        padding: EdgeInsets.all(all),
        child: child,
      ),
    );
}


