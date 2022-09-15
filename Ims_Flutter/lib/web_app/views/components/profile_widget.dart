import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
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
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late String newUrlImage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
          // Stack allows to put multiple widget on top of each other
          children: [
            buildImage(),
            // on top of image place the edit button
            Positioned(bottom: 0, right: 4, child: buildEditIcon()),
          ]),
    );
  }

  // oval picture
  Widget buildImage() {
    final image = NetworkImage(widget.imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          width: 100,
          height: 100,
          // when image tapped will pop up a dialog box to insert url of new image
          child: InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Enter url of new image"),
                content: TextFormField(
                  decoration: const InputDecoration(hintText: 'url image'),
                  onChanged: (value){
                    newUrlImage = value;
                  },
                  validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: const Text("SUBMIT")
                  )
                ],
              ),
            )
            
            ),
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
        widget.isEdit ? Icons.add_a_photo : Icons.edit,
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

