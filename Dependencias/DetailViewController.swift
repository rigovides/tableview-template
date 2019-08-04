//
//  DetailViewController.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    var detailItem: Any? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

