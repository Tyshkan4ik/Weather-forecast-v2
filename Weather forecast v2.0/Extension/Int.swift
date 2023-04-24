//
//  Int.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 24.04.2023.
//

import Foundation

extension Int {
    /// Перевод величины давления из hPa в mmHg
    /// - Parameter hPa: Давление в hPa
    /// - Returns: Давление в mmHg, String
    func conversionHPaInMmHg() -> String {
        "\(Int(Double(self) * 0.75006375541921))"
    }
}
