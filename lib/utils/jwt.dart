import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:emr_application/config.dart';

String generateJwt(String sessionName, String roleType) {
  final jwt = JWT(
    {
      'app_key': configs['ZOOM_SDK_KEY'],
      'version': 1,
      'tpc': sessionName,
      'role_type': int.parse(roleType),
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp':
          DateTime.now().add(const Duration(hours: 2)).millisecondsSinceEpoch ~/
              1000,
    },
  );

  return jwt.sign(SecretKey(configs['ZOOM_SDK_SECRET']!));
}
