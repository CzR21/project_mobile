import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_mobile/blocs/endereco/endereco_bloc.dart';
import 'package:project_mobile/blocs/endereco/endereco_state.dart';
import 'package:project_mobile/components/buttons/app_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_icon_buttom_component.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_contansts.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:project_mobile/data/masks/app_masks.dart';
import 'package:project_mobile/data/models/endereco_model.dart';
import 'package:project_mobile/helpers/toasty_helper.dart';
import 'package:project_mobile/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

import '../../components/textfields/app_textfield_component.dart';

class CadastrarEnderecoPage extends StatefulWidget {
  const CadastrarEnderecoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarEnderecoPage> createState() => _CadastrarEnderecoPageState();
}

class _CadastrarEnderecoPageState extends State<CadastrarEnderecoPage> {

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _longadouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  final GlobalKey<FormState> _cepFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _numerokey = GlobalKey<FormState>();

  bool loading = false;

  final EnderecoBloc _bloc = EnderecoBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, contrais) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: contrais.maxWidth/3,
                        child: AppTextFieldComponent(
                          label: 'CEP',
                          controller: _cepController,
                          individualKey: _cepFormkey,
                          textInputType: TextInputType.number,
                          formatters: [
                            AppMasks.cepMask
                          ],
                          onEdit: (_) {
                            _cepFormkey.currentState!.validate();
                            if(_cepController.text.length == 9){
                              _buscarCep();
                            }
                          },
                          validator: (_) {
                            if(_cepController.text.isEmpty){
                              return 'Campo obrigatório';
                            }else if(UtilData.removeCaracteres(_cepController.text).length != 8){
                              return 'CEP inválido';
                            }
                            return null;
                          },
                        ),
                      ),
        
                      SizedBox(
                        width: contrais.maxWidth/3,
                        child: Text("Ou ulilize sua localização atual", style: AppFonts.regularDefault, textAlign: TextAlign.center,),
                      ),
        
                      AppIconButtomComponent(
                          icon: AppAssets.locationIcon,
                          color: AppColors.orangeDarkColor,
                          backgroundColor: Colors.white,
                          width: 45,
                          iconWidth: 20,
                          borderRadios: 15,
                          borderColor: AppColors.orangeDarkColor,
                          function: () => _obterLocalizacaoAtual()
                      )
                    ],
                  );
                }
              ),
        
              const SizedBox(height: 20,),
        
              AppTextFieldComponent(
                label: 'Longadouro',
                enable: false,
                controller: _longadouroController,
              ),
        
              const SizedBox(height: 20,),
        
              LayoutBuilder(
                builder: (context, contrains) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: contrains.maxWidth*2/5 - 20,
                        child: AppTextFieldComponent(
                          label: 'número',
                          controller: _numeroController,
                          individualKey: _numerokey,
                          textInputType: TextInputType.number,
                          onEdit: (_) => _numerokey.currentState!.validate(),
                          validator: (_) {
                            if(_numeroController.text.isEmpty){
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
        
                      const SizedBox(height: 20,),
        
                      SizedBox(
                        width: contrains.maxWidth*3/5 - 20,
                        child: AppTextFieldComponent(
                          label: 'complemento',
                          controller: _complementoController,
                        ),
                      ),
                    ],
                  );
                }
              ),
        
              const SizedBox(height: 20,),
        
              AppTextFieldComponent(
                label: 'Bairro',
                enable: false,
                controller: _bairroController,
              ),
        
              const SizedBox(height: 20,),
        
              LayoutBuilder(
                builder: (context, contrains) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: contrains.maxWidth*3/5 - 20,
                        child: AppTextFieldComponent(
                         label: 'cidade',
                          enable: false,
                          controller: _cidadeController,
                        ),
                      ),
        
                      const SizedBox(height: 20,),

                      SizedBox(
                        width: contrains.maxWidth*2/5 - 20,
                        child: AppTextFieldComponent(
                          label: 'estado',
                          enable: false,
                          controller: _estadoController,
                        ),
                      ),
                    ],
                  );
                }
              ),

              const SizedBox(height: 40,),

              AppButtomComponent(
                onPressed: () => _salvarCep(),
                text: 'Salvar',
                loading: loading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buscarCep(){
    _bloc.add(GetEnderecosPeloCepEvent(cep: _cepController.text));
    _bloc.stream.listen((event) {
      if(event is SuccessGetEnderecosPeloCepState){
        _longadouroController.text = event.model.street;
        _bairroController.text = event.model.neighborhood;
        _cidadeController.text = event.model.city;
        _estadoController.text = event.model.state;
      }else{
        ToastHelper.showMessage(context: context, messageType: MessageType.error, message: "CEP inválido");
      }
    });
  }

  _obterLocalizacaoAtual() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      ToastHelper.showMessage(context: context, messageType: MessageType.error, message: "Permissão de localização negada");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _longadouroController.text = place.street ?? "";
        _numeroController.text = place.subThoroughfare ?? "";
        _bairroController.text = place.subLocality ?? "";
        _cidadeController.text = place.subAdministrativeArea ?? "";
        _estadoController.text = place.administrativeArea ?? "";
        _cepController.text = place.postalCode ?? "";
      });
    } catch (e) {
      ToastHelper.showMessage(context: context, messageType: MessageType.error, message: "Erro: $e");
    }
  }

  _salvarCep() async {
    var validate1 = _cepFormkey.currentState!.validate();
    var validate2 = _numerokey.currentState!.validate();

    if (validate1 && validate2 && _longadouroController.text.isNotEmpty) {
      setState(() => loading = true);

      var model = EnderecoModel(
        id: const Uuid().v4(),
        idUsuario: AppConstants.usuario.id,
        longadouro: _longadouroController.text,
        numero: int.parse(_numeroController.text),
        complemento: _complementoController.text,
        bairro: _bairroController.text,
        cidade: _cidadeController.text,
        estado: _estadoController.text,
      );

      await FirestoreService.adicionarEndereco(model);

      Navigator.of(context).pop(model);
      setState(() => loading = false);
    }
  }
}
