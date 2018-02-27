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
    var period = String()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = period
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! NamesViewController
        dvc.period = period
    }

}
