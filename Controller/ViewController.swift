//
//  ViewController.swift
//  ChenXiaoLiu-Lab2
//
//  Created by lcx on 2021/9/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var happinessBar: DisplayView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var playedCountLabel: UILabel!
    @IBOutlet weak var fedCountLabel: UILabel!
    @IBOutlet weak var foodLevelBar: DisplayView!
    @IBOutlet weak var levelLabel: UILabel!
    
    private let dog = Pet("dog", "red", "dogBark", "dogEating")
    private let cat = Pet("cat", "blue", "catMeow", "catEating")
    private let bird = Pet("bird", "yellow", "birdSound", "birdEating")
    private let bunny = Pet("bunny", "green", "rabbitSound", "rabbitEating")
    private let fish = Pet("fish", "purple", "fishSound", "fishEating")
    
    private var pet: Pet {
        didSet {
            configureViews()
        }
    }
    
    private lazy var layer: CAEmitterLayer = {
        let cell = CAEmitterCell()
        cell.scale = 0.1
        cell.birthRate = 8
        cell.velocity = 200
        cell.contents = UIImage(named: "partyPopper")!.cgImage
        cell.lifetime = 5
        cell.emissionRange = .pi
        cell.emissionLongitude = .pi
        
        let layer = CAEmitterLayer()
        layer.emitterPosition = CGPoint(x: view.center.x, y: 0)
        layer.emitterCells = [cell]
        return layer
    } ()
    
    private var audioPlayer: AVAudioPlayer?
    
    required init?(coder: NSCoder) {
        pet = dog
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        imageView.image = pet.image
        topView.backgroundColor = pet.color
        happinessBar.color = pet.color
        foodLevelBar.color = pet.color
        setFoodLevel()
        setHappiness()
        setLevel()
    }
    
    private func setHappiness() {
        happinessBar.animateValue(to: pet.happiness / 10.0)
        playedCountLabel.text = "Played: \(pet.playCount)"
    }
    
    private func setFoodLevel() {
        foodLevelBar.animateValue(to: pet.foodLevel / 10.0)
        fedCountLabel.text = "Fed: \(pet.fedCount)"
    }
    
    private func setLevel() {
        levelLabel.text = "Lv. \(pet.level)"
    }
    
    private func makeSound(_ name: String) {
        guard let sound = NSDataAsset(name: name) else { return }
        audioPlayer = try? AVAudioPlayer(data: sound.data, fileTypeHint: "wav")
        audioPlayer?.play()
    }
    
    @IBAction func petSelected(_ sender: UIButton) {
        guard let selectedPet = sender.restorationIdentifier else { return }
        switch selectedPet {
        case "dog":
            pet = dog
        case "cat":
            pet = cat
        case "bird":
            pet = bird
        case "bunny":
            pet = bunny
        case "fish":
            pet = fish
        default:
            break
        }
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if pet.foodLevel == 0 {
            return
        }
        makeSound(pet.playSound)
        pet.happiness += 1
        if pet.happiness == 11 {
            makeSound("congratulationSound")
            view.layer.addSublayer(layer)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.layer.removeFromSuperlayer()
            }
            pet.happiness = 0
            pet.level += 1
            setLevel()
        }
        pet.foodLevel -= 1
        pet.playCount += 1
        setFoodLevel()
        setHappiness()
    }
    
    @IBAction func feedButtonPressed(_ sender: Any) {
        if pet.foodLevel == 10 {
            return
        }
        makeSound(pet.eatingSound)
        pet.foodLevel += 1
        pet.fedCount += 1
        setFoodLevel()
    }
}
