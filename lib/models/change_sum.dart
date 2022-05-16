class ChangeSum {
  int? closed_terminal;
  int? closed_sum;
  int? terminal;
  int? sum;

  ChangeSum({
    this.closed_sum,
    this.closed_terminal,
    this.terminal,
    this.sum,
  });

  factory ChangeSum.fromJson(Map<String, dynamic> json) {
    return ChangeSum(
      closed_sum: json["closed_sum"],
      closed_terminal: json["closed_terminal"],
      terminal: json["terminal"],
      sum: json["sum"],
    );
  }
}
