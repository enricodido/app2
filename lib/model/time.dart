class TimeModel {
  TimeModel({
    required this.slot,
    required this.enable
  });

  final String slot;
  final bool enable;

  factory TimeModel.fromData(String slot, String enable) {
    return TimeModel(
      slot: slot,
      enable: enable == 'true'
    );
  }
}