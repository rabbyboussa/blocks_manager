import 'package:blocks/core/constants/constants.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class AuthenticationPageImagePanel extends StatelessWidget {
  const AuthenticationPageImagePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w(context),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image.asset(
            'assets/images/briques.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                return Container(
                  foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color(0x00000000),
                        Color(0x00000000),
                        Color(0x00000000),
                        Color(0xBB000000),
                        Color(0xCC000000),
                        Color(0xDD000000),
                      ])),
                  height: double.infinity,
                  width: double.infinity,
                  child: child,
                );
              } else {
                return Container(
                  alignment: const Alignment(0, 0),
                  constraints: const BoxConstraints.expand(),
                  child: const ProgressRing(activeColor: kBrown),
                );
              }
            },
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 24,
              bottom: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EasyRichText(
                  'La brique éssentielle\npour une bonne gestion!',
                  defaultStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      height: 1.0),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'brique',
                      style: const TextStyle(
                        color: kBrown,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    EasyRichTextPattern(
                      targetString: 'bonne gestion',
                      style: const TextStyle(
                        color: kBrown,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  margin: const EdgeInsets.only(right: 200),
                  child: const Text(
                    'Blocks est une solution complète pour la gestion de votre briqueterie. De nombreux outils profesionnels intégrés pour favoriser la croissance de votre entreprise.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
