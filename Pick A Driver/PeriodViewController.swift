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

    }

    @IBAction func onPeriodButtonTapped(_ sender: UIButton)
    {
        period = (sender.titleLabel?.text)!
        performSegue(withIdentifier: "PeriodToNameSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! NamesViewController
        dvc.period = period
    }
    
}
