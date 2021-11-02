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
    let color: UIColor!
    var playCount = 0
    var fedCount = 0
    var happiness: CGFloat = 0
    var level = 1
    var foodLevel: CGFloat = 0
    let audio: NSDataAsset!
    let eatingAudio: NSDataAsset!
    
    init(_ imageName: String, _ colorName: String, _ audioName: String, _ eatingAudioName: String) {
        self.image = UIImage(named: imageName)
        self.color = UIColor(named: colorName)
        audio = NSDataAsset(name: audioName)
        eatingAudio = NSDataAsset(name: eatingAudioName)
    }
}
