extension DateWithNoTime on DateTime {
  String get onlyDate => '$year $month $day';
  String get dateAndTime => '$year.$month.$day, $hour:$minute';
}

