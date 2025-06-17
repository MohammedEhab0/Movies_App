class Errors{
  String errorMessage ;
  Errors({required this.errorMessage});
}
class ServerErrors extends Errors{

  ServerErrors ({required super.errorMessage});
}
class NetworkErrors extends Errors{

  NetworkErrors ({required super.errorMessage});
}