
String truncateString(int length, String str) {
  return (str.length <= length)
    ? str
    : '${str.substring(0, length)}...';
}