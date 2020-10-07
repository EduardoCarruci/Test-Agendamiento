import 'dart:convert';

class Weather {
    Weather({
        this.timezone,
        this.stateCode,
        this.countryCode,
        this.lat,
        this.lon,
        this.cityName,
        this.stationId,
        this.data,
        this.sources,
        this.cityId,
    });

    String timezone;
    String stateCode;
    String countryCode;
    double lat;
    double lon;
    String cityName;
    String stationId;
    List<Datum> data;
    List<String> sources;
    String cityId;

    factory Weather.fromJson(String str) => Weather.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        timezone: json["timezone"],
        stateCode: json["state_code"],
        countryCode: json["country_code"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        cityName: json["city_name"],
        stationId: json["station_id"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        sources: List<String>.from(json["sources"].map((x) => x)),
        cityId: json["city_id"],
    );

    Map<String, dynamic> toMap() => {
        "timezone": timezone,
        "state_code": stateCode,
        "country_code": countryCode,
        "lat": lat,
        "lon": lon,
        "city_name": cityName,
        "station_id": stationId,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "sources": List<dynamic>.from(sources.map((x) => x)),
        "city_id": cityId,
    };
}

class Datum {
    Datum({
        this.rh,
        this.maxWindSpdTs,
        this.tGhi,
        this.maxWindSpd,
        this.solarRad,
        this.windGustSpd,
        this.maxTempTs,
        this.minTempTs,
        this.clouds,
        this.maxDni,
        this.precipGpm,
        this.windSpd,
        this.slp,
        this.ts,
        this.maxGhi,
        this.temp,
        this.pres,
        this.dni,
        this.dewpt,
        this.snow,
        this.dhi,
        this.precip,
        this.windDir,
        this.maxDhi,
        this.ghi,
        this.maxTemp,
        this.tDni,
        this.maxUv,
        this.tDhi,
        this.datetime,
        this.tSolarRad,
        this.minTemp,
        this.maxWindDir,
        this.snowDepth,
    });

    double rh;
    int maxWindSpdTs;
    double tGhi;
    double maxWindSpd;
    double solarRad;
    double windGustSpd;
    int maxTempTs;
    int minTempTs;
    int clouds;
    double maxDni;
    int precipGpm;
    double windSpd;
    double slp;
    int ts;
    double maxGhi;
    double temp;
    double pres;
    double dni;
    double dewpt;
    int snow;
    double dhi;
    int precip;
    int windDir;
    double maxDhi;
    double ghi;
    double maxTemp;
    double tDni;
    double maxUv;
    double tDhi;
    DateTime datetime;
    double tSolarRad;
    double minTemp;
    int maxWindDir;
    int snowDepth;

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        rh: json["rh"].toDouble(),
        maxWindSpdTs: json["max_wind_spd_ts"],
        tGhi: json["t_ghi"].toDouble(),
        maxWindSpd: json["max_wind_spd"].toDouble(),
        solarRad: json["solar_rad"].toDouble(),
        windGustSpd: json["wind_gust_spd"].toDouble(),
        maxTempTs: json["max_temp_ts"],
        minTempTs: json["min_temp_ts"],
        clouds: json["clouds"],
        maxDni: json["max_dni"].toDouble(),
        precipGpm: json["precip_gpm"],
        windSpd: json["wind_spd"].toDouble(),
        slp: json["slp"].toDouble(),
        ts: json["ts"],
        maxGhi: json["max_ghi"].toDouble(),
        temp: json["temp"].toDouble(),
        pres: json["pres"].toDouble(),
        dni: json["dni"].toDouble(),
        dewpt: json["dewpt"].toDouble(),
        snow: json["snow"],
        dhi: json["dhi"].toDouble(),
        precip: json["precip"],
        windDir: json["wind_dir"],
        maxDhi: json["max_dhi"].toDouble(),
        ghi: json["ghi"].toDouble(),
        maxTemp: json["max_temp"].toDouble(),
        tDni: json["t_dni"].toDouble(),
        maxUv: json["max_uv"].toDouble(),
        tDhi: json["t_dhi"].toDouble(),
        datetime: DateTime.parse(json["datetime"]),
        tSolarRad: json["t_solar_rad"].toDouble(),
        minTemp: json["min_temp"].toDouble(),
        maxWindDir: json["max_wind_dir"],
        snowDepth: json["snow_depth"],
    );

    Map<String, dynamic> toMap() => {
        "rh": rh,
        "max_wind_spd_ts": maxWindSpdTs,
        "t_ghi": tGhi,
        "max_wind_spd": maxWindSpd,
        "solar_rad": solarRad,
        "wind_gust_spd": windGustSpd,
        "max_temp_ts": maxTempTs,
        "min_temp_ts": minTempTs,
        "clouds": clouds,
        "max_dni": maxDni,
        "precip_gpm": precipGpm,
        "wind_spd": windSpd,
        "slp": slp,
        "ts": ts,
        "max_ghi": maxGhi,
        "temp": temp,
        "pres": pres,
        "dni": dni,
        "dewpt": dewpt,
        "snow": snow,
        "dhi": dhi,
        "precip": precip,
        "wind_dir": windDir,
        "max_dhi": maxDhi,
        "ghi": ghi,
        "max_temp": maxTemp,
        "t_dni": tDni,
        "max_uv": maxUv,
        "t_dhi": tDhi,
        "datetime": "${datetime.year.toString().padLeft(4, '0')}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}",
        "t_solar_rad": tSolarRad,
        "min_temp": minTemp,
        "max_wind_dir": maxWindDir,
        "snow_depth": snowDepth,
    };
}