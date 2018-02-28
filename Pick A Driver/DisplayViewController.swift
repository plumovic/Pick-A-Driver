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
    @IBOutlet weak var startButton: UIButton!
    
    var period = String()
    var names = [String]()
    var timer = Timer()
    var cycle = Double()
    
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
        cycle = 2.0
    }
    
    func resetTimer()
    {
        cycle += 0.2
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: cycle, target: self, selector: #selector(updateDisplay), userInfo: nil, repeats: true)
    }
    
    @objc func updateDisplay()
    {
        resetTimer()
        var nameLabelIndices = [Int]()
        for i in 0..<nameLabels.count
        {
            if nameLabels[i].text != ""
            {
                nameLabelIndices.append(i)
            }
        }
        let randomPick = Int(arc4random_uniform(UInt32(nameLabelIndices.count)))
        nameLabels[nameLabelIndices[randomPick]].text = ""
        if nameLabelIndices.count <= 2
        {
            timer.invalidate()
            startButton.setTitle("Reset", for: .normal)
            startButton.backgroundColor = UIColor.yellow
        }
    }
    
    @IBAction func onStartButtonTapped(_ sender: UIButton)
    {
        let title = sender.titleLabel!.text!
        switch title
        {
        case "Start" :
            resetTimer()
            sender.setTitle("Stop", for: .normal)
            sender.backgroundColor = UIColor.red
        case "Stop" :
            timer.invalidate()
            sender.setTitle("Reset", for: .normal)
            sender.backgroundColor = UIColor.yellow
        default:
            updateDisplay()
            sender.setTitle("Start", for: .normal)
            sender.backgroundColor = UIColor.green
            resetNames()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! NamesViewController
        dvc.period = period
    }

}
