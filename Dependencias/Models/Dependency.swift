//
//  Dependency.swift
//  Dependencias
//
//  Created by usuario on 11/9/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import Foundation

class Dependency {
    var name: String
    var address: String
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
    
    init?(json: [String : Any]) {
        guard let properties = json["properties"] as? [String : String] else {
            return nil
        }
        
        let name = properties["dependenc"] ?? ""
        let address = properties["ubicacion"] ?? ""
        
        self.name = name
        self.address = address
    }
}
