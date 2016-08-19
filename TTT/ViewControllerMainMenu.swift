//
//  ViewControllerMainMenu.swift
//  TTT
//
//  Created by Kevin Chang on 6/27/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit

class ViewControllerMainMenu: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func singlePlayerPressed(sender: UIButton) {
        self.performSegueWithIdentifier("singlePlayer", sender: sender)
    }
    
    @IBAction func twoPlayerPressed(sender: UIButton) {
        self.performSegueWithIdentifier("twoPlayer", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController: ViewController = segue.destinationViewController as! ViewController
        
        if "singlePlayer" == segue.identifier {
            DestViewController.computer = true
        }
        if "twoPlayer" == segue.identifier {
            DestViewController.computer = false

        }
    }
}
