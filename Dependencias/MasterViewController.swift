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

    var dependencies = [[String: Any]]()

    override func viewDidLoad() {
         self.tableView.register(UINib(nibName: "DependencyTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
        //https://datos.guadalajara.gob.mx/sites/default/files/dependencias_municipales.geojson
        let url = URL(string: "https://datos.guadalajara.gob.mx/sites/default/files/dependencias_municipales.geojson")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
                return
            }

            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let root = json as? [String : Any] {
                    if let features = root["features"] as? [[String : Any]] {
                        features.forEach { feature in
                            guard let properties = feature["properties"] as? [String : String] else {
                                return
                            }
                            var dependency = [String : String]()
                            dependency["name"] = properties["dependenc"]
                            dependency["address"] = properties["ubicacion"]
                            
                            self.dependencies.append(dependency)
                        }
                    }
                }
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = dependencies[indexPath.row] as [String: Any]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
            }
        }
    }

    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dependencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! DependencyTableViewCell
        cell.mapIconImage.tintColor = UIColor(red: 0.7, green: 0.6, blue: 0.9, alpha: 1.0)
        //TODO: implement cell data population
        
        let dependency = self.dependencies[indexPath.row]
        cell.dependencyNameLabel?.text = dependency["name"] as? String
        cell.dependencyAddressLabel?.text = dependency["address"] as? String
        return cell
    }
}
