//
//  ListOfCitiesRequest.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 20.04.2023.
//

import Foundation

struct ListOfCitiesRequest: RequestApiProtocol {
    let city: String
    var url: URL {
        if URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=1e3d0428bdc917c421e87a8b9a19fcde") != nil {
            return URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=1e3d0428bdc917c421e87a8b9a19fcde")!
        } else {
            return URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=&limit=5&appid=1e3d0428bdc917c421e87a8b9a19fcde")!
        }
    }
    
    var urlRequest: URLRequest? {
        return URLRequest(url: url)
    }
}
