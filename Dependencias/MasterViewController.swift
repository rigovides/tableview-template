//
//  MasterViewController.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = ["First item"]
    var persistanceContainer = PersistanceContainer.shared

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

}

