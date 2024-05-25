import 'package:flutter/material.dart';
import 'dart:io';
import 'package:widget_mask/widget_mask.dart';
import 'package:google_fonts/google_fonts.dart';

class Maskimage extends StatefulWidget {
  final File image;

  const Maskimage({Key? key, required this.image}) : super(key: key);

  @override
  State<Maskimage> createState() => _MaskimageState();
}

class _MaskimageState extends State<Maskimage> {
  String _selectedImage = "";

  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
    backgroundColor: Colors.black54,

    body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height*0.1,horizontal: width*0.06),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(width*0.05)), color: Colors.white,
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: width*0.5,top: height*0.01),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF12827a),
                          borderRadius: BorderRadius.all(Radius.circular(width*0.1))
                        ),
                        child: IconButton(
                          onPressed: () { Navigator.of(context).pop();},
                          icon: Icon(Icons.close,
                                color: const Color(0xFFFFFFFF),
                                size: height * 0.03),
                          ),
                      ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Uploaded Image',
                          style: GoogleFonts.abhayaLibre(
                              color: Color(0xFF12827a),
                              fontSize: height > width
                                  ? height * 0.025
                                  : height * 0.05),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:height*0.01),
                      child: Row(
                        children: [
                          _buildMaskedImage(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.01,right: width*0.01,top: height*0.016),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton(""),
                          _buildButton('user_image_frame_1.png'),
                          _buildButton('user_image_frame_2.png'),
                          _buildButton('user_image_frame_3.png'),
                          _buildButton('user_image_frame_4.png'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.15,right: width*0.15,top: height*0.015,bottom: height*0.01),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {Navigator.of(context).pop(_selectedImage);},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF12827a)),
                          child: Text(
                            'Use This image',
                            style: GoogleFonts.roboto(
                                color: Color(0xFFFFFFFF),
                                fontSize: height * 0.02),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    ),
  );}

  Widget _buildMaskedImage() {

    final width = MediaQuery.of(context).size.width * 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.1),
      child: Container(
        color: Colors.white,
        width: width*0.66,
        child: WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Image.file(widget.image),
          child: _selectedImage==""? Image.file(widget.image):Image.asset('images/${_selectedImage}',fit: BoxFit.contain,),
        ),
      ),
    );
  }

  Widget _buildButton(String image) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedImage = image;
        });
      },
      child: Container(
        width: width*0.16,
        height: height*0.05,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF848484)),
          borderRadius: BorderRadius.all(Radius.circular(width * 0.015)),
        ),
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal:width*.004,vertical: height*0.001),
         child: Center(
           child: image==""?Text('Original',style:GoogleFonts.abhayaLibre(
               color: Color(0xFF12827a),
               fontSize: height * 0.015,fontWeight: FontWeight.w900),):Image.asset('images/${image}',),
         ),
       ),)
      );
  }
}
