class TextUtil {
  static String splitIntoParagraphs(String? text) {
    text ??= '';
    List<String> sentences = text.split('. ');
    List<String> paragraphs = [];

    for (int i = 0; i < sentences.length; i++) {
      paragraphs.add('${sentences[i]}.');

      if (i != sentences.length - 1) {
        paragraphs.add('\n');
      }
    }

    return paragraphs.join();
  }
}
