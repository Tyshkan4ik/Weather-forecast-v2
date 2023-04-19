//
//  ForecastCityModel.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 18.04.2023.
//

import Foundation

struct ForecastCityModel {
    var firstSectionModel: ForecastTodayModel?
    var secondSectionModel: DetailedForecastTodayModel?
    var thirdSectionModel: [Forecast5DaysModel]?
    var favoritesOnOff = false
    var id: Int?
    var lon: Double?
    var lat: Double?
}
