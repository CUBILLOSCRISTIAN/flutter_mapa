// To parse this JSON data, do
//
//     final geoJson = geoJsonFromJson(jsonString);

import 'dart:convert';

GeoJsonRoads geoJsonFromJson(String str) => GeoJsonRoads.fromJson(json.decode(str));

String geoJsonToJson(GeoJsonRoads data) => json.encode(data.toJson());

class GeoJsonRoads {
    final String? type;
    final String? name;
    final Crs? crs;
    final List<Feature>? features;

    GeoJsonRoads({
        this.type,
        this.name,
        this.crs,
        this.features,
    });

    factory GeoJsonRoads.fromJson(Map<String, dynamic> json) => GeoJsonRoads(
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
    final List<List<double>>? coordinates;

    Geometry({
        this.type,
        this.coordinates,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: geometryTypeValues.map[json["type"]]!,
        coordinates: json["coordinates"] == null ? [] : List<List<double>>.from(json["coordinates"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
    );

    Map<String, dynamic> toJson() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}

enum GeometryType {
    // ignore: constant_identifier_names
    LINE_STRING
}

final geometryTypeValues = EnumValues({
    "LineString": GeometryType.LINE_STRING
});

class FeatureProperties {
    final int? osmId;
    final Bicycle? bicycle;
    final String? ref;
    final Construction? highway;
    final Surface? surface;
    final String? name;
    final Bicycle? oneway;
    final Bicycle? bridge;
    final String? layer;
    final Construction? construction;
    final Access? access;
    final Tunnel? tunnel;
    final Bicycle? covered;
    final Service? service;
    final Bicycle? cutting;
    final String? junction;
    final String? natName;
    final String? lanes;
    final String? smoothness;
    final String? maxheight;
    final String? altName;
    final String? parkingLaneBoth;
    final String? maxspeed;
    final Bicycle? ford;
    final Bicycle? mechanical;
    final String? parkingLaneLeft;
    final Bicycle? laneMarkings;
    final String? intName;

    FeatureProperties({
        this.osmId,
        this.bicycle,
        this.ref,
        this.highway,
        this.surface,
        this.name,
        this.oneway,
        this.bridge,
        this.layer,
        this.construction,
        this.access,
        this.tunnel,
        this.covered,
        this.service,
        this.cutting,
        this.junction,
        this.natName,
        this.lanes,
        this.smoothness,
        this.maxheight,
        this.altName,
        this.parkingLaneBoth,
        this.maxspeed,
        this.ford,
        this.mechanical,
        this.parkingLaneLeft,
        this.laneMarkings,
        this.intName,
    });

    factory FeatureProperties.fromJson(Map<String, dynamic> json) => FeatureProperties(
        osmId: json["osm_id"],
        bicycle: bicycleValues.map[json["bicycle"]],
        ref: json["ref"],
        highway: constructionValues.map[json["highway"]],
        surface: surfaceValues.map[json["surface"]],
        name: json["name"],
        oneway: bicycleValues.map[json["oneway"]],
        bridge: bicycleValues.map[json["bridge"]],
        layer: json["layer"],
        construction: constructionValues.map[json["construction"]],
        access: accessValues.map[json["access"]],
        tunnel: tunnelValues.map[json["tunnel"]],
        covered: bicycleValues.map[json["covered"]],
        service: serviceValues.map[json["service"]],
        cutting: bicycleValues.map[json["cutting"]],
        junction: json["junction"],
        natName: json["nat_name"],
        lanes: json["lanes"],
        smoothness: json["smoothness"],
        maxheight: json["maxheight"],
        altName: json["alt_name"],
        parkingLaneBoth: json["parking:lane:both"],
        maxspeed: json["maxspeed"],
        ford: bicycleValues.map[json["ford"]],
        mechanical: bicycleValues.map[json["mechanical"]],
        parkingLaneLeft: json["parking:lane:left"],
        laneMarkings: bicycleValues.map[json["lane_markings"]],
        intName: json["int_name"],
    );

    Map<String, dynamic> toJson() => {
        "osm_id": osmId,
        "bicycle": bicycleValues.reverse[bicycle],
        "ref": ref,
        "highway": constructionValues.reverse[highway],
        "surface": surfaceValues.reverse[surface],
        "name": name,
        "oneway": bicycleValues.reverse[oneway],
        "bridge": bicycleValues.reverse[bridge],
        "layer": layer,
        "construction": constructionValues.reverse[construction],
        "access": accessValues.reverse[access],
        "tunnel": tunnelValues.reverse[tunnel],
        "covered": bicycleValues.reverse[covered],
        "service": serviceValues.reverse[service],
        "cutting": bicycleValues.reverse[cutting],
        "junction": junction,
        "nat_name": natName,
        "lanes": lanes,
        "smoothness": smoothness,
        "maxheight": maxheight,
        "alt_name": altName,
        "parking:lane:both": parkingLaneBoth,
        "maxspeed": maxspeed,
        "ford": bicycleValues.reverse[ford],
        "mechanical": bicycleValues.reverse[mechanical],
        "parking:lane:left": parkingLaneLeft,
        "lane_markings": bicycleValues.reverse[laneMarkings],
        "int_name": intName,
    };
}

enum Access {
    CUSTOMERS,
    NO,
    PRIVATE
}

final accessValues = EnumValues({
    "customers": Access.CUSTOMERS,
    "no": Access.NO,
    "private": Access.PRIVATE
});

enum Bicycle {
    NO,
    YES
}

final bicycleValues = EnumValues({
    "no": Bicycle.NO,
    "yes": Bicycle.YES
});

enum Construction {
    CONSTRUCTION,
    FOOTWAY,
    RESIDENTIAL,
    SECONDARY,
    SERVICE,
    STEPS,
    TERTIARY,
    TERTIARY_LINK,
    TRUNK,
    UNCLASSIFIED
}

final constructionValues = EnumValues({
    "construction": Construction.CONSTRUCTION,
    "footway": Construction.FOOTWAY,
    "residential": Construction.RESIDENTIAL,
    "secondary": Construction.SECONDARY,
    "service": Construction.SERVICE,
    "steps": Construction.STEPS,
    "tertiary": Construction.TERTIARY,
    "tertiary_link": Construction.TERTIARY_LINK,
    "trunk": Construction.TRUNK,
    "unclassified": Construction.UNCLASSIFIED
});

enum Service {
    DRIVEWAY,
    PARKING_AISLE
}

final serviceValues = EnumValues({
    "driveway": Service.DRIVEWAY,
    "parking_aisle": Service.PARKING_AISLE
});

enum Surface {
    ASPHALT,
    CONCRETE,
    PAVED,
    PAVING_STONES
}

final surfaceValues = EnumValues({
    "asphalt": Surface.ASPHALT,
    "concrete": Surface.CONCRETE,
    "paved": Surface.PAVED,
    "paving_stones": Surface.PAVING_STONES
});

enum Tunnel {
    BUILDING_PASSAGE,
    COVERED,
    YES
}

final tunnelValues = EnumValues({
    "building_passage": Tunnel.BUILDING_PASSAGE,
    "covered": Tunnel.COVERED,
    "yes": Tunnel.YES
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
