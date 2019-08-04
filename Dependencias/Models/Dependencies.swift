//
//  Dependencies.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import Foundation

struct Dependency {
    let name: String
    let address: String

    init?(json: [String: Any]) {
        guard let  props = json["properties"] as? [String: Any],
            let name = props["dependenc"] as? String,
            let address = props["ubicacion"] as? String else {
                return nil
        }

        self.name = name
        self.address = address
    }
}
