//
//  MasterViewController.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    private let cellReuseIdentifier = "dependencyCell"

    var objects: [[String: Any]] = [["Unidad de Registro Civil": "Morelos #65"]]

    override func viewDidLoad() {
         self.tableView.register(UINib(nibName: "DependencyTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as [String: Any]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
            }
        }
    }

    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! DependencyTableViewCell
        cell.mapIconImage.tintColor = UIColor(red: 0.7, green: 0.6, blue: 0.9, alpha: 1.0)
        //TODO: implement cell data population
        return cell
    }
}
