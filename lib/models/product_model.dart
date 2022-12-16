class ProductModel {
  String? sId;
  String? userId;
  String? name;
  String? description;
  String? img;
  int? rating;
  String? location;
  String? latitude;
  String? longitude;
  int? price;
  int? quantity;
  String? manufacturer;
  String? created;
  int? iV;
  late List<ProductModel> items;

  ProductModel(
      {this.sId,
        this.userId,
        this.name,
        this.description,
        this.img,
        this.rating,
        this.location,
        this.latitude,
        this.longitude,
        this.price,
        this.quantity,
        this.manufacturer,
        this.created,
        this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    rating = json['rating'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    price = json['price'];
    quantity = json['quantity'];
    manufacturer = json['manufacturer'];
    created = json['created'];
    iV = json['__v'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['img'] = this.img;
    data['rating'] = this.rating;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['manufacturer'] = this.manufacturer;
    data['created'] = this.created;
    data['__v'] = this.iV;
    return data;
  }
}