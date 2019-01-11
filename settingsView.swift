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




//this is a view class That I have linked to The story board View controller, The way I linked it is by going to the strory board, clicked on the top part of the sudo phone screen, which is the view controller, and then went to the top right hand side of Xcode and clicked on the "identity inspector" (hover the mouse for it to show names) there should be a section called "Class"
class settingsView: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }
    
    //labels for the displaying of User interface elements: the slider and the "stepper" are the current ones, This code creates objects that are linked to the StoryBoard. The StoryBoard is the graphical programing file where you drag and drop stuff in
    @IBOutlet weak var fretScaleLabel: UILabel!
    @IBOutlet weak var labelStrings: UILabel!
    
    //index 0 == gain; index 1 == distortion; 2 == delayTime; 3 == delayFeedBack
    @IBOutlet var sliderOutletCollection: [UISlider]!
    @IBOutlet var LabelCollection: [UILabel]!
    
    //same as the ones above except these represent the slider and the stepper themselves, NOT the Labels that displayes text to the user
    @IBOutlet weak var stringStepper: UIStepper!
    @IBOutlet weak var fretSlider: UISlider!
    
    @IBOutlet weak var presetUI: UISegmentedControl!
    
    //This Variable contais the slider value
    var sliderNumber: Float = 1.0
    var preset = 0
    //This is our reference to the "settings" or What the app will store indefinitly and reads from each time it is called, these are global. settings is a dictionary, key is a string
    let settings = UserDefaults.standard
    
    // viewDidLoad is just how it sounds, most things in swift try to be this way, This is a function that is called when the view is loaded, The view in this instance is settingsView
    override func viewDidLoad() {
        //setup for settings and visuals acording to past settings
        
        preset = settings.integer(forKey: "preset")
        
        
        if preset == 0{
        sliderOutletCollection[0].value = Float(settings.integer(forKey: "gain"))
        sliderOutletCollection[1].value = Float(settings.integer(forKey: "distortion"))
        LabelCollection[0].text = "Gain: \(settings.integer(forKey: "gain"))"
        LabelCollection[1].text = "Distortion: \(settings.integer(forKey: "distortion"))"
        sliderOutletCollection[2].value = Float(settings.double(forKey: "delayTime"))
        LabelCollection[2].text = "Time: \(Double(Int(settings.double(forKey: "delayTime") * 10)) / 10)"
        sliderOutletCollection[3].value = Float(settings.double(forKey: "delayFeedback"))
        LabelCollection[3].text = "Feedback: \(Int(settings.double(forKey: "delayFeedback") * 100))%"
        
        
        //When the view is loaded, we want the slider to display what the User has their settings at, this does that
        fretSlider.value = settings.float(forKey: "fretScale")
        
        //same this as above
        stringStepper.value = Double(settings.integer(forKey: "stringNumber"))
        
        //This sets the value for the Label of the slider
        fretScaleLabel.text = "Fret Count: \(Int(5 / settings.float(forKey: "fretScale") - 0.5))"
        
        //IDK why I have this as it is identical to one of the ones above, but ill leave it here for u
        fretSlider.value = settings.float(forKey: "fretScale")
        
        //This is same as the one above the one above
        labelStrings.text = "String Number: \(settings.integer(forKey: "stringNumber"))"

        //Also in swift when making strings \() will encapsulate whatever is in the parenthiseees into the string "hello people i have \(someVariableForNumberOfFruit) fruit(s)"
        }
        else {
            
            presetUI.selectedSegmentIndex = 1
            sliderOutletCollection[0].value = Float(settings.integer(forKey: "gain2"))
            sliderOutletCollection[1].value = Float(settings.integer(forKey: "distortion2"))
            LabelCollection[0].text = "Gain: \(settings.integer(forKey: "gain2"))"
            LabelCollection[1].text = "Distortion: \(settings.integer(forKey: "distortion2"))"
            sliderOutletCollection[2].value = Float(settings.double(forKey: "delayTime2"))
            LabelCollection[2].text = "Time: \(Double(Int(settings.double(forKey: "delayTime") * 10)) / 10)"
            sliderOutletCollection[3].value = Float(settings.double(forKey: "delayFeedback2"))
            LabelCollection[3].text = "Feedback: \(Int(settings.double(forKey: "delayFeedback2") * 100))%"
            
            
            //When the view is loaded, we want the slider to display what the User has their settings at, this does that
            fretSlider.value = settings.float(forKey: "fretScale2")
            
            //same this as above
            stringStepper.value = Double(settings.integer(forKey: "stringNumber2"))
            
            //This sets the value for the Label of the slider
            fretScaleLabel.text = "Fret Count: \(Int(5 / settings.float(forKey: "fretScale2") - 0.5))"
            
            //IDK why I have this as it is identical to one of the ones above, but ill leave it here for u
            fretSlider.value = settings.float(forKey: "fretScale2")
            
            //This is same as the one above the one above
            labelStrings.text = "String Number: \(settings.integer(forKey: "stringNumber2"))"
            
            
        }
    }
    
    //This is a function that is linked to the storyBoard Slider and is called whenever the slider is moved, I use it to update the label text to whatever the slider moved to AND the global settings
    @IBAction func sliderMoved(_ sender: UISlider) {
    
        if preset == 0 {
        
        settings.set(Float(sender.value), forKey: "fretScale")
         fretScaleLabel.text = "Fret Count: \(Int(5 / sender.value - 0.5))"
  
        
    settings.set(Int(5 / settings.float(forKey: "fretScale") - 0.5), forKey: "fretCount")
    print(Int(5 / sender.value + 0.5) - 1)
        }
        else {
            settings.set(Float(sender.value), forKey: "fretScale2")
            fretScaleLabel.text = "Fret Count: \(Int(5 / sender.value - 0.5))"
            
            
            settings.set(Int(5 / settings.float(forKey: "fretScale2") - 0.5), forKey: "fretCount2")
            print(Int(5 / sender.value + 0.5) - 1)
        }
    }
    
    
    //same thingy
    @IBAction func stringStepperMoved(_ sender: UIStepper) {
        
        if preset == 0 {
        labelStrings.text = "String Number: \(String(Int(sender.value)))"
        settings.set(Int(sender.value), forKey: "stringNumber")
        }
        else {
            labelStrings.text = "String Number: \(String(Int(sender.value)))"
            settings.set(Int(sender.value), forKey: "stringNumber2")
        }
        
    }
    
    @IBAction func sliderCollection(_ sender: UISlider) {
    
        for (index, slider) in sliderOutletCollection.enumerated() {
            
            
            if preset == 0 {
print("slider moved preset 1")
            if slider == sender {
                if index == 0 {
                LabelCollection[index].text = "Gain: \(Int(sender.value))"
                settings.set(Int(sender.value), forKey: "gain")
                }
                else if index == 1 {
                    LabelCollection[index].text = "Distortion: \(Int(sender.value))"
                    settings.set(Int(sender.value), forKey: "distortion")
                }
                else if index == 2 {
                    LabelCollection[index].text = "Time: \(Double(Int(sender.value * 10)) / 10)"
                    settings.set(sender.value, forKey: "delayTime")
                    
                }
                else if index == 3 {
                    LabelCollection[index].text = "FeedBack: \(Int(sender.value * 100))%"
                settings.set(sender.value, forKey: "delayFeedback")
                }
            }
            
        }
            else {
                print("slidermovedpreset2")
                if slider == sender {
                    if index == 0 {
                        LabelCollection[index].text = "Gain: \(Int(sender.value))"
                        settings.set(Int(sender.value), forKey: "gain2")
                    }
                    else if index == 1 {
                        LabelCollection[index].text = "Distortion: \(Int(sender.value))"
                        settings.set(Int(sender.value), forKey: "distortion2")
                    }
                    else if index == 2 {
                        LabelCollection[index].text = "Time: \(Double(Int(sender.value * 10)) / 10)"
                        settings.set(sender.value, forKey: "delayTime2")
                        
                    }
                    else if index == 3 {
                        LabelCollection[index].text = "FeedBack: \(Int(sender.value * 100))%"
                        settings.set(sender.value, forKey: "delayFeedback2")
                    }
                }
                
                
                
            }
        
        }
    
    }
    

    

 
    @IBAction func presetSwitch(_ sender: UISegmentedControl) {
    
    print(sender.selectedSegmentIndex)
        
        settings.set(sender.selectedSegmentIndex, forKey: "preset")
        preset = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 0 {
            
            
        sliderOutletCollection[0].value = Float(settings.integer(forKey: "gain"))
        sliderOutletCollection[1].value = Float(settings.integer(forKey: "distortion"))
        LabelCollection[0].text = "Gain: \(settings.integer(forKey: "gain"))"
        LabelCollection[1].text = "Distortion: \(settings.integer(forKey: "distortion"))"
        sliderOutletCollection[2].value = Float(settings.double(forKey: "delayTime"))
        LabelCollection[2].text = "Time: \(Double(Int(settings.double(forKey: "delayTime") * 10)) / 10)"
        sliderOutletCollection[3].value = Float(settings.double(forKey: "delayFeedback"))
        LabelCollection[3].text = "Feedback: \(Int(settings.double(forKey: "delayFeedback") * 100))%"
        
        
        //When the view is loaded, we want the slider to display what the User has their settings at, this does that
        fretSlider.value = settings.float(forKey: "fretScale")
        
        //same this as above
        stringStepper.value = Double(settings.integer(forKey: "stringNumber"))
        
        //This sets the value for the Label of the slider
        fretScaleLabel.text = "Fret Count: \(Int(5 / settings.float(forKey: "fretScale") - 0.5))"
        
        //IDK why I have this as it is identical to one of the ones above, but ill leave it here for u
        fretSlider.value = settings.float(forKey: "fretScale")
        
        //This is same as the one above the one above
        labelStrings.text = "String Number: \(settings.integer(forKey: "stringNumber"))"
        }
        else {
            

            
            sliderOutletCollection[0].value = Float(settings.integer(forKey: "gain2"))
            sliderOutletCollection[1].value = Float(settings.integer(forKey: "distortion2"))
            LabelCollection[0].text = "Gain: \(settings.integer(forKey: "gain2"))"
            LabelCollection[1].text = "Distortion: \(settings.integer(forKey: "distortion2"))"
            sliderOutletCollection[2].value = Float(settings.double(forKey: "delayTime2"))
            LabelCollection[2].text = "Time: \(Double(Int(settings.double(forKey: "delayTime") * 10)) / 10)"
            sliderOutletCollection[3].value = Float(settings.double(forKey: "delayFeedback2"))
            LabelCollection[3].text = "Feedback: \(Int(settings.double(forKey: "delayFeedback2") * 100))%"
            
            
            //When the view is loaded, we want the slider to display what the User has their settings at, this does that
            fretSlider.value = settings.float(forKey: "fretScale2")
            
            //same this as above
            stringStepper.value = Double(settings.integer(forKey: "stringNumber2"))
            
            //This sets the value for the Label of the slider
            fretScaleLabel.text = "Fret Count: \(Int(5 / settings.float(forKey: "fretScale2") - 0.5))"
            
            //IDK why I have this as it is identical to one of the ones above, but ill leave it here for u
            fretSlider.value = settings.float(forKey: "fretScale2")
            
            //This is same as the one above the one above
            labelStrings.text = "String Number: \(settings.integer(forKey: "stringNumber2"))"
            
            
        }
        
    
    }
}




