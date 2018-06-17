//
//  ViewController.swift
//  DiceGame
//
//  Created by Mehmet Anıl Kul on 7.05.2018.
//  Copyright © 2018 Mehmet Anıl Kul. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImages()
        // Bundle.main.path ile path isminde bir yol degiskeni tanimliyoruz. path yazinca gerisi oto tamamlaniyor. resource dosya adi, wav dosya uzantisi
        let path = Bundle.main.path(forResource: "snd", ofType: "wav")
        
        // yukaridaki yolu URL'ye donusturuyoruz.
        let soundURL = URL(fileURLWithPath: path!)
        
        //once bunu dene. olmazsa error yakala
        do {
            //tanimladigimiz URL kullanilarak audio stream yapilacak
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            //calmaya hazirla
            btnSound.prepareToPlay()
        } catch let err as NSError {
            //stream yapilamazsa error ver
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rollButtonPressed(_ sender: Any) {
        updateDiceImages()
        playSound()
    }
    
    func updateDiceImages() {
        repeat {
            randomDiceIndex1 = Int(arc4random_uniform(7)) //arc4random uint32 cikardigi icin Int'e castladik
            randomDiceIndex2 = Int(arc4random_uniform(7))
        } while(randomDiceIndex1 == 0 || randomDiceIndex2 == 0)
        diceImageView1.image = UIImage(named: "dice\(randomDiceIndex1)")
        diceImageView2.image = UIImage(named: "dice\(randomDiceIndex2)")
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
        playSound()
    }
    
    func playSound() {
        // butona basildiginda calan sesi durdur. Art arda basildiginda dit dit dit yerine didididit seklinde ses cikar :)
        if btnSound.isPlaying {
            btnSound.stop()
        }
        // butona basildiginda cal
            btnSound.play()
    }
}

