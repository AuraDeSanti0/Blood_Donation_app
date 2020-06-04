
class HttpException implements Exception{
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message; //instead return message
    //return super.toString(); will return instance of HttpException
  }
}
