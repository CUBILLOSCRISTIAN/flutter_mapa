// To parse this JSON data, do
//
//     final poi = poiFromJson(jsonString);

import 'dart:convert';

GeoJsonPOIs poiFromJson(String str) => GeoJsonPOIs.fromJson(json.decode(str));

String poiToJson(GeoJsonPOIs data) => json.encode(data.toJson());

class GeoJsonPOIs {
    final String? type;
    final String? name;
    final Crs? crs;
    final List<Feature>? features;

    GeoJsonPOIs({
        this.type,
        this.name,
        this.crs,
        this.features,
    });

    factory GeoJsonPOIs.fromJson(Map<String, dynamic> json) => GeoJsonPOIs(
        type: json["type"],
        name: json["name"],
        crs: json["crs"] == null ? null : Crs.fromJson(json["crs"]),
        features: json["features"] == null ? [] : List<Feature>.from(json["features"]!.map((x) => Feature.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "crs": crs?.toJson(),
        "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x.toJson())),
    };
}

class Crs {
    final String? type;
    final CrsProperties? properties;

    Crs({
        this.type,
        this.properties,
    });

    factory Crs.fromJson(Map<String, dynamic> json) => Crs(
        type: json["type"],
        properties: json["properties"] == null ? null : CrsProperties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties?.toJson(),
    };
}

class CrsProperties {
    final String? name;

    CrsProperties({
        this.name,
    });

    factory CrsProperties.fromJson(Map<String, dynamic> json) => CrsProperties(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Feature {
    final FeatureType? type;
    final FeatureProperties? properties;
    final Geometry? geometry;

    Feature({
        this.type,
        this.properties,
        this.geometry,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: featureTypeValues.map[json["type"]]!,
        properties: json["properties"] == null ? null : FeatureProperties.fromJson(json["properties"]),
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    );

    Map<String, dynamic> toJson() => {
        "type": featureTypeValues.reverse[type],
        "properties": properties?.toJson(),
        "geometry": geometry?.toJson(),
    };
}

class Geometry {
    final GeometryType? type;
    final List<double>? coordinates;

    Geometry({
        this.type,
        this.coordinates,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: geometryTypeValues.map[json["type"]]!,
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

enum GeometryType {
    POINT
}

final geometryTypeValues = EnumValues({
    "Point": GeometryType.POINT
});

class FeatureProperties {
    final int? osmId;
    final String? highway;
    final String? publicTransport;
    final String? amenity;
    final String? name;
    final String? tourism;
    final String? shop;
    final String? brand;
    final String? propertiesOperator;
    final String? religion;
    final String? historic;
    final String? denomination;
    final String? leisure;
    final Bench? bin;
    final Bench? bus;
    final Bench? noname;
    final Bench? shelter;
    final Bench? bench;
    final String? cuisine;
    final Bench? drinkingWater;
    final Fee? fee;
    final Bench? bottle;
    final String? healthcare;
    final String? artworkType;
    final String? fastFood;
    final Bench? outdoorSeating;
    final String? studio;
    final String? vending;
    final Bench? paymentCoins;
    final String? website;
    final String? nameEn;
    final String? brandWikidata;
    final String? nameEs;
    final String? brandWikipedia;
    final Fee? smoking;
    final String? tipo;
    final String? internetAccess;
    final String? craft;
    final String? memorial;
    final String? material;
    final String? mapType;
    final String? mapSize;
    final String? information;
    final Bench? lit;
    final String? theatreType;
    final Bench? male;
    final Bench? female;
    final Bench? unisex;

    FeatureProperties({
        this.osmId,
        this.highway,
        this.publicTransport,
        this.amenity,
        this.name,
        this.tourism,
        this.shop,
        this.brand,
        this.propertiesOperator,
        this.religion,
        this.historic,
        this.denomination,
        this.leisure,
        this.bin,
        this.bus,
        this.noname,
        this.shelter,
        this.bench,
        this.cuisine,
        this.drinkingWater,
        this.fee,
        this.bottle,
        this.healthcare,
        this.artworkType,
        this.fastFood,
        this.outdoorSeating,
        this.studio,
        this.vending,
        this.paymentCoins,
        this.website,
        this.nameEn,
        this.brandWikidata,
        this.nameEs,
        this.brandWikipedia,
        this.smoking,
        this.tipo,
        this.internetAccess,
        this.craft,
        this.memorial,
        this.material,
        this.mapType,
        this.mapSize,
        this.information,
        this.lit,
        this.theatreType,
        this.male,
        this.female,
        this.unisex,
    });

    factory FeatureProperties.fromJson(Map<String, dynamic> json) => FeatureProperties(
        osmId: json["osm_id"],
        highway: json["highway"],
        publicTransport: json["public_transport"],
        amenity: json["amenity"],
        name: json["name"],
        tourism: json["tourism"],
        shop: json["shop"],
        brand: json["brand"],
        propertiesOperator: json["operator"],
        religion: json["religion"],
        historic: json["historic"],
        denomination: json["denomination"],
        leisure: json["leisure"],
        bin: benchValues.map[json["bin"]]!,
        bus: benchValues.map[json["bus"]]!,
        noname: benchValues.map[json["noname"]]!,
        shelter: benchValues.map[json["shelter"]]!,
        bench: benchValues.map[json["bench"]]!,
        cuisine: json["cuisine"],
        drinkingWater: benchValues.map[json["drinking_water"]]!,
        fee: feeValues.map[json["fee"]]!,
        bottle: benchValues.map[json["bottle"]]!,
        healthcare: json["healthcare"],
        artworkType: json["artwork_type"],
        fastFood: json["fast_food"],
        outdoorSeating: benchValues.map[json["outdoor_seating"]]!,
        studio: json["studio"],
        vending: json["vending"],
        paymentCoins: benchValues.map[json["payment:coins"]]!,
        website: json["website"],
        nameEn: json["name:en"],
        brandWikidata: json["brand:wikidata"],
        nameEs: json["name:es"],
        brandWikipedia: json["brand:wikipedia"],
        smoking: feeValues.map[json["smoking"]]!,
        tipo: json["tipo"],
        internetAccess: json["internet_access"],
        craft: json["craft"],
        memorial: json["memorial"],
        material: json["material"],
        mapType: json["map_type"],
        mapSize: json["map_size"],
        information: json["information"],
        lit: benchValues.map[json["lit"]]!,
        theatreType: json["theatre:type"],
        male: benchValues.map[json["male"]]!,
        female: benchValues.map[json["female"]]!,
        unisex: benchValues.map[json["unisex"]]!,
    );

    Map<String, dynamic> toJson() => {
        "osm_id": osmId,
        "highway": highway,
        "public_transport": publicTransport,
        "amenity": amenity,
        "name": name,
        "tourism": tourism,
        "shop": shop,
        "brand": brand,
        "operator": propertiesOperator,
        "religion": religion,
        "historic": historic,
        "denomination": denomination,
        "leisure": leisure,
        "bin": benchValues.reverse[bin],
        "bus": benchValues.reverse[bus],
        "noname": benchValues.reverse[noname],
        "shelter": benchValues.reverse[shelter],
        "bench": benchValues.reverse[bench],
        "cuisine": cuisine,
        "drinking_water": benchValues.reverse[drinkingWater],
        "fee": feeValues.reverse[fee],
        "bottle": benchValues.reverse[bottle],
        "healthcare": healthcare,
        "artwork_type": artworkType,
        "fast_food": fastFood,
        "outdoor_seating": benchValues.reverse[outdoorSeating],
        "studio": studio,
        "vending": vending,
        "payment:coins": benchValues.reverse[paymentCoins],
        "website": website,
        "name:en": nameEn,
        "brand:wikidata": brandWikidata,
        "name:es": nameEs,
        "brand:wikipedia": brandWikipedia,
        "smoking": feeValues.reverse[smoking],
        "tipo": tipo,
        "internet_access": internetAccess,
        "craft": craft,
        "memorial": memorial,
        "material": material,
        "map_type": mapType,
        "map_size": mapSize,
        "information": information,
        "lit": benchValues.reverse[lit],
        "theatre:type": theatreType,
        "male": benchValues.reverse[male],
        "female": benchValues.reverse[female],
        "unisex": benchValues.reverse[unisex],
    };
}

enum Bench {
    YES
}

final benchValues = EnumValues({
    "yes": Bench.YES
});

enum Fee {
    NO
}

final feeValues = EnumValues({
    "no": Fee.NO
});

enum FeatureType {
    FEATURE
}

final featureTypeValues = EnumValues({
    "Feature": FeatureType.FEATURE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
