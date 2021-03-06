//
//  PeriodViewController.swift
//  Pick A Driver
//
//  Created by Petar Lumovic on 2/8/18.
//  Copyright © 2018 Petar Lumovic. All rights reserved.
//

import UIKit

class PeriodViewController: UIViewController
{

    var period = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.yellow
    }

    @IBAction func onPeriodButtonTapped(_ sender: UIButton)
    {
        period = (sender.titleLabel?.text)!
        performSegue(withIdentifier: "PeriodToDisplaySegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! DisplayViewController
        dvc.period = period
    }
    
}
