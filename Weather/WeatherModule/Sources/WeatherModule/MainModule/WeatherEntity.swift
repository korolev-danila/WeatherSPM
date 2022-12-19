//
//  File.swift
//  
//
//  Created by Данила on 24.11.2022.
//

struct Weather: Decodable {
    var now: String?
    var nowDt: Double?
    var info: Info?
    var fact: Fact?
    var forecasts: [Forecasts]?
    
    enum CodingKeys: String, CodingKey {
        case now, info, fact, forecasts
        case nowDt = "now_dt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.now = try? container.decode(String.self, forKey: .now)
        self.nowDt = try? container.decode(Double.self, forKey: .nowDt)
        self.info = try? container.decode(Info.self, forKey: .info)
        self.fact = try? container.decode(Fact.self, forKey: .fact)
        self.forecasts = try? container.decode([Forecasts].self, forKey: .forecasts)
    }
}

// MARK: - Info
extension Weather {
    struct Info: Decodable {
        var lat: Double?
        var lon: Double?
        var tzinfo: Tzinfo?
        var defPressureMm: Double?
        var defPressurePa: Double?
        var url: String?
        
        enum CodingKeys: String, CodingKey {
            case lat
            case lon
            case tzinfo
            case defPressureMm = "def_pressure_mm"
            case defPressurePa = "def_pressure_pa"
            case url
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.lat = try? container.decode(Double.self, forKey: .lat)
            self.lon = try? container.decode(Double.self, forKey: .lon)
            self.tzinfo = try? container.decode(Tzinfo.self, forKey: .tzinfo)
            self.defPressureMm = try? container.decode(Double.self, forKey: .defPressureMm)
            self.defPressurePa = try? container.decode(Double.self, forKey: .defPressurePa)
            self.url = try? container.decode(String.self, forKey: .url)
        }
    }
    
    struct Tzinfo: Decodable {
        var offset: Double?
        var name: String?
        var abbr: String?
        var dst: Bool?
        
        enum CodingKeys: String, CodingKey {
            case offset, name, abbr, dst
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.offset = try? container.decode(Double.self, forKey: .offset)
            self.name = try? container.decode(String.self, forKey: .name)
            self.abbr = try? container.decode(String.self, forKey: .abbr)
            self.dst = try? container.decode(Bool.self, forKey: .dst)
        }
    }
}

// MARK: - Fact
extension Weather {
    struct Fact: Decodable {
        var temp: Double?
        var feelsLike: Double?
        var icon: String?
        var condition: String?
        var windSpeed: Double?
        var windGust: Double?
        var windDir: String?
        var pressureMm: Double?
        var pressurePa: Double?
        var humidity: Double?
        var daytime: String?
        var polar: Bool?
        var season: String?
        var precType: Double?
        var precStrength: Double?
        var isThunder: Bool?
        var cloudness:Double?
        var obsTime: Double?
        var phenomIcon: String?
        var phenomCondition: String?
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case icon
            case condition
            case windSpeed = "wind_speed"
            case windGust = "wind_gust"
            case windDir = "wind_dir"
            case pressureMm = "pressure_mm"
            case pressurePa = "pressure_pa"
            case humidity
            case daytime
            case polar
            case season
            case precType = "prec_type"
            case precStrength = "prec_strength"
            case isThunder = "is_thunder"
            case cloudness
            case obsTime = "obs_time"
            case phenomIcon = "phenom_icon"
            case phenomCondition = "phenom-condition"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.temp = try? container.decode(Double.self, forKey: .temp)
            self.feelsLike = try? container.decode(Double.self, forKey: .feelsLike)
            self.icon = try? container.decode(String.self, forKey: .icon)
            self.condition = try? container.decode(String.self, forKey: .condition)
            self.windSpeed = try? container.decode(Double.self, forKey: .windSpeed)
            self.windGust = try? container.decode(Double.self, forKey: .windGust)
            self.windDir = try? container.decode(String.self, forKey: .windDir)
            self.pressureMm = try? container.decode(Double.self, forKey: .pressureMm)
            self.pressurePa = try? container.decode(Double.self, forKey: .pressurePa)
            self.humidity = try? container.decode(Double.self, forKey: .humidity)
            self.daytime = try? container.decode(String.self, forKey: .daytime)
            self.polar = try? container.decode(Bool.self, forKey: .polar)
            self.season = try? container.decode(String.self, forKey: .season)
            self.precType = try? container.decode(Double.self, forKey: .precType)
            self.precStrength = try? container.decode(Double.self, forKey: .precStrength)
            self.isThunder = try? container.decode(Bool.self, forKey: .isThunder)
            self.cloudness = try? container.decode(Double.self, forKey: .cloudness)
            self.obsTime = try? container.decode(Double.self, forKey: .obsTime)
            self.phenomIcon = try? container.decode(String.self, forKey: .phenomIcon)
            self.phenomCondition = try? container.decode(String.self, forKey: .phenomCondition)
        }
    }
}

