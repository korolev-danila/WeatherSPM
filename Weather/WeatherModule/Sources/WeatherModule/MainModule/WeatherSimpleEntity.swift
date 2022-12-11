//
//  File.swift
//  
//
//  Created by Данила on 24.11.2022.
//

import Foundation

struct WeatherSimple: Decodable {
    var info: InfoSimple?
    var fact: FactSimple?
    
    enum CodingKeys: String, CodingKey {
        case info
        case fact
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try? container.decode(InfoSimple.self, forKey: .info)
        self.fact = try? container.decode(FactSimple.self, forKey: .fact)
    }
}

struct InfoSimple: Decodable {
    var tzinfo: TzinfoSimple?
    
    enum CodingKeys: String, CodingKey {
        case tzinfo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tzinfo = try? container.decode(TzinfoSimple.self, forKey: .tzinfo)
    }
}

struct TzinfoSimple: Decodable {
    var offset: Double?
    
    enum CodingKeys: String, CodingKey {
        case offset
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try? container.decode(Double.self, forKey: .offset)
    }
}

struct FactSimple: Decodable {
    var temp: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try? container.decode(Double.self, forKey: .temp)
    }
}
