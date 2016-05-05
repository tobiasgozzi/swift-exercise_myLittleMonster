//
//  ViewController.swift
//  myLittleMonster
//
//  Created by Tobias Gozzi on 27.04.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var heart: DragImg!
    @IBOutlet weak var food: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penaly3Img: UIImageView!
    
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPACE: CGFloat = 1.0
    let MAX_PENALTYES = 3
    
    var penalties = 0
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        food.dropTarget = monsterImg
        heart.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penaly3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        monsterImg.startingAnimation(isDeadAnimation: false)
        startTimer()
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject?) {
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameStats", userInfo: nil, repeats: true)
    }
    
    func changeGameStats() {
        penalties += 1
        
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
    
    func gameOver() {
        timer.invalidate()
        monsterImg.startingAnimation(isDeadAnimation: true)
    }

}

