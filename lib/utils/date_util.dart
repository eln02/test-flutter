class DateUtil {
  static String ago(DateTime date) {
    final now = DateTime.now();
    final differenceInDays = now.difference(date).inDays;

    if (differenceInDays <= 7) {
      if (differenceInDays == 1){
        return '1 day ago';
      }
      return '$differenceInDays days ago';
    } else {
      final weeksAgo = differenceInDays ~/ 7;
      return '$weeksAgo weeks ago';
    }
  }
}
