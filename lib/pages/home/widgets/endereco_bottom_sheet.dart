import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_mobile/blocs/endereco/endereco_bloc.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:provider/provider.dart';
import '../../../blocs/endereco/endereco_state.dart';
import '../../../data/models/endereco_model.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_fonts.dart';

class EnderecoBottomSheet extends StatefulWidget {

  const EnderecoBottomSheet({Key? key}) : super(key: key);

  @override
  State<EnderecoBottomSheet> createState() => _EnderecoBottomSheetState();

}

class _EnderecoBottomSheetState extends State<EnderecoBottomSheet> {

  final EnderecoBloc _enderecoBloc = EnderecoBloc();

  List<EnderecoModel> _enderecos = List.empty(growable: true);

  @override
  void initState() {
    _enderecoBloc.add(GetEnderecosEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppMock>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              AppAssets.locationIcon,
              width: 30,
              color: AppColors.iconOrangeColor,
            ),
            const SizedBox(width: 10,),
            Expanded(child: Text('Selecione um endereço', style: AppFonts.boldLarge.copyWith(color: AppColors.textDarkColor),)),
            GestureDetector(
              onTap: () => null,
              child: SvgPicture.asset(
                AppAssets.plusIcon,
                width: 30,
                color: AppColors.iconOrangeColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30,),
        BlocConsumer<EnderecoBloc, EnderecoState>(
          bloc: _enderecoBloc,
          listener: (context, state) {
            if (state is SuccessGetEnderecosState) {
              setState(() => _enderecos = state.model);
            }
          },
          builder: (context, state) {
            if(state is SuccessGetEnderecosState){
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _enderecos.map((e) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        provider.trocarEndereco(e);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.textDarkGreyColor)
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              e.image,
                              width: 25,
                              color: AppColors.textDarkColor,
                            ),
                            const SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.apelido == null ? e.tipoEndereco == TipoEndereco.none ? '${e.longadouro}, ${e.numero}' : e.tipoEndereco.name.toUpperCase() : e.apelido!, style: AppFonts.boldDefault.copyWith(color: AppColors.textDarkColor),),
                                SizedBox(width: MediaQuery.of(context).size.width-100, child: Text(e.toString(), style: AppFonts.regularSmall.copyWith(color: AppColors.textDarkColor), maxLines: 3, softWrap: true,))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              );
            }else if(state is ErrorGetEnderecosState){
              //TODO: Tratar erro dps
              return Text('Erro!', style: AppFonts.subTitle.copyWith(color: AppColors.darkColor),);
            }else{
              return const LinearProgressIndicator(color: AppColors.orangeDarkColor,);
            }
          },
        ),
      ],
    );
  }
}
