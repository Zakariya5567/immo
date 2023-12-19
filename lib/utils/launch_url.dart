import 'package:url_launcher/url_launcher.dart';

void launchInAppURL(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri);
}
