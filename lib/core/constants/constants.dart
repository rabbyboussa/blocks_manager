import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

// Colors
const Color kWhite = Color(0xffffffff);
const Color kBrown = Color(0xff795548);

// API
// const String kAPIBaseUrl = 'http://www.batirafrica.com/blocks/';
const String kAPIBaseUrl = 'http://www.batirafrica.com/blocks/';

// Supabase
const supabaseURL = 'https://thhskbhzqpmohawtfqwn.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRoaHNrYmh6cXBtb2hhd3RmcXduIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNzQ1MTgzMiwiZXhwIjoyMDIzMDI3ODMyfQ.MdKatTST2nahDgFQFBKov5wOvtU0MFctWnk9oJq17FA';

// Functions
@override
Future<String> uploadImageToStorage(
    SupabaseClient supabase, String imagePath) async {
  final result = await supabase.storage.from('pictures').upload(
        '${const Uuid().v1()}.jpg',
        File(imagePath),
        fileOptions: const FileOptions(contentType: 'image/jpeg'),
      );

  final String publicUrl = supabase.storage
      .from('pictures')
      .getPublicUrl(result.replaceFirst('pictures/', ''));

  return publicUrl;
}

Future<void> showInfoBar(
  BuildContext context, {
  String title = '',
  required String message,
  required InfoBarSeverity severity,
}) async {
  await displayInfoBar(context, duration: const Duration(seconds: 5),
      builder: (context, close) {
    return InfoBar(
      title: Text(title),
      content: Text(message),
      isLong: true,
      action: Button(
        onPressed: close,
        child: const Text('Fermer'),
      ),
      severity: severity,
    );
  });
}

Future<void> showProgressDialog(BuildContext context,
    {required String message}) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          const ProgressRing(activeColor: kBrown),
          const SizedBox(width: 16),
          Text(message),
          const SizedBox(width: 8),
        ],
      ),
    ),
  );
}
