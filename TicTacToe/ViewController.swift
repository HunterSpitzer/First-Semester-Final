//
//  ViewController.swift
//  Connect Four
//
//  Created by hspitzer on 2/8/1437 AH.
//  Copyright (c) 1437 AH Quantum Reality Applications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //connects labels and views
    @IBOutlet weak var turnLabel: UILabel! //info text
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    @IBOutlet weak var gridLabel9: GridLabel!
    @IBOutlet weak var gridLabel10: GridLabel!
    @IBOutlet weak var gridLabel11: GridLabel!
    @IBOutlet weak var gridLabel12: GridLabel!
    @IBOutlet weak var gridLabel13: GridLabel!
    @IBOutlet weak var gridLabel14: GridLabel!
    @IBOutlet weak var gridLabel15: GridLabel!
    var labelsArray = [GridLabel]()
    var p1Turn = true
    //p1 = Player one
    
    override func viewDidLoad() {
        
        // adds labels to array to later be drawn froma
        super.viewDidLoad()
        labelsArray.append(gridLabel0)
        labelsArray.append(gridLabel1)
        labelsArray.append(gridLabel2)
        labelsArray.append(gridLabel3)
        labelsArray.append(gridLabel4)
        labelsArray.append(gridLabel5)
        labelsArray.append(gridLabel6)
        labelsArray.append(gridLabel7)
        labelsArray.append(gridLabel8)
        labelsArray.append(gridLabel9)
        labelsArray.append(gridLabel10)
        labelsArray.append(gridLabel11)
        labelsArray.append(gridLabel12)
        labelsArray.append(gridLabel13)
        labelsArray.append(gridLabel14)
        labelsArray.append(gridLabel15)
    }
    
    @IBAction func onTappedGridLabel(sender: UITapGestureRecognizer) {
        var draw = true //draw = tie
        for label in labelsArray{
            if CGRectContainsPoint(label.frame,sender.locationInView(backgroundView)) {
                if label.canTap {
                    if p1Turn{
                        label.text = "★"  // if player ones turn set icon and color to...
                        label.textColor = UIColor.redColor()
                        turnLabel.text = "Player Two, Tap an Empty Square!"
                    }
                    else {
                        label.text = "☆" // if player twos turn set icon and color to...
                        label.textColor = UIColor.yellowColor()
                        turnLabel.text = "Player One, Tap an Empty Square!"
                        
                    }
                    p1Turn = !p1Turn
                    label.canTap = false
                    checkForWinner()
                } //if there are no more free spaces then check for winner
            }
            else {
                if label.canTap{
                    draw = false //otherwise countinue play
                }
            }
            
        }
        if draw {
            presentWinningAlert("Draw!")//if check for winner comes back negative then present draw alert
        }
        
    }
    
    func checkForWinner() { //checks all possible combinations
        checkLine(0, b: 1, c: 2, d: 9)
        checkLine(3, b: 4, c: 5, d: 10)
        checkLine(6, b: 7, c: 8, d: 11)
        checkLine(0, b: 3, c: 6, d: 12)
        checkLine(1, b: 4, c: 7, d: 13)
        checkLine(2, b: 5, c: 8, d: 14)
        checkLine(0, b: 4, c: 8, d: 15)
        checkLine(12, b: 7, c: 5, d: 9)
        checkLine(12, b: 13, c: 14, d:15)
        checkLine(9, b: 10, c: 11, d: 15)
    }
    
    func checkLine(a: Int, b: Int, c: Int, d: Int) { //has to check a, b, c, and d ->connect "four"
        if labelsArray[a].text == labelsArray[b].text &&
            labelsArray[b].text == labelsArray[c].text && labelsArray[c].text == labelsArray[d].text &&
            labelsArray[a].text != "" {
                presentWinningAlert("\(labelsArray[a].text!) wins!") //retrives text value and adds wins!
        }
    }
    
    func presentWinningAlert(winner: String) { // winner or draw pop-up
        let alert = UIAlertController(title: winner, message: nil, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Restart", style: .Default){
            (action) -> Void in //gives players option to restart the game
            self.resetGame()
            
        }
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func resetGame() { // reset pop-up 
        for label in labelsArray {
            label.text = ""
            label.canTap = true
            turnLabel.text = "Red Will Start The Next Game!" //sets info text to...
        }
        p1Turn = true
        
    }
}

