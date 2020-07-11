abstract class StringValidator
{
  bool isValid(String value);
}
class NonEmptyStringValidator implements StringValidator
{
  @override
  bool isValid(String value) {
   return value.isNotEmpty;
  }
  
}
class EmailandPasswordValidator
{
  final StringValidator emailValidator=NonEmptyStringValidator();
  final StringValidator passwordValidator=NonEmptyStringValidator();
  final String invalidEmailError='Email can\'t be empty';
  final String invalidPasswordError='Password can\'t be empty';

}