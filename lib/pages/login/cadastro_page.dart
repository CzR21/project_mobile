import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_mobile/blocs/autenticacao/autenticacao_bloc.dart';
import 'package:project_mobile/blocs/autenticacao/autenticacao_state.dart';
import 'package:project_mobile/components/buttons/app_back_buttom_component.dart';
import 'package:project_mobile/data/models/usuario_model.dart';
import 'package:project_mobile/helpers/toasty_helper.dart';
import 'package:uuid/uuid.dart';

import '../../components/buttons/app_buttom_component.dart';
import '../../components/textfields/app_textfield_component.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_fonts.dart';
import '../../data/masks/app_masks.dart';

class CadastroPage extends StatefulWidget {

  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final AutenticacaoBloc _autenticacaoBloc = AutenticacaoBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _nameFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPasswordFormkey = GlobalKey<FormState>();

  bool visibleText = false;
  bool visibleText2 = false;
  bool loading = false;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

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
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Cadastre-se", style: AppFonts.title.copyWith(color: AppColors.textWhiteColor),),
                              const SizedBox(height: 5,),
                              Text("Inscreva-se para começar", style: AppFonts.subTitle.copyWith(color: AppColors.textWhiteColor,), textAlign: TextAlign.center,),
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
                              AppTextFieldComponent(
                                label: 'nome',
                                controller: _nameController,
                                individualKey: _nameFormkey,
                                onEdit: (_) => _nameFormkey.currentState!.validate(),
                                validator: (_) {
                                  if(_nameController.text.isEmpty){
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20,),

                              AppTextFieldComponent(
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

                              const SizedBox(height: 20,),

                              AppTextFieldComponent(
                                label: 'senha',
                                controller: _passwordController,
                                individualKey: _passwordFormkey,
                                suffixIcon: visibleText ? AppAssets.visibilityOffIcon : AppAssets.visibilityOnIcon,
                                suffixIconOnTap: () => setState(() => visibleText = !visibleText),
                                obscureText: !visibleText,
                                onEdit: (_) => _passwordFormkey.currentState!.validate(),
                                validator: (_) {
                                  if(_passwordController.text.isEmpty){
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20,),

                              AppTextFieldComponent(
                                label: 'confirmar senha',
                                controller: _confirmPasswordController,
                                individualKey: _confirmPasswordFormkey,
                                suffixIcon: visibleText2 ? AppAssets.visibilityOffIcon : AppAssets.visibilityOnIcon,
                                suffixIconOnTap: () => setState(() => visibleText2 = !visibleText2),
                                obscureText: !visibleText2,
                                onEdit: (_) => _confirmPasswordFormkey.currentState!.validate(),
                                validator: (_) {
                                  if(_confirmPasswordController.text.isEmpty){
                                    return 'Campo obrigatório';
                                  }else if(_confirmPasswordController.text != _passwordController.text){
                                    return 'As senhas não conhecidem';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20,),
                              GestureDetector(
                                onTap: _showImageSourceDialog,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  height: 150,
                                  width: 150,
                                  child: _imageFile == null
                                      ? Icon(Icons.camera_alt,
                                          color: Colors.grey[800], size: 50)
                                      : Image.file(File(_imageFile!.path)),
                                ),
                              ),
                              const SizedBox(height: 20,),

                              AppButtomComponent(
                                onPressed: () => _registrar(),
                                text: 'Registrar',
                                loading: loading,
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

  Future<void> _showImageSourceDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha a origem da imagem'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Câmera'),
              onTap: () {
                Navigator.of(context).pop();
                _takePicture();
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Galeria'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      print('Erro ao tirar a foto: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      print('Erro ao escolher a imagem: $e');
    }
  }

  _registrar(){
    var validate1 = _nameFormkey.currentState!.validate();
    var validate2 = _emailFormkey.currentState!.validate();
    var validate3 = _passwordFormkey.currentState!.validate();
    var validate4 = _confirmPasswordFormkey.currentState!.validate();

    if(validate1  && validate2 && validate3 && validate4){
      setState(() => loading = true);

      final model = UsuarioModel(
          id: const Uuid().v4().toString(),
          nome: _nameController.text,
          email: _emailController.text,
          dataCadastro: DateTime.now().toString(),
          imagemUrl: "",
      );

      _autenticacaoBloc.add(CadastroEvent(model: model, senha: _passwordController.text, imagem: _imageFile != null? _imageFile!.path: ""));
      _autenticacaoBloc.stream.listen((event) {
        if(event is SuccessCadastroState){
          ToastHelper.showMessage(context: context, messageType: MessageType.success, message: "Cadastros realizado com sucesso");
          Navigator.of(context).pop();
        }else if(event is ErrorCadastroState){
          if(event.erro.message == "email-already-in-use")  ToastHelper.showMessage(context: context, messageType: MessageType.error, message: "Usuário já cadastrado");
          if(event.erro.message == "weak-password") ToastHelper.showMessage(context: context, messageType: MessageType.error, message: "Senha deve conter mais de 6 caracteres");
          setState(() => loading = false);
        }
      });
    }
  }
}
