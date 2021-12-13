//
//  Pet.swift
//  ChenXiaoLiu-Lab2
//
//  Created by lcx on 2021/9/22.
//

import Foundation
import UIKit

class Pet {
    let image: UIImage?
    let color: UIColor?
    var playCount = 0
    var fedCount = 0
    var happiness: CGFloat = 0
    var level = 1
    var foodLevel: CGFloat = 0
    let playSound: String
    let eatingSound: String
    
    init(_ image: String, _ color: String, _ playSound: String, _ eatingSound: String) {
        self.image = UIImage(named: image)
        self.color = UIColor(named: color)
        self.playSound = playSound
        self.eatingSound = eatingSound
    }
}
