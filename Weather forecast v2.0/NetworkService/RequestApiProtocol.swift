//
//  RequestApiProtocol.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 18.04.2023.
//

import Foundation

protocol RequestApiProtocol {
    var urlRequest: URLRequest? { get }
}

extension RequestApiProtocol {
    var token: String {
        return "1e3d0428bdc917c421e87a8b9a19fcde"
    }
}
