  import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowserView(Uri url) async { //redirect the user to the following url page
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}