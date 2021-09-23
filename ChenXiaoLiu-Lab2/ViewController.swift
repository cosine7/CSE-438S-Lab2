//
//  ViewController.swift
//  ChenXiaoLiu-Lab2
//
//  Created by lcx on 2021/9/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var happinessBar: DisplayView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func playButtonPressed(_ sender: Any) {
        happinessBar.animateValue(to: CGFloat(0.5))
    }
}

