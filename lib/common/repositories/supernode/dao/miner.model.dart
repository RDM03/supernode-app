class MinerRegister {
  final String status;

  MinerRegister({
    this.status,
  });

  factory MinerRegister.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MinerRegister(
      status: map['status'],
    );
  }
}
