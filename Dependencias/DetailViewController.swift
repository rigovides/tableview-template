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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let dependency = detailItem as? Dependency else {
            return
        }

        let region = MKCoordinateRegion(center: dependency.location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))

        self.mapView.setRegion(region, animated: true)
        self.addAnnotation(for: dependency)
    }

    func addAnnotation(for dependency: Dependency) {
        self.mapView.addAnnotation(dependency)
    }
}

