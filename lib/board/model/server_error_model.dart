class ServerErrorMsg {
  final int statusCode;
  final String message;
  final String error;

  ServerErrorMsg({this.statusCode, this.message, this.error});

  factory ServerErrorMsg.fromJson(Map<String, dynamic> json) {
    return ServerErrorMsg(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      error: json['error'] as String,
    );
  }
}
//"{"statusCode":403,"message":"Forbidden resource","error":"Forbidden"}"