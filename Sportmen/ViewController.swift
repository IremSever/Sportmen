//
//  ViewController.swift
//  Sportmen
//
//  Created by IREM SEVER on 8.02.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func chooseTeamClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
}

