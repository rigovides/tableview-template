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
        
        fetchDependencies() { dependencies, error in
            guard let dependencies = dependencies, error == nil else {
                //show UIAlertViewController
                return
            }
            
            self.dependencies = dependencies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        cell.dependencyNameLabel?.text = dependency.name
        cell.dependencyAddressLabel?.text = dependency.address
        return cell
    }
    
    fileprivate func fetchDependencies(completion: @escaping (([Dependency]?, Error?) -> Void)) {
        let url = URL(string: "https://datos.guadalajara.gob.mx/sites/default/files/dependencias_municipales.geojson")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
                return
            }
            
            guard let data = data else { return }
            var dependencies = [Dependency]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let root = json as? [String : Any] {
                    if let features = root["features"] as? [[String : Any]] {
//                        features.forEach { feature in
//                            if let dependency = Dependency(json: feature) {
//                                self.dependencies.append(dependency)
//                            }
//                        }
                        
                        dependencies = features.compactMap { Dependency(json: $0) }
                    }
                    
                    
                }
            } catch {
                print(error)
                completion(nil, error)
            }
            
            completion(dependencies, nil)
        }
        
        task.resume()
    }
}
