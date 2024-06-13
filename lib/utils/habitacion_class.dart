class Resource {
  final String url;

  Resource({required this.url});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      url: json['url'],
    );
  }
}

class Habitacion {
  final String id;
  final String nroRoom;
  final String description;
  final int nroPersons;
  final int nroBeds;
  final double price;
  final String size;
  final String status;
  final String type;
  final String view;
  final List<Resource> resources;

  Habitacion({
    required this.id,
    required this.nroRoom,
    required this.description,
    required this.nroPersons,
    required this.nroBeds,
    required this.price,
    required this.size,
    required this.status,
    required this.type,
    required this.view,
    required this.resources,
  });

  factory Habitacion.fromJson(Map<String, dynamic> json) {
    var resourcesList = json['resources'] as List;

    List<Resource> resources =
        resourcesList.map((i) => Resource.fromJson(i)).toList();

    return Habitacion(
      id: json['id'],
      nroRoom: json['nroRoom'],
      description: json['description'],
      nroPersons: json['nroPersons'],
      nroBeds: json['nroBeds'],
      price: json['price'].toDouble(),
      size: json['size'],
      status: json['status'],
      type: json['type'],
      view: json['view'],
      resources: resources,
    );
  }
}
