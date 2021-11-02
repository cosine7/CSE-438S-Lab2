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
    
    private var pet: Pet! = nil
    private let layer = CAEmitterLayer()
    private let cell = CAEmitterCell()
    private var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews(dog)
        // Learned from https://www.youtube.com/watch?v=YosPD7eFvcE
        layer.emitterPosition = CGPoint(x: view.center.x, y: 0)
        cell.scale = 0.1
        cell.birthRate = 8
        cell.velocity = 200
        cell.contents = UIImage(named: "partyPopper")!.cgImage
        cell.lifetime = 5
        cell.emissionRange = .pi
        cell.emissionLongitude = .pi
        layer.emitterCells = [cell]
    }
    
    private func configureViews(_ currentPet: Pet) {
        if pet === currentPet {
            return
        }
        pet = currentPet
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
    
    private func makeSound(_ data: Data) {
        // Learned from https://stackoverflow.com/questions/51690084/playing-audio-in-asset-library
        do {
            audioPlayer = try AVAudioPlayer(data: data, fileTypeHint:"wav")
            audioPlayer?.play()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @IBAction func dogButtonPressed(_ sender: Any) {
        configureViews(dog)
    }
    
    @IBAction func catButtonPressed(_ sender: Any) {
        configureViews(cat)
    }
    
    @IBAction func birdButtonPressed(_ sender: Any) {
        configureViews(bird)
    }
    
    @IBAction func bunnyButtonPressed(_ sender: Any) {
        configureViews(bunny)
    }
    
    @IBAction func fishButtonPressed(_ sender: Any) {
        configureViews(fish)
    }
    
    @objc func fireTimer() {
        layer.removeFromSuperlayer()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if pet.foodLevel == 0 {
            return
        }
        makeSound(pet.audio.data)
        pet.happiness += 1
        if pet.happiness == 11 {
            makeSound(NSDataAsset(name: "congratulationSound")!.data)
            view.layer.addSublayer(layer)
            Timer.scheduledTimer(
                timeInterval: 4.0,
                target: self,
                selector: #selector(fireTimer),
                userInfo: nil,
                repeats: false
            )
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
        makeSound(pet.eatingAudio.data)
        pet.foodLevel += 1
        pet.fedCount += 1
        setFoodLevel()
    }
}
