class DictationStatus {
  DictationStatus({
    this.dictationstatusid,
    this.dictationstatus,
  });

  String dictationstatusid;
  String dictationstatus;

  factory DictationStatus.fromJson(Map<String, dynamic> json) =>
      DictationStatus(
        dictationstatusid: json["dictationstatusid"] == null
            ? null
            : json["dictationstatusid"],
        dictationstatus:
            json["dictationstatus"] == null ? null : json["dictationstatus"],
      );

  Map<String, dynamic> toJson() => {
        "dictationstatusid":
            dictationstatusid == null ? null : dictationstatusid,
        "dictationstatus": dictationstatus == null ? null : dictationstatus,
      };

  @override
  String toString() {
    return 'DictationStatus{dictationstatus: $dictationstatus}';
  }
}
