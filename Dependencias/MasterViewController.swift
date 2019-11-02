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
    var objects = [["Alfredo", "Alicia", "Adrian"],
                   ["Carlos", "Cesar", "Catalina"],
                   ["Diego"],
                   ["Francisco","Federico"],
                   ["Lucia", "Luis", "Lola"],
                   ["Rodrigo", "Rosa", "Ramon", "Ricardo"]]
    
    let sectionIndexes = ["A", "C", "D", "F", "L", "R"]
    
    var isEditingTable = false
    
    var objectsLabel: UILabel?
    
    let defaultImage = UIImage(named: "user-default")
    
    var numberOfElements: Int {
        return self.objects.compactMap{ $0.count }.reduce(0) { $0 + $1 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "custom-cell")
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 80.0))
        container.backgroundColor = .black
        
        let objectsLabel = UILabel(frame: container.frame)
        objectsLabel.textColor = .white
        objectsLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        objectsLabel.textAlignment = .center
        
        container.addSubview(objectsLabel)
        
        self.objectsLabel = objectsLabel
        
        self.tableView.tableFooterView = container
        
        self.objectsLabel?.text = "\(self.numberOfElements) Objects"
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.objects.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom-cell", for: indexPath)
        cell.contentView.backgroundColor = .white
        
        let object = objects[indexPath.section][indexPath.row]
        
        if let customCell = cell as? CustomCell {
            if indexPath.row % 2 == 0 {
                customCell.contentView.backgroundColor = .lightGray
            }
            
            customCell.nameLabel.text = object
            customCell.profileImage.image = self.defaultImage
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionIndexes[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionIndexes
    }
  
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.objects[indexPath.section].remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .right)
            self.objectsLabel?.text = "\(self.numberOfElements) Objects"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = ContactDetailViewController(nibName: "ContactDetailViewController", bundle: nil)
        _ = detail.view
        
        //get selected contact
        let contact = objects[indexPath.section][indexPath.row]
        
        //set contact data to detail
        detail.nameLabel?.text = contact
        
        //push detail
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    @IBAction func editAction(_ sender: Any) {
        self.isEditingTable = !self.isEditingTable
        self.tableView.setEditing(self.isEditingTable, animated: true)
        
        guard let button = sender as? UIButton else {
            return
        }
        
        let title = self.isEditingTable ? "Done" : "Edit"
        button.setTitle(title, for: .normal)
    }
}