// MARK: - Forecasts
extension Weather {
    struct Forecasts: Decodable {
        var date: String?
        var sunrise: String?
        var sunset: String?
        var tempMin: Double?
        var tempMax: Double?
        var parts: Parts?
        var svgStr: String?
        
        enum CodingKeys: String, CodingKey {
            case date, sunrise, sunset, parts
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.date = try? container.decode(String.self, forKey: .date)
            self.sunrise = try? container.decode(String.self, forKey: .sunrise)
            self.sunset = try? container.decode(String.self, forKey: .sunset)
            self.tempMin = try? container.decode(Double.self, forKey: .tempMin)
            self.tempMax = try? container.decode(Double.self, forKey: .tempMax)
            self.parts = try? container.decode(Parts.self, forKey: .parts)
        }
    }
    
    struct Parts: Decodable {
        var dayShort: DayShort?
        var nightShort: NightShort?
        
        enum CodingKeys: String, CodingKey {
            case dayShort = "day_short"
            case nightShort = "night_short"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.dayShort = try? container.decode(DayShort.self, forKey: .dayShort)
            self.nightShort = try? container.decode(NightShort.self, forKey: .nightShort)
        }
    }
    
    struct DayShort: Decodable {
        var temp: Double?
        var tempMin: Double?
        var feelsLike: Double?
        var icon: String?
        var condition: String?
        var windSpeed: Double?
        var windDir: String?
        var pressureMm: Double?
        var humidity: Double?
        var precType: Double?
        var precStrength: Double?
        var cloudness:  Double?
        
        enum CodingKeys: String, CodingKey {
            case temp, icon, condition, humidity, cloudness
            case tempMin = "temp_min"
            case feelsLike = "feels_like"
            case windSpeed = "wind_speed"
            case windDir = "wind_dir"
            case pressureMm = "pressure_mm"
            case precType = "prec_type"
            case precStrength = "prec_strength"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.temp = try? container.decode(Double.self, forKey: .temp)
            self.tempMin = try? container.decode(Double.self, forKey: .tempMin)
            self.feelsLike = try? container.decode(Double.self, forKey: .feelsLike)
            self.icon = try? container.decode(String.self, forKey: .icon)
            self.condition = try? container.decode(String.self, forKey: .condition)
            self.windSpeed = try? container.decode(Double.self, forKey: .windSpeed)
            self.windDir = try? container.decode(String.self, forKey: .windDir)
            self.pressureMm = try? container.decode(Double.self, forKey: .pressureMm)
            self.humidity = try? container.decode(Double.self, forKey: .humidity)
            self.precType = try? container.decode(Double.self, forKey: .precType)
            self.precStrength = try? container.decode(Double.self, forKey: .precStrength)
            self.cloudness = try? container.decode(Double.self, forKey: .cloudness)
        }
    }
    
    struct NightShort: Decodable {
        var temp: Double?
        var feelsLike: Double?
        var icon: String?
        var condition: String?
        var windSpeed: Double?
        var windDir: String?
        var pressureMm: Double?
        var humidity: Double?
        var precType: Double?
        var precStrength: Double?
        var cloudness:  Double?
        
        enum CodingKeys: String, CodingKey {
            case temp, icon, condition, humidity, cloudness
            case feelsLike = "feels_like"
            case windSpeed = "wind_speed"
            case windDir = "wind_dir"
            case pressureMm = "pressure_mm"
            case precType = "prec_type"
            case precStrength = "prec_strength"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.temp = try? container.decode(Double.self, forKey: .temp)
            self.feelsLike = try? container.decode(Double.self, forKey: .feelsLike)
            self.icon = try? container.decode(String.self, forKey: .icon)
            self.condition = try? container.decode(String.self, forKey: .condition)
            self.windSpeed = try? container.decode(Double.self, forKey: .windSpeed)
            self.windDir = try? container.decode(String.self, forKey: .windDir)
            self.pressureMm = try? container.decode(Double.self, forKey: .pressureMm)
            self.humidity = try? container.decode(Double.self, forKey: .humidity)
            self.precType = try? container.decode(Double.self, forKey: .precType)
            self.precStrength = try? container.decode(Double.self, forKey: .precStrength)
            self.cloudness = try? container.decode(Double.self, forKey: .cloudness)
        }
    }
}
