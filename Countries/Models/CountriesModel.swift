//
//  CountriesModel.swift
//  Countries
//
//  Created by Omar Hesham on 9/18/23.
//

import Foundation

struct CountriesModel: Decodable {
    let name: String?
    let region: String?
    let code: String?
    let capital: String?
}
