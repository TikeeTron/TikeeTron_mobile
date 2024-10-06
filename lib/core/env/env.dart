import 'package:secure_dotenv/secure_dotenv.dart';

part 'env.g.dart';

@DotEnvGen(
  filename: '.env',
  fieldRename: FieldRename.screamingSnake,
)
abstract class Env {
  const factory Env(String key, String iv) = _$Env;

  const Env._();

  @FieldKey(name: 'BASE_URL')
  String get baseUrl => 'https://api.tikeetron.cloud';

  @FieldKey(name: 'AI_URL')
  String get aiUrl => 'https://ai.tikeetron.laam.my.id';
}
