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
    @IBOutlet weak var finalPickLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    
    
    
    var period = String()
    var names = [String]()
    {
        didSet
        {
            defaults.set(names, forKey: period)
        }
        
    }
    var timer = Timer()
    var cycle = Double()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = period
        navigationController?.navigationBar.barTintColor = UIColor.yellow
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
        finalPickLabel.text = ""
        for i in 0..<min(names.count, nameLabels.count)
        {
            nameLabels[i].text = names[i]
            nameLabels[i].textColor = UIColor.white
        }
        cycle = 2.0
    }
    
    func resetTimer()
    {
        cycle += 0.2
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: cycle, target: self, selector: #selector(updateDisplay), userInfo: nil, repeats: true)
    }
    
    func removeGrayNames()
    {
        for nameLabel in nameLabels
        {
            if nameLabel.textColor == UIColor.red
            {
                nameLabel.text = ""
            }
        }
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
        if nameLabelIndices.count == 0
        {
            let alert = UIAlertController(title: "Please add a name before starting.", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: {
                self.timer.invalidate()
                self.startButton.setTitle("Start", for: .normal)
                self.startButton.setTitleColor(UIColor.green, for: .normal)
            })
        }
        else
        {
            let randomPick = Int(arc4random_uniform(UInt32(nameLabelIndices.count)))
            if nameLabelIndices.count <= 1
            {
                let pickedName = nameLabels[nameLabelIndices[0]].text
                finalPickLabel.text = pickedName
                names.remove(at: names.index(of: pickedName!)!)
                names.append(pickedName!)
                timer.invalidate()
                startButton.setTitle("Reset", for: .normal)
                startButton.setTitleColor(UIColor.yellow, for: .normal)
            }
            nameLabels[nameLabelIndices[randomPick]].text = ""
        }
    }
    @IBAction func onTappedNameLabel(_ sender: UITapGestureRecognizer)
    {
        for nameLabel in nameLabels
        {
            if nameLabel.frame.contains(sender.location(in: labelView))
            {
                if nameLabel.textColor == UIColor.white
                {
                    nameLabel.textColor = UIColor.red
                }
                else
                {
                    nameLabel.textColor = UIColor.white
                }
            }
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
            sender.setTitleColor(UIColor.red, for: .normal)
        case "Stop" :
            timer.invalidate()
            sender.setTitle("Reset", for: .normal)
            sender.setTitleColor(UIColor.yellow, for: .normal)
        default:
            sender.setTitle("Start", for: .normal)
            sender.setTitleColor(UIColor.green, for: .normal)
            resetNames()
        }
        removeGrayNames()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! NamesViewController
        dvc.period = period
    }

}
