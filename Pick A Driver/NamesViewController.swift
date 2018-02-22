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
    
    var period = String()
    var names = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.isEditing = true
        
        loadTestNames()
        navigationItem.title = period
    }

    func loadTestNames()
    {
        switch period
        {
        case "1st Period":
            names = ["Petar", "George", "John", "Quinn", "Leah"]
        case "2nd Period":
            names = ["Will", "Mary", "Brendon", "Jim", "Yo", "Tim"]
        case "3rd Period":
            names = ["Jan", "Mam", "Tori", "Amer", "Sam"]
        default:
            names = ["Sue", "Gertrude", "Hilda", "Torgnee", "Sigbar"]
        }
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
            self.names.remove(at: self.names.count)
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
    
    
    @IBAction func onPeriodButtonTapped(_ sender: UIButton)
    {
        
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

