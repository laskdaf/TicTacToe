//
//  ViewController.swift
//  TTT
//
//  Created by Kevin Chang on 6/27/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet var mainMenuButton: UIButton!
    @IBOutlet var currPlayerLabel: UILabel!
    @IBOutlet var playerImage: UIImageView!
    @IBOutlet var winnerLabel: UILabel!

    var currPlayer: Int! = 0
    var players = ["o", "x"]
    var board = [["", "", ""], ["", "", ""], ["", "", ""]]
    var currIndex = [-1, -1]
    var turnCount = 0
    var computer: Bool!
    
    var oAudioPlayer = AVAudioPlayer()
    var xAudioPlayer = AVAudioPlayer()
    var winAudioPlayer = AVAudioPlayer()
    var tryAgainAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if computer == false {
            print("2 players")
            currPlayer = Int(arc4random_uniform(UInt32(2)))
        } else {
            print("1 player")
            currPlayer = 0
//            players[1] = "c"
        }
        let image: UIImage = UIImage(named: players[currPlayer])!
        playerImage.image = image
        
        let oAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("o", ofType: "wav")!)
        do {
            oAudioPlayer = try AVAudioPlayer(contentsOfURL: oAudioURL)
        } catch { }
        
        let xAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("x", ofType: "wav")!)
        do {
            xAudioPlayer = try AVAudioPlayer(contentsOfURL: xAudioURL)
        } catch { }
        
        let winAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("gamewin", ofType: "wav")!)
        do {
            winAudioPlayer = try AVAudioPlayer(contentsOfURL: winAudioURL)
        } catch { }
        
        let tryAgainAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("TryAgain", ofType: "wav")!)
        do {
            tryAgainAudioPlayer = try AVAudioPlayer(contentsOfURL: tryAgainAudioURL)
        } catch { }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func button1Pressed(sender: UIButton) {
        board[0][0] = players[currPlayer]
        buttonClicked(button1, x: 0, y: 0)
    }

    @IBAction func button2Pressed(sender: UIButton) {
        board[0][1] = players[currPlayer]
        buttonClicked(button2, x: 0, y: 1)
    }
    
    @IBAction func button3Pressed(sender: UIButton) {
        board[0][2] = players[currPlayer]
        buttonClicked(button3, x: 0, y: 2)
    }
    
    @IBAction func button4Pressed(sender: UIButton) {
        board[1][0] = players[currPlayer]
        buttonClicked(button4, x: 1, y: 0)
    }
    
    @IBAction func button5Pressed(sender: UIButton) {
        board[1][1] = players[currPlayer]
        buttonClicked(button5, x: 1, y: 1)
    }

    @IBAction func button6Pressed(sender: UIButton) {
        board[1][2] = players[currPlayer]
        buttonClicked(button6, x: 1, y: 2)
    }
    
    @IBAction func button7Pressed(sender: UIButton) {
        board[2][0] = players[currPlayer]
        buttonClicked(button7, x: 2, y: 0)
    }
    
    @IBAction func button8Pressed(sender: UIButton) {
        board[2][1] = players[currPlayer]
        buttonClicked(button8, x: 2, y: 1)
    }
    
    @IBAction func button9Pressed(sender: UIButton) {
        board[2][2] = players[currPlayer]
        buttonClicked(button9, x: 2, y: 2)
    }
    
    @IBAction func newGamePressed(sender: UIButton) {
        newGame()
    }
    
    func buttonClicked(button: UIButton, x: Int, y: Int) {
        turnCount += 1
        currIndex[0] = x
        currIndex[1] = y
        var image: UIImage = UIImage(named: players[currPlayer])!
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.userInteractionEnabled = false

        if players[currPlayer] == "o" {
            oAudioPlayer.play()
        } else if players[currPlayer] == "x" {
            xAudioPlayer.play()
        }
        
        //        printBoard()
        if (checkMatch() == true) {
            win()
            if currPlayer == 1 && computer == true {
                oAudioPlayer.stop()
                xAudioPlayer.stop()
                tryAgainAudioPlayer.play()
            } else {
                winAudioPlayer.play()
            }
        } else if (turnCount == 9) {
            tie()
        } else {
            currPlayer = (currPlayer + 1) % 2
            image = UIImage(named: players[currPlayer])!
            playerImage.image = image
            if currPlayer == 1 && computer == true {
                print("comp turn")
                compTurn()
            }
        }
    }
    
    func compTurn() {
        var x = Int(arc4random_uniform(UInt32(3)))
        var y = Int(arc4random_uniform(UInt32(3)))
        
        while board[x][y] != "" {
            let temp = Int(arc4random_uniform(UInt32(2)))
            if temp == 0 {
                x = (x + 1) % 3
            }
            else {
                y = (x + 1) % 3
            }
        }
        
        var button: UIButton!
        if x == 0 {
            if y == 0 {
                button = button1
            } else if y == 1 {
                button = button2
            } else if y == 2 {
                button = button3
            }
        } else if x == 1 {
            if y == 0 {
                button = button4
            } else if y == 1 {
                button = button5
            } else if y == 2 {
                button = button6
            }
        } else if x == 2 {
            if y == 0 {
                button = button7
            } else if y == 1 {
                button = button8
            } else if y == 2 {
                button = button9
            }
        }
        
        board[x][y] = players[currPlayer]
        buttonClicked(button, x: x, y: y)
    }
    
    func printBoard() {
        for i in 0 ..< 3 {
            var line = ""
            for j in 0 ..< 3 {
                if board[i][j] == "" {
                    line += "_"
                } else {
                    line += board[i][j]
                }
            }
            print(line)
        }
        print("")
    }
    
    func checkMatch() -> Bool {
        if turnCount <= 3 {
            return false
        }
        let x = currIndex[0]
        let y = currIndex[1]
        var rowBool = false
        let curr = board[x][y]
        
        // Check horizontally from curr button
        rowBool = true
        for i in 0 ..< 3 {
            if (curr != board[x][i]) {
                rowBool = false
            }
        }
        if (rowBool == true) {
            return true
        }
        
        // Check vertically from curr button
        rowBool = true
        for i in 0 ..< 3 {
            if (curr != board[i][y]) {
                rowBool = false
            }
        }
        if (rowBool == true) {
            return true
        }
        
        // Check \ diagonal
        if(x == y) {
            rowBool = true
            for i in 0 ..< 3 {
                if (curr != board[i][i]) {
                    rowBool = false
                }
            }
        }
        if (rowBool == true) {
            return true
        }
        
        // Check / diagonal
        if ((abs(x - y) == 2) || (x == 1 && y == 1)) {
            rowBool = true
            for i in 0 ..< 3 {
                if (curr != board[2 - i][i]) {
                    rowBool = false
                }
            }
        }
        if (rowBool == true) {
            return true
        }
        
        return false
    }
    
    func win() {
        button1.userInteractionEnabled = false
        button2.userInteractionEnabled = false
        button3.userInteractionEnabled = false
        button4.userInteractionEnabled = false
        button5.userInteractionEnabled = false
        button6.userInteractionEnabled = false
        button7.userInteractionEnabled = false
        button8.userInteractionEnabled = false
        button9.userInteractionEnabled = false
        currPlayerLabel.hidden = true
        winnerLabel.hidden = false
        newGameButton.hidden = false
        mainMenuButton.hidden = false
    }
    
    func tie() {
        win()
        winnerLabel.text = "TIE!"
        playerImage.hidden = true
    }
    
    func newGame() {
        button1.userInteractionEnabled = true
        button1.setBackgroundImage(nil, forState: UIControlState.Normal)
        button2.userInteractionEnabled = true
        button2.setBackgroundImage(nil, forState: UIControlState.Normal)
        button3.userInteractionEnabled = true
        button3.setBackgroundImage(nil, forState: UIControlState.Normal)
        button4.userInteractionEnabled = true
        button4.setBackgroundImage(nil, forState: UIControlState.Normal)
        button5.userInteractionEnabled = true
        button5.setBackgroundImage(nil, forState: UIControlState.Normal)
        button6.userInteractionEnabled = true
        button6.setBackgroundImage(nil, forState: UIControlState.Normal)
        button7.userInteractionEnabled = true
        button7.setBackgroundImage(nil, forState: UIControlState.Normal)
        button8.userInteractionEnabled = true
        button8.setBackgroundImage(nil, forState: UIControlState.Normal)
        button9.userInteractionEnabled = true
        button9.setBackgroundImage(nil, forState: UIControlState.Normal)
        
        currPlayerLabel.hidden = false
        winnerLabel.text = "is the winner!"
        playerImage.hidden = false
        winnerLabel.hidden = true
        newGameButton.hidden = true
        mainMenuButton.hidden = true
        if computer == false {
            print("2 players")
            currPlayer = (currPlayer + 1) % 2
        } else {
            print("1 player")
            currPlayer = 0
        }
        let image: UIImage = UIImage(named: players[currPlayer])!
        playerImage.image = image
        board = [["", "", ""], ["", "", ""], ["", "", ""]]
        turnCount = 0
        
        winAudioPlayer.stop()
        let winAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("gamewin", ofType: "wav")!)
        do {
            winAudioPlayer = try AVAudioPlayer(contentsOfURL: winAudioURL)
        } catch { }
    }

}

