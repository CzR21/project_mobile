import 'package:flutter/material.dart';

import '../../components/buttons/app_back_buttom_component.dart';
import '../../components/buttons/app_buttom_component.dart';
import '../../components/textfields/app_textfield_component.dart';
import '../../config/app_colors.dart';
import '../../config/app_fonts.dart';
import '../../data/masks/app_masks.dart';

class EsqueciSenhaPage extends StatefulWidget {
  const EsqueciSenhaPage({Key? key}) : super(key: key);

  @override
  State<EsqueciSenhaPage> createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _digito1Controller = TextEditingController();
  final TextEditingController _digito2Controller = TextEditingController();
  final TextEditingController _digito3Controller = TextEditingController();
  final TextEditingController _digito4Controller = TextEditingController();

  final GlobalKey<FormState> _emailFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _digito1Formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _digito2Formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _digito3Formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _digito4Formkey = GlobalKey<FormState>();

  final FocusNode _digito1Focus = FocusNode();
  final FocusNode _digito2Focus = FocusNode();
  final FocusNode _digito3Focus = FocusNode();
  final FocusNode _digito4Focus = FocusNode();

  bool sendCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      floatingActionButton: const AppBackButtomComnponent(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: LayoutBuilder(
          builder: (context, contrains) {
            return SizedBox(
              height: contrains.maxHeight,
              child: Column(
                children: [
                  Builder(
                    builder: (context)  =>  Container(
                      width: double.infinity,
                      height: contrains.maxHeight*2/7,
                      alignment: Alignment.center,
                      child: Container(
                        height: contrains.maxHeight*1/7,
                        alignment: Alignment.bottomCenter,
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Esqueci a senha", style: AppFonts.title.copyWith(color: AppColors.textWhiteColor),),
                              const SizedBox(height: 5,),
                              Text("Informe seu e-mail", style: AppFonts.subTitle.copyWith(color: AppColors.textWhiteColor,), textAlign: TextAlign.center,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(
                      builder: (context)  =>  Container(
                        height: contrains.maxHeight*5/7,
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                visible: !sendCode,
                                child: AppTextFieldComponent(
                                  label: 'email',
                                  controller: _emailController,
                                  individualKey: _emailFormkey,
                                  hint: 'exemplo@email.com',
                                  onEdit: (_) => _emailFormkey.currentState!.validate(),
                                  validator: (_) {
                                    if(_emailController.text.isEmpty){
                                      return 'Campo obrigatório';
                                    }else if(!AppMasks.regex.hasMatch(_emailController.text)){
                                      return 'E-mail inválido';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              Visibility(
                                visible: sendCode,
                                child: LayoutBuilder(
                                  builder: (context, contrains) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: contrains.maxWidth/5,
                                          child: AppTextFieldComponent(
                                            hasErrorText: false,
                                            label: 'Código',
                                            controller: _digito1Controller,
                                            individualKey: _digito1Formkey,
                                            onEdit: (_){
                                              if(_digito1Controller.text.isNotEmpty){
                                                _digito2Focus.requestFocus();
                                              }
                                            },
                                            textAlign: TextAlign.center,
                                            fontSize: 20,
                                            focusNode: _digito1Focus,
                                          ),
                                        ),
                                        SizedBox(
                                          width: contrains.maxWidth/5,
                                          child: AppTextFieldComponent(
                                            hasErrorText: false,
                                            controller: _digito2Controller,
                                            individualKey: _digito2Formkey,
                                            onEdit: (_){
                                              if(_digito2Controller.text.isNotEmpty){
                                                _digito3Focus.requestFocus();
                                              }
                                            },
                                            textAlign: TextAlign.center,
                                            fontSize: 20,
                                            focusNode: _digito2Focus,
                                          ),
                                        ),
                                        SizedBox(
                                          width: contrains.maxWidth/5,
                                          child: AppTextFieldComponent(
                                            hasErrorText: false,
                                            controller: _digito3Controller,
                                            individualKey: _digito3Formkey,
                                            onEdit: (_){
                                              if(_digito3Controller.text.isNotEmpty){
                                                _digito4Focus.requestFocus();
                                              }
                                            },
                                            textAlign: TextAlign.center,
                                            fontSize: 20,
                                            focusNode: _digito3Focus,
                                          ),
                                        ),
                                        SizedBox(
                                          width: contrains.maxWidth/5,
                                          child: AppTextFieldComponent(
                                            hasErrorText: false,
                                            controller: _digito4Controller,
                                            individualKey: _digito4Formkey,
                                            onEdit: (_){
                                              if(_digito4Controller.text.isNotEmpty){
                                                FocusScope.of(context).unfocus();
                                              }
                                            },
                                            textAlign: TextAlign.center,
                                            fontSize: 20,
                                            focusNode: _digito4Focus,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                ),
                              ),

                              const SizedBox(height: 20,),

                              AppButtomComponent(
                                  onPressed: () => _sendCode(),
                                  text: sendCode ? 'Verificar' : 'Enviar código',
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  _sendCode(){
    if(sendCode){
      var validate1 = _digito1Formkey.currentState!.validate();
      var validate2 = _digito2Formkey.currentState!.validate();
      var validate3 = _digito3Formkey.currentState!.validate();
      var validate4 = _digito4Formkey.currentState!.validate();

      if(validate1 && validate2 && validate3 && validate4){

      }
    }else{
      if(_emailFormkey.currentState!.validate()){
        setState(() => sendCode = true);
      }
    }
  }
}
