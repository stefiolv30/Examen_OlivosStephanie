class ProveedorItem {
  final int providerId;
  final String providerName;
  final String providerLastName;
  final String providerMail;
  final String providerState;

  ProveedorItem({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });

  factory ProveedorItem.fromMap(Map<String, dynamic> json) => ProveedorItem(
    providerId: json['providerid'],
    providerName: json['provider_name'],
    providerLastName: json['provider_last_name'],
    providerMail: json['provider_mail'],
    providerState: json['provider_state'],
  );
}
