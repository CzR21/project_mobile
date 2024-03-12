class DateHelper{

  static String get buscarMensagemDia{
    DateTime now = DateTime.now();

    if(now.hour >= 6 && now.hour < 12){
      return 'bom dia!';
    }else if(now.hour > 12 && now.hour < 18){
      return 'boa tarde!';
    }else{
      return 'boa noite!';
    }
  }

}