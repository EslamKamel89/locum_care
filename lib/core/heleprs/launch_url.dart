Future launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  // if (await canLaunchUrl(uri)) {
  await launchUrl(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}
