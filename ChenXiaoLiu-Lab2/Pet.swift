//
//  Pet.swift
//  ChenXiaoLiu-Lab2
//
//  Created by lcx on 2021/9/22.
//

import Foundation
import UIKit

class Pet {
    let image: UIImage!
    let backgroundColor: UIColor!
    var happiness = 5
    var foodLevel = 5
    var playCount = 0
    var fedCount = 0
    
    init(_ imageName: String, _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) {
        self.image = UIImage(named: imageName)
        self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
