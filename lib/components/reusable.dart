import 'package:flutter/material.dart';


class Reusable{
  
  static Widget displayTextPlusSizedBox(String text) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              color: Color(0xFF092c4c)),
        ),
        SizedBox(height: 8)
      ],
    );
  }

  static Widget container(Widget child) {
    return Container(
      margin: EdgeInsets.only(left:5),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: child,
    );
  }

  static TextStyle bottomPageWidgetStyle(
      Color color, String font, FontWeight weight, double size) {
    return TextStyle(
        color: color, fontFamily: font, fontSize: size, fontWeight: weight);
  }

  static Widget infoText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF092c4c),
      ),
    );
  }

  static AppBar appBar(BuildContext context){
    return AppBar(
          backgroundColor: const Color(0xFFE5E5E5),
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.chevron_left),
            color: const Color(0xFF092c4c),
          ),);
  }
  static void saved(String givenValue, String saveValue){
    saveValue=givenValue;
  }

  static Widget elevatedButton(String text,Function saveFunction){
    return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            height: 62,
                            width: 323,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF092C4C)),
                              onPressed: () {
                                saveFunction();
                              },
                              child: Text(
                                text,
                                style: Reusable.bottomPageWidgetStyle(
                                    Color(0xFFFFFFFF),
                                    'Inter',
                                    FontWeight.w700,
                                    18),
                              ),
                            ),
                          );
  }
  static Widget openContainer(String text1,String text2,Function function){
    return Container(
                            height: 62,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFF092C4C))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  text1,
                                  style: Reusable.bottomPageWidgetStyle(
                                      Color(0xFF092C4C),
                                      'Inter',
                                      FontWeight.w700,
                                      18),
                                ),
                                TextButton(
                                  onPressed: function as Function(),
                                  child: Text(
                                    text2,
                                    style: Reusable.bottomPageWidgetStyle(
                                        Color(0xFFE2B93B),
                                        'Inter',
                                        FontWeight.w700,
                                        18),
                                  ),
                                )
                              ],
                            ),
                          );
  }
  static dynamic businessValidationCheck(String value) {
    if(value.isEmpty){
      return 'Name cannot be left blank';
    } 
    return null;
  }
  static dynamic emailValidationCheck(String value){
    if(value.isEmpty){
      return 'Mail Address cannot be left blank ';
    }
    if(!value.endsWith('@gmail.com')){
      return 'Enter a valid Email address';
    }
    return null;
  }
  static dynamic passwordValidationCheck(String value){
    if(value.isEmpty){
      return 'Please create your password';
    }
    if(value.length<6){
      return 'PassWord Characters must be greater than six';
    }
    return null;
  }

  static whatsAppValidationCheck(String value){
    if(value.length< 10 || value.length>10){
      return 'Enter a valid WhatsApp number';
    }
    if(value.isEmpty){
      return 'Please Enter Your WhatsApp number';
    } return null;
  }

  static dynamic addressValidator(String value){
    if(value.isEmpty){
      return 'Please Enter your address';
    }return null;
  }

  static dynamic descriptionValidator(String value){
    if(value.isEmpty){
      return 'Please Enter Product Description';
    }
    if(value.length>500){
      return 'Description has exceeded 500 words';
    }
    return null;
  }
}