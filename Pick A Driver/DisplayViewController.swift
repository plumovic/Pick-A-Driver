//
//  DisplayViewController.swift
//  Pick A Driver
//
//  Created by Petar Lumovic on 2/27/18.
//  Copyright © 2018 Petar Lumovic. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController
{
    @IBOutlet var nameLabels: [UILabel]!
    
    var period = String()
    var names = [String]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = period
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let saveData = defaults.object(forKey: period) as? [String]
        {
            names = saveData
        }
        resetNames()
    }
    
    func resetNames()
    {
        for i in 0..<min(names.count, nameLabels.count)
        {
            nameLabels[i].text = names[i]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! NamesViewController
        dvc.period = period
    }

}
