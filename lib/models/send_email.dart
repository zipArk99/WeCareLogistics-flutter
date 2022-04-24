
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wecare_logistics/models/google_auth_api.dart';

Future<void> sendLabelToEamil() async {
  /* var user = await GoogleAuthApi.signIn();

  if (user == null) return;

  final String email = 'kajiwalashaurya123@gmail.com';
  final auth = await user.authentication;
  final token = auth.accessToken;
  final smtpServer = gmailSaslXoauth2(email, '$token');

  final message = Message()
    ..from = Address(email, 'Your name')
    ..recipients = ['kajiwalashaurya29@gmail.com']
    ..subject = 'label generated'
    ..text = 'hello world';

  try {
    send(message, smtpServer);
  } catch (error) {
    print("error occuerd while sending label to email");
  } */
/*   final Email email = Email(
    body: 'shaun ted',
    subject: 'sdfsd',
    recipients: ['kajiwalashaurya@gmail.com'],
    cc: ['cc@example.com'],
    bcc: ['bcc@example.com'],
    isHTML: false,
  );

  await FlutterEmailSender.send(email); */
}
