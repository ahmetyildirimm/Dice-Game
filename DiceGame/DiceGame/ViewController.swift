//
//  ViewController.swift
//  DiceGame
//
//  Created by Ahmet Yıldırım on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblPlayer1Score: UILabel!
    @IBOutlet weak var lblPlayer2Score: UILabel!
    @IBOutlet weak var lblPlayer1Point: UILabel!
    @IBOutlet weak var lblPlayer2Point: UILabel!
    @IBOutlet weak var imgPlayer1Status: UIImageView!
    @IBOutlet weak var imgPlayer2Status: UIImageView!
    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!
    @IBOutlet weak var lblSetResult: UILabel!
    
    var playerScores = (firstPlayerScore : 0, secondPlayerScore : 0)
    var playerPoints = (firstPlayerPoint : 0, secondPlayerPoint : 0)
    var playerRow : Int = 1
    
    
    var maxSetNumber : Int = 5
    var currentSet : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
        if let background = UIImage(named:"arkaPlan") {
            self.view.backgroundColor = UIColor(patternImage: background)
        }
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if currentSet > maxSetNumber {
            return
        }
        
        generateDiceValues()
        
    }
    
    func setResult(dice1 : Int, dice2 : Int){
        
        if playerRow == 1 {
//            new set started
            
            playerPoints.firstPlayerPoint = dice1 + dice2
            lblPlayer1Point.text = String(playerPoints.firstPlayerPoint)
            imgPlayer1Status.image = UIImage(named: "bekle")
            imgPlayer2Status.image = UIImage(named: "onay")
            lblSetResult.text = "The 2.player is waiting."
            playerRow = 2
            lblPlayer2Point.text = "0"
            
        } else {
            
            playerPoints.secondPlayerPoint = dice1 + dice2
            lblPlayer2Point.text = String(playerPoints.secondPlayerPoint)
            imgPlayer1Status.image = UIImage(named: "onay")
            imgPlayer2Status.image = UIImage(named: "bekle")
            playerRow = 1
//            set finishing operations
            
            if playerPoints.firstPlayerPoint > playerPoints.secondPlayerPoint {
                
//                first player win
                playerScores.firstPlayerScore += 1
                lblPlayer1Score.text = String(playerScores.firstPlayerScore)
                lblSetResult.text = "\(currentSet). set First Player Wins"
                currentSet += 1
            } else if playerPoints.secondPlayerPoint > playerPoints.firstPlayerPoint {
                
                playerScores.secondPlayerScore += 1
                lblPlayer2Score.text = String(playerScores.secondPlayerScore)
                lblSetResult.text = "\(currentSet). set Second Player Wins"
                currentSet += 1
            }else {
                lblSetResult.text = "DRAW"
            }
            
            playerPoints.firstPlayerPoint = 0
            playerPoints.secondPlayerPoint = 0
        }
        
    }
    
    func generateDiceValues(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            
            let dice1 = arc4random_uniform(6) + 1
            let dice2 = arc4random_uniform(6) + 1
            
            self.imgDice1.image = UIImage(named: String(dice1))
            self.imgDice2.image = UIImage(named: String(dice2))
            
            self.setResult(dice1: Int(dice1), dice2: Int(dice2))
            
            if self.currentSet > self.maxSetNumber {
                
                if self.playerScores.firstPlayerScore > self.playerScores.secondPlayerScore {
                    self.lblSetResult.text = "First Player Wins"
                }else {
                    self.lblSetResult.text = "Second Player Wins"
                }
            }
        }
        
        lblSetResult.text = "\(playerRow). Player Dice Rolling"
        imgDice1.image = UIImage(named: "bilinmeyenZar")
        imgDice2.image = UIImage(named: "bilinmeyenZar")
    }


}

