//
//  MasterViewController.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Dependency]()
    var persistanceContainer = PersistanceContainer.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDependenciesIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

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
        cell.textLabel!.text = object.name
        cell.detailTextLabel?.text = object.address
        return cell
    }
}

extension MasterViewController {
    private func fetchDependenciesIfNeeded() {
        let request: NSFetchRequest<Dependency> = Dependency.fetchRequest()
        guard let results = try? self.persistanceContainer.viewContext.fetch(request) as [Dependency], results.count > 0 else {
            self.fetchDependencies()
            return
        }

        self.objects = results
    }

    private func fetchDependencies() {
        //get dependencies from any source
        let mockResults = [("fake dependency A", "fake address A"), ("fake dependency B", "fake address B"), ("fake dependency C", "fake address C"), ("fake dependency D", "fake address D")]
        //create managed objects and save them through context
        for (name, address) in mockResults {
            let dependency = Dependency(context: self.persistanceContainer.viewContext)
            dependency.name = name
            dependency.address = address
        }

        do {
            try self.persistanceContainer.viewContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }

        if mockResults.count > 0 {
            self.fetchDependenciesIfNeeded()
        }
    }
}

