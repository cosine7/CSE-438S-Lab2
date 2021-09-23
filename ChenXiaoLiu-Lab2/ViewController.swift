//
//  ViewController.swift
//  ChenXiaoLiu-Lab2
//
//  Created by lcx on 2021/9/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var happinessBar: DisplayView!
    @IBOutlet weak var topView: UIView!
    
    private let pets = [
        "dog": Pet("dog", 1, 0.31, 0.31),
        "cat": Pet("cat", 0.29, 0.56, 0.98),
        "bird": Pet("bird", 1, 0.86, 0.29),
        "bunny": Pet("bunny", 0.25, 0.81, 0.73),
        "fish": Pet("fish", 0.91, 0.62, 1)
    ]
    private var currentPet = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews("dog")
    }
    
    private func configureViews(_ pet: String) {
        if (pet != currentPet) {
            imageView.image = pets[pet]!.image
            topView.backgroundColor = pets[pet]!.backgroundColor
            currentPet = pet
        }
        
    }
    
    @IBAction func dogButtonPressed(_ sender: Any) {
        configureViews("dog")
    }
    
    @IBAction func catButtonPressed(_ sender: Any) {
        configureViews("cat")
    }
    
    @IBAction func birdButtonPressed(_ sender: Any) {
        configureViews("bird")
    }
    
    @IBAction func bunnyButtonPressed(_ sender: Any) {
        configureViews("bunny")
    }
    
    @IBAction func fishButtonPressed(_ sender: Any) {
        configureViews("fish")
    }
}

