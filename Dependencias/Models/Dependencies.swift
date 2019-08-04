//
//  Dependencies.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import Foundation
import CoreLocation

struct Dependency {
    let name: String
    let address: String
    let location: CLLocation

    init?(json: [String: Any]) {
        guard let  props = json["properties"] as? [String: Any],
            let name = props["dependenc"] as? String,
            let address = props["ubicacion"] as? String else {
                return nil
        }

        guard let geometry = json["geometry"] as? [String: Any],
            let rawCoordinates = geometry["coordinates"] as? [Any],
            let location = Dependency.convertToLocation(from: rawCoordinates) else {
                return nil
        }

        self.name = name
        self.address = address
        self.location = location
    }

    static func convertToLocation(from rawCoordinate: [Any]) -> CLLocation? {
        guard let coordinates = rawCoordinate.first as? [Double] else {
            return nil
        }

        return CLLocation(latitude: coordinates.last!, longitude: coordinates.first!)
    }
}
