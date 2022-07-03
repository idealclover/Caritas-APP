import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MMarkdown extends StatelessWidget {
  final String data;

  const MMarkdown(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Markdown(
      selectable: true,
      data: data,
      styleSheet: MarkdownStyleSheet(
          horizontalRuleDecoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                width: 2.0,
                color: Colors.black12,
              ),
              bottom: BorderSide(
                width: 20.0,
                color: Colors.transparent,
              )),
        ),
        blockquoteDecoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 5.0,
              color: Colors.grey,
            ),
          ),
        ),
        blockquotePadding: const EdgeInsets.fromLTRB(25.0, 5.0, 5.0, 5.0),
        blockquote: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          strong: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        h2: const TextStyle(fontSize: 20, height: 1.8),
        h4: const TextStyle(fontSize: 20, height: 1.8),
        p: const TextStyle(fontSize: 16, height: 1.8),
        pPadding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
        a: const TextStyle(
            color: Color.fromARGB(255, 26, 109, 177),
            decoration: TextDecoration.underline),
      ),
      onTapLink: (text, href, title) {
        // launch(href!);
      },
    );
  }
}
