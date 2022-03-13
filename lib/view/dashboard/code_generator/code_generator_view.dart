import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:mikrotik_manager/view/dashboard/code_generator/code_generator_controller.dart';

class CodeGeneratorView extends StatefulWidget {
  const CodeGeneratorView({Key? key}) : super(key: key);

  @override
  State<CodeGeneratorView> createState() => _CodeGeneratorViewState();
}

class _CodeGeneratorViewState extends State<CodeGeneratorView> {
  CodeGeneratorController codeGenController = CodeGeneratorController();
  @override
  Widget build(BuildContext context) {
    codeGenController.size.text = '10';
    codeGenController.time.text = '1';

    return SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Center(child: Text("Code Generator V2", style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: 50,
                      child: FormHelper.inputField(codeGenController.size, "Count", false, false, TextInputType.number,
                          TextInputAction.done, codeGenController.sizeFocus),
                    ),),
                    const SizedBox(width: 10,),
                    Expanded(child: SizedBox(
                      height: 50,
                      child: FormHelper.inputField(codeGenController.time, "Time", false, false, TextInputType.number,
                          TextInputAction.done, codeGenController.timeFocus),
                    ),),
                    const SizedBox(width: 10,),
                    FormHelper.button2("Generate", (){
                      codeGenController.generate();
                    }),
                    const SizedBox(width: 10,),
                    FormHelper.buttonIcon(const Icon(Icons.copy_all), () async {
                      await Clipboard.setData(ClipboardData(text: codeGenController.codes.join('\n')));
                      FormHelper.createSnackBar(context, "Copied");
                    })
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    width: double.infinity,
                      color: Colors.black12,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: codeGenController.codes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(codeGenController.codes[index]),
                          );
                        }),
                  ),
                )
              ],
            ),
          )
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeGenController.setStateCallback = () {
      setState(() {
      });
    };
  }
}
