
import 'BaseModel.dart';

class ErrorModel extends BaseModel<ErrorModel>{
  int code;
  List<String> error;

  ErrorModel({
    this.code,
    this.error,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    code: json["code"],
    error: List<String>.from(json["error"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "error": List<dynamic>.from(error.map((x) => x)),
  };

  @override
  ErrorModel fromJson(Map<String, dynamic> json) {
    return ErrorModel.fromJson(json);
  }
}