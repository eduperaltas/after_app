class Place {
  final String description;
  final String placeId;
  String direction;
  double lat;
  double lng;
  bool isFavorite;
  String favName;

  Place({
    this.description,
    this.placeId,
    this.direction,
    this.lat,
    this.lng,
    this.isFavorite,
    this.favName,
  });


  factory Place.fromJson (Map<String, dynamic> json) {
    return Place(
        description: json ['description'],
        placeId: json['place_id']
    );
  }

}