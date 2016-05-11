//
//  ViewController.swift
//  myLittleMonster
//
//  Created by Tobias Gozzi on 27.04.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var bgBrown: UIImageView!
    @IBOutlet weak var groundBrown: UIImageView!
    @IBOutlet weak var bgBlue: UIImageView!
    @IBOutlet weak var groundBlue: UIImageView!
    
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var monsterSnail: MonsterImg!
    
    @IBOutlet weak var heart: DragImg!
    @IBOutlet weak var food: DragImg!
    @IBOutlet weak var slash: DragImg!
    
    
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penaly3Img: UIImageView!
    @IBOutlet weak var replayBtn: UIButton!
    @IBOutlet weak var replayBg: UIView!
    
    @IBOutlet weak var chooseCharacterView: UIView!
    @IBOutlet weak var chooseCharacterLbl: UILabel!
    @IBOutlet weak var monsterSnailSelectBtn: UIButton!
    @IBOutlet weak var monterStoneSelectBtn: UIButton!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPACE: CGFloat = 1.0
    let MAX_PENALTYES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monserHappy = false
    var currentItem : UInt32 = 0
    
    var musicPlayer : AVAudioPlayer!
    
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            
            sfxSkull.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxBite.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
    }
    
    
    @IBAction func choosingCharacter(sender: UIButton) {
        if sender.tag == 0 {
            groundBrown.hidden = true
            bgBrown.hidden = true
            monsterImg.image = UIImage(named: "blue_idle (1).png")
            monsterImg.monsterType = "snail"
        } else {
            groundBlue.hidden = true
            bgBlue.hidden = true
            monsterImg.image = UIImage(named: "idle 1.png")
            monsterImg.monsterType = "rock"
        }
        chooseCharacterView.hidden = true
        startGame()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject?) {
        monserHappy = true
        startTimer()
        
        food.alpha = DIM_ALPHA
        food.userInteractionEnabled = false
        heart.alpha = DIM_ALPHA
        heart.userInteractionEnabled = false
        slash.alpha = DIM_ALPHA
        slash.userInteractionEnabled = false
        
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameStats), userInfo: nil, repeats: true)
    }
    
    func changeGameStats() {
        
        if !monserHappy {
            
            penalties += 1
            
            sfxSkull.play()
            
            if penalties == 1 {
                penalty1Img.alpha = OPACE
                penalty2Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPACE
                penaly3Img.alpha = DIM_ALPHA
                
            } else if penalties >= 3 {
                penaly3Img.alpha = OPACE
            }else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penaly3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTYES {
                gameOver()
            }

        }
        
        let rand = arc4random_uniform(3)
        
        if rand == 0 {
            food.alpha = DIM_ALPHA
            food.userInteractionEnabled = false
            slash.alpha = DIM_ALPHA
            slash.userInteractionEnabled = false
            
            heart.alpha = OPACE
            heart.userInteractionEnabled = true
        } else if rand == 1 {
            heart.alpha = DIM_ALPHA
            heart.userInteractionEnabled = false
            slash.alpha = DIM_ALPHA
            slash.userInteractionEnabled = false
            
            food.alpha = OPACE
            food.userInteractionEnabled = true
        } else {
            heart.alpha = DIM_ALPHA
            heart.userInteractionEnabled = false
            food.alpha = DIM_ALPHA
            food.userInteractionEnabled = false
            
            slash.alpha = OPACE
            slash.userInteractionEnabled = true
        }
        
        currentItem = rand
        monserHappy = false
        
        
    }
    
    @IBAction func startGame() {
        food.dropTarget = monsterImg
        heart.dropTarget = monsterImg
        slash.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penaly3Img.alpha = DIM_ALPHA
        monsterImg.startingAnimation(isDeadAnimation: false, monsterType: monsterImg.monsterType)
        
        penalties = 0
        replayBg.hidden = true
        replayBtn.hidden = true
        
        musicPlayer.play()

        startTimer()
    }
    
    func gameOver() {
        timer.invalidate()
        sfxDeath.play()
        monsterImg.startingAnimation(isDeadAnimation: true, monsterType: monsterImg.monsterType)
        musicPlayer.stop()
        
        heart.alpha = DIM_ALPHA
        food.alpha = DIM_ALPHA
        slash.alpha = DIM_ALPHA
        
        replayBg.hidden = false
        replayBtn.hidden = false
        
        
    }
    
    
}

