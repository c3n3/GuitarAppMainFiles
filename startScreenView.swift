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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }
    
//I created this instance of the User settings just to check if they have been created, this will only be called on the first use of the app, or if the user deletes their data, without it the seetings will contain nothing, and going into the guitar will crash the app
let defaultSettingsCheck = UserDefaults.standard
    

    override func viewDidLoad() {
        //this is the check I described above
        
        defaultSettingsCheck.set(0, forKey: "preset")

        if defaultSettingsCheck.float(forKey: "fretScale2") == 0 || defaultSettingsCheck.double(forKey: "doubleTapTime") != 0.25 {
            
            let array = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
            
            //this sets the settings if none are made
            defaultSettingsCheck.set(0, forKey: "preset")
            
            defaultSettingsCheck.set(0, forKey: "delayTime")
            defaultSettingsCheck.set(0, forKey: "delayFeedback")
            defaultSettingsCheck.set(1.0, forKey: "fretScale")
            defaultSettingsCheck.set(6, forKey: "stringNumber")
            defaultSettingsCheck.set(4, forKey: "fretCount")
            defaultSettingsCheck.set(array, forKey: "stringTuning")
            defaultSettingsCheck.set(1, forKey: "gain")
            defaultSettingsCheck.set(0, forKey: "distortion")
            defaultSettingsCheck.set(0.25, forKey: "doubleTapTime")
            
            defaultSettingsCheck.set(0, forKey: "delayTime2")
            defaultSettingsCheck.set(0, forKey: "delayFeedback2")
            defaultSettingsCheck.set(1.0, forKey: "fretScale2")
            defaultSettingsCheck.set(6, forKey: "stringNumber2")
            defaultSettingsCheck.set(4, forKey: "fretCount2")
            defaultSettingsCheck.set(array, forKey: "stringTuning2")
            defaultSettingsCheck.set(1, forKey: "gain2")
            defaultSettingsCheck.set(0, forKey: "distortion2")
            defaultSettingsCheck.set(0.25, forKey: "doubleTapTime2")
        }
    }
    //The one and only link to the one and only settings button, which I have done zero with
    @IBAction func settingsButtonClicked(_ sender: UIButton) {
   
    
        
    }
    

    
    

}



    

