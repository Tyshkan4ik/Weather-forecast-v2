//
//  NetworkService.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 06.04.2023.
//

import Foundation

struct NetworkService {
    private func get<T: Decodable>(with request: URLRequest, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(.failure(FetchError.noDataReceived))
                return
            }
            do {
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private enum FetchError: Error {
        case noHTTPResponse
        case noDataReceived
        case unacceptableStatusCode
    }
}

extension NetworkService {
    func getForecastToday(for source: RequestApiProtocol, completion: @escaping (Result<ForecastTodayResponce, Error>) -> Void) {
        let request = source
        get(with: request.urlRequest!, completion: completion)
    }
    
    func getForecast5Days(for source: RequestApiProtocol, completion: @escaping (Result<Forecast5DaysResponce, Error>) -> Void) {
        let request = source
        get(with: request.urlRequest!, completion: completion)
    }
    
    func getListOfCities(for source: RequestApiProtocol, completion: @escaping (Result<[ListOfCitiesResponce], Error>) -> Void) {
        let request = source
        get(with: request.urlRequest!, completion: completion)
    }
}
