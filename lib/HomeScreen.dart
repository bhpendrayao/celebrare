import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:celebrare/mask.dart';
import 'package:widget_mask/widget_mask.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   File? fimage;
   String? selectedImage;
   String? checker;
  Future getImage () async{
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }else {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          uiSettings: [
            AndroidUiSettings(
                showCropGrid: true,
                activeControlsWidgetColor: Colors.blueGrey,
                backgroundColor: Colors.blueGrey,
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.black87,
                toolbarWidgetColor: Colors.white,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
          compressQuality: 100,);
        final selectedImage = await Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                Maskimage(image: File(croppedFile!.path)),
          ),
        );
               if(selectedImage!=null) {
                 setState(() {
                   print("idhr aya hoon ${selectedImage}");
                   this.selectedImage = selectedImage;
                   this.checker = selectedImage;
                   if (selectedImage != null) {
                     fimage = File(croppedFile!.path);
                   }
                 });
               }
               else{
                 setState(() {
                   this.checker = selectedImage;
                   print('${this.selectedImage}');
                 });

               }
      }
    } on PlatformException catch (e){
      print("failed ${e}");
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp,
                color: Color(0xFF12827a),
                size: height > width ? height * 0.04 : height * 0.1),
            onPressed: () => SystemNavigator.pop()),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Image / Icon',
              style: GoogleFonts.abhayaLibre(
                  color: Color(0xFF12827a),
                  fontSize: height > width ? height * 0.03 : height * 0.05),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.05,right: width * 0.05,top: height*0.03),
              child: Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF848484)),
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.03)),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload Image',
                          style: GoogleFonts.abhayaLibre(
                              color: Color(0xFF12827a),
                              fontSize: height > width
                                  ? height * 0.025
                                  : height * 0.05),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {getImage();},
                          child: Text(
                            'Choose from Device',
                            style: GoogleFonts.roboto(
                                color: Color(0xFFFFFFFF),
                                fontSize: height > width
                                    ? height * 0.024
                                    : height * 0.05),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF12827a)),
                        ),
                      ],
                    )
                  ],
                )),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width*0.03,right: width*0.03,top: height*0.02),
                  child: SizedBox(
                    width: width*0.94,
                    child:fimage!=null ? checker==null?Container(
                      color: Colors.white,
                      child: WidgetMask(
                        blendMode: BlendMode.srcATop,
                        childSaveLayer: true,
                        mask: Image.file(fimage!),

                        child:selectedImage==""?Image.file(fimage!):Image.asset('images/${selectedImage}', fit: BoxFit.cover),
                      ),
                    ):selectedImage==""?Image.file(fimage!,fit: BoxFit.cover,):Container(
                      color: Colors.white,
                      child: WidgetMask(
                        blendMode: BlendMode.srcATop,
                        childSaveLayer: true,
                        mask: Image.file(fimage!),
                        child: Image.asset('images/${selectedImage}', fit: BoxFit.cover),
                      ),
                    ):Container(),
                    // child:fimage!=null?(Image.file(fimage!,fit: BoxFit.cover,)):Container(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
