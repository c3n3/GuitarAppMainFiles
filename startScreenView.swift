//
//  ViewController.swift
//  Guitar
//
//  Created by caden on 12/16/18.
//  Copyright © 2018 caden. All rights reserved.
//

import UIKit
import SpriteKit


//This is the start screen code representation of the the Storyboards View, not much is going on here
class startScreenView: UIViewController {
    
//I created this instance of the User settings just to check if they have been created, this will only be called on the first use of the app, or if the user deletes their data, without it the seetings will contain nothing, and going into the guitar will crash the app
let defaultSettingsCheck = UserDefaults.standard
    

    override func viewDidLoad() {
        //this is the check I described above
        if defaultSettingsCheck.float(forKey: "fretScale") == 0 {
            
            //this sets the settings if none are made
            defaultSettingsCheck.set(1.0, forKey: "fretScale")
            defaultSettingsCheck.set(6, forKey: "stringNumber")
            
        }
    }
    //The one and only link to the one and only settings button, which I have done zero with
    @IBAction func settingsButtonClicked(_ sender: UIButton) {
   
    
        
    }
    

    
    

}



    