class tuningView: UIViewController {
    var preset = 0
    let settings = UserDefaults.standard
    let tuningKey = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

    @IBOutlet var tuningSteppers: [UIStepper]!
    
    @IBOutlet var tuningLabels: [UILabel]!
    
    override func viewDidLoad() {
        
        
        preset = settings.integer(forKey: "preset")
        print(preset)

        var array = [Any]()
        if preset == 0 {
            array = settings.array(forKey: "stringTuning")!
        }
        else {
            
            array = settings.array(forKey: "stringTuning2")!

        }
print(array)
        
        for (index, label) in tuningLabels.enumerated() {
            
            tuningSteppers[index].value = Double(Int(array[index] as! Int))
            
            if Float(index) / 2 == Float(Int(Float(index) / 2)) {
               
               
                
                    
                label.text = "Note: \(tuningKey[Int(array[index] as! Int)])"

            }
            else {
                tuningLabels[index].text = "Octave: \(Int(array[index] as! Int) + 1)"

            }
            
        }
  
    }
    
    @IBAction func stepperHasBeenStepped(_ sender: UIStepper) {
        var array = [Any]()
        if preset == 0 {
            array = settings.array(forKey: "stringTuning")!
        }
        else {
            
            array = settings.array(forKey: "stringTuning2")!
            
        }
        for (index, stepper) in tuningSteppers.enumerated() {
            
            if sender == stepper {
                
                array[index] = Int(sender.value)
                
                if preset == 0 {
                settings.set(array, forKey: "stringTuning")
                }
                else {
                    settings.set(array, forKey: "stringTuning2")
                }
                
                if Float(index) / 2 == Float(Int(Float(index) / 2)) {
                    
                tuningLabels[index].text = "Note: \(tuningKey[Int(array[index] as! Int)])"
                    
                }
                else {
                    tuningLabels[index].text = "Octave: \(Int(array[index] as! Int) + 1)"

                    
                }
            }

        }
print(array)
    }
   
}

class customStackView: UIStackView {
    
    
    
}
