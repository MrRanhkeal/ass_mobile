class Invoice {
  final String invoiceNumber;
  final DateTime date;
  final List<InvoiceItem> items;
  final double total;

  Invoice({
    required this.invoiceNumber,
    required this.date,
    required this.items,
    required this.total,
  });
}

class InvoiceItem {
  final String name;
  final String category;
  final double price;
  final int quantity;

  InvoiceItem({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
  });

  double get subtotal => price * quantity;
}
