//
//  SSFModel.swift
//  SSF
//
//  Created by Valentin Limagne on 19/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

struct Ssf: Codable {
    let id: String
    let name: String
    let ctds: [Ctds?]
}

struct Ctds: Codable {
    let name: String
    let phonePerso: String
    let phoneWork: String
    let phoneMobile: String
}
