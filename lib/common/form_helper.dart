import 'package:flutter/material.dart';

class FormHelper {
  static infoText(String label, String value){
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              decorationStyle: TextDecorationStyle.wavy,
            ),
          ),
        ],
      ),
    );
  }
  static elevatedButton( String label, Function callback){
    return ElevatedButton(
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: ()=>{callback()},
    );
  }
  static showAlertDialog(BuildContext context, String title, String message) {

    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget loadingScreen(){
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text("Please wait..")
          ]),
    );
  }
  static Widget button(String label, Function callbackFn) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: () => {callbackFn()},
      ),
    );
  }

  static Widget button2(String label, Function callbackFn) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: () => {callbackFn()},
      ),
    );
  }

  static createSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message),
          backgroundColor: Colors.black38);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget buttonIcon(Icon icon, Function callbackFn) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        child: icon,
        onPressed: () => {callbackFn()},
      ),
    );
  }

  static Widget button3(String label, Function callbackFn) {
    return SizedBox(
      child: ElevatedButton(
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: () => {callbackFn()},
      ),
    );
  }

  static Widget passwordField(
      TextEditingController controller,
      String label,
      bool obscureText,
      bool autoFocus,
      TextInputType keyboardType,
      onIconTap,
      TextInputAction textInputAction,
      FocusNode _focusNode) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofocus: autoFocus,
      focusNode: _focusNode,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            onPressed: (onIconTap),
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5)))),
    );
  }

  static Widget inputField(
      TextEditingController controller,
      String label,
      bool obscureText,
      bool autoFocus,
      TextInputType keyboardType,
      TextInputAction textInputAction,
      FocusNode _focusNode) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofocus: autoFocus,
      focusNode: _focusNode,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5)))),
    );
  }
}
