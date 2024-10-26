class PaymentPlatform {
  final String id;
  final String name;
  final String icon;

  PaymentPlatform({required this.id, required this.name, required this.icon});

  // Factory method to create a PaymentPlatform from JSON
  factory PaymentPlatform.fromJson(Map<String, dynamic> json) {
    return PaymentPlatform(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}
