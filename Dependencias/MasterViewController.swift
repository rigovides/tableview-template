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

    var dependencies = [Dependency]()

    override func viewDidLoad() {
         self.tableView.register(UINib(nibName: "DependencyTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
        self.fetchDendencies()
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = self.dependencies[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
            }
        }
    }

    private func configureCell(_ cell: DependencyTableViewCell, for dependency: Dependency) {
        cell.mapIconImage.tintColor = UIColor(red: 0.7, green: 0.6, blue: 0.9, alpha: 1.0)
        cell.dependencyNameLabel.text = dependency.name
        cell.dependencyAddressLabel.text = dependency.address
    }
}

// MARK: - TableViewDatasource
extension MasterViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dependencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! DependencyTableViewCell
        self.configureCell(cell, for: self.dependencies[indexPath.row])
        return cell
    }
}

// MARK: - Networking code
extension MasterViewController {
    func fetchDendencies() {
        let url = URL(string: "https://datos.guadalajara.gob.mx/sites/default/files/dependencias_municipales.geojson")

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let root = json as? [String: Any] {
                    for dependencyJSON in root["features"] as! [[String: Any]] {
                        if let dependency = Dependency(json: dependencyJSON) {
                            self.dependencies.append(dependency)
                        }
                    }
                }
            } catch let parsingError {
                print(parsingError)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        task.resume()
    }
}
