//
//  DetailViewController.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!

    var detailItem: Any? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "delegatePin")
        self.mapView.delegate = self
    }

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

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "delegatePin"
        let flagAnnotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)

        flagAnnotationView.canShowCallout = true
        flagAnnotationView.image = #imageLiteral(resourceName: "pin-icon")

        return flagAnnotationView
    }
}

