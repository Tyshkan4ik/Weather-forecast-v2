//
//  Forecast5daysRequest.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 18.04.2023.
//

import Foundation

struct Forecast5daysRequest: RequestApiProtocol {
    let lat: String
    let lon: String
    var url: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&lang=ru&appid=1e3d0428bdc917c421e87a8b9a19fcde")!
    }
    
    var urlRequest: URLRequest? {
        return URLRequest(url: url)
    }
}
