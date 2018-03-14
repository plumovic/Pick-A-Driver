//
//  ViewController.swift
//  Pick A Driver
//
//  Created by Petar Lumovic on 2/6/18.
//  Copyright © 2018 Petar Lumovic. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    var period = String()
    var names = [String()]
    {
        didSet
        {
            defaults.set(names, forKey: period)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        
        tableView.isEditing = true
        if let savedData = defaults.object(forKey: period) as? [String]
        {
            names = savedData
        }
        navigationItem.title = period
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = names[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.names.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let moved = self.names[indexPath.row]
        names.remove(at: indexPath.row)
        names.insert(moved, at: destinationIndexPath.row)
        self.tableView.reloadData()
    }
    
    @IBAction func onAddButtonTapped(_ sender: Any)
    {
        let alert = UIAlertController(title: "Add a Name", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let insertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let nameTextField = alert.textFields![0] as UITextField
            let name = nameTextField.text
            self.names.append(name!)
            self.tableView.reloadData()
        }
        alert.addAction(insertAction)
        present(alert, animated: true, completion: nil)
    }
}

