class Command {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Command({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });
}