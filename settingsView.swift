//
//  settingsView.swift
//  Guitar
//
//  Created by cad on 12/17/18.
//  Copyright © 2018 caden. All rights reserved.
//

import Foundation
import UIKit

//This file's purpose is to handle the View that houses all of the settings




//this is a view class That I have linked to The story board View controller, The way I linked it is by going to the strory board, clicked on the top part of the sudo phone screen, which is the view controller, and the in went to the top right hand side of Xcode and clicked on the identity inspector (hover the mouse for it to show names)
class settingsView: UIViewController {
    
    
    //labels for the displaying of User interface elements: the slider and the "stepper" are the current ones, This code creates objects that are linked to the StoryBoard. The StoryBoard is the graphical programing file where you drag and drop stuff in
    @IBOutlet weak var fretScaleLabel: UILabel!
    @IBOutlet weak var labelStrings: UILabel!
    
    
    //same as the ones above except these represent the slider and the stepper themselves, NOT the Labels that displayes text to the user
    @IBOutlet weak var stringStepper: UIStepper!
    @IBOutlet weak var fretSlider: UISlider!
    
    
    //This Variable contais the slider value
    var sliderNumber: Float = 1.0
    
    //This is our reference to the "settings" or What the app will store indefinitly and reads from each time it is called, these are global. settings is a dictionary, key is a string
    let settings = UserDefaults.standard
    
    // viewDidLoad is just how it sounds, most things in swift try to be this way, This is a function that is called when the view is loaded, The view in this instance is settingsView
    override func viewDidLoad() {
        //setup for settings and visuals acording to past settings
        
        
        //When the view is loaded, we want the slider to display what the User has their settings at, this does that
        fretSlider.value = settings.float(forKey: "fretScale")
        
        //same this as above
        stringStepper.value = Double(settings.integer(forKey: "stringNumber"))
        
        //This sets the value for the Label of the slider
        fretScaleLabel.text = "Scale:    \((floor(100*settings.float(forKey: "fretScale"))/100))"
        
        //IDK why I have this as it is identical to one of the ones above, but ill leave it here for u
        fretSlider.value = settings.float(forKey: "fretScale")
        
        //This is same as the one above the one above
        labelStrings.text = "String Number: \(settings.integer(forKey: "stringNumber"))"

        //Also in swift when making strings \() will encapsulate whatever is in the parenthiseees into the string "hello people i have \(someVariableForNumberOfFruit) fruit(s)"
    
    }
    
    //This is a function that is linked to the storyBoard Slider and is called whenever the slider is moved, I use it to update the label text to whatever the slider moved to AND the global settings
    @IBAction func sliderMoved(_ sender: UISlider) {
    
        settings.set(Float(sender.value), forKey: "fretScale")
         fretScaleLabel.text = "Scale:    \((floor(100*settings.float(forKey: "fretScale"))/100))"
    }
    //same thingy
    @IBAction func stringStepperMoved(_ sender: UIStepper) {
        labelStrings.text = "String Number: \(String(Int(sender.value)))"
        settings.set(Int(sender.value), forKey: "stringNumber")
    }
    
    

    

 
    
    
    
}






