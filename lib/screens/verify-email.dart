import 'package:flutter/material.dart';
import '../components/reusable.dart';
import 'new_Password.dart';

class VerifyEmail extends StatefulWidget{
  static const id = '/verify mail';

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _form = GlobalKey<FormState>();

  final _secondDigitFocused = FocusNode();

  final _thirdDigitFocused = FocusNode();

  final _fourthDigitFocused = FocusNode();

  List savedData = [];

  String first ='';

  String second ='';

  String third ='';

  String fourth ='';

  
  void newFirst(value){
 
    first = value; 
  }
  void newSecond(value){

    second = value;
  }
  void newThird(value){

    third = value;
  }
  void newFourth(value){

    fourth = value;
  }
  

  void changed(FocusNode nextField,BuildContext context){
        FocusScope.of(context).requestFocus(nextField);
        
    }

  void _saveForm(){
    _form.currentState!.save();
    savedData = [first,second, third, fourth];
    print(savedData);
  }

  @override
  Widget build(BuildContext context) {
    final businessMail = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: Reusable.appBar(context),
      body: SingleChildScrollView(
              child: Column(
              children: <Widget>[

          Reusable.screenHeader('Verify your Email'),

          const SizedBox(height: 34),

        Stack(
                  children: [
            Container(
            alignment: Alignment.center,
            height: 220,
            width: 220,
            decoration: const BoxDecoration(color: Color(0xFFFDEDBD),shape: BoxShape.circle),
            child: Container(width: 90,height: 90,child: Image.asset('assets/images/message2.png',fit: BoxFit.contain,),),), 
            Positioned(child: Container(height :41, width: 46,child: Image.asset('assets/images/message1.png',fit: BoxFit.contain,),),left: 119,right: 53,top:51,bottom: 127.27,)],
          
        ),

        const SizedBox(height:39),

        Container(
          alignment: Alignment.center,
          child: Text('''
          Please enter the 4-digit code sent to 
                  $businessMail
          ''', 
          style: Reusable.bottomPageWidgetStyle(const Color(0xFF092C4C), 'Inter',FontWeight.w500, 17),)
        ),

        const SizedBox(height: 36),

        Padding(
          padding: const EdgeInsets.only(left: 16, right:16),
          child: Form(
            key: _form,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
              Reusable.verifiedContainer(TextFormField(decoration:const InputDecoration(border: InputBorder.none),keyboardType: TextInputType.number,onChanged: (_) => changed(_secondDigitFocused, context),onSaved: (value) => newFirst(value!)),),
              
              Reusable.verifiedContainer(TextFormField(focusNode: _secondDigitFocused,decoration:const InputDecoration(border: InputBorder.none),keyboardType: TextInputType.number,onChanged: (_) => changed(_thirdDigitFocused, context), onSaved: (value) => newSecond(value!))),
              
              Reusable.verifiedContainer(TextFormField(focusNode: _thirdDigitFocused, decoration:const InputDecoration(border: InputBorder.none),keyboardType: TextInputType.number,onChanged: (_) => changed(_fourthDigitFocused, context), onSaved: (value) => newThird(value!),)),
              
              Reusable.verifiedContainer(TextFormField(focusNode: _fourthDigitFocused,decoration:const InputDecoration(border: InputBorder.none),keyboardType: TextInputType.number,onSaved: (value) => newFourth(value!),onChanged: (_) {_saveForm();Navigator.of(context).pushNamed(NewPassWord.id);},)), 
            ],),
          )
        ),

        const SizedBox(height:40),

        Reusable.elevatedButton('Verify', (){},padding: const EdgeInsets.only(left: 26, right:26),),

        const SizedBox(height:25),

        TextButton(onPressed: (){}, child:Text('Resend code', style: Reusable.bottomPageWidgetStyle(Color(0xFFE2B93B), 'Inter', FontWeight.w500, 18),),),
        
        const SizedBox(height:10)

        ],),
      ),
    );
  }
}
