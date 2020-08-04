//
//  ExercisePlusViewController.swift
//  Workout App
//
//  Created by Dan Mullasseril on 7/29/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit

class ExercisePlusViewController: UIViewController {
    
    var exPlus:ExercisePlus?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var repsOrTimeLabel: UILabel!
    
    @IBOutlet weak var setsLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
   
    @IBOutlet weak var restLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = exPlus!.name
        
        if exPlus!.repTimeIndicator == 0 {
            repsOrTimeLabel.text = exPlus!.repOrTime
        } else {
            repsOrTimeLabel.text = exPlus!.repOrTime! + " seconds"
        }
        
        
        setsLabel.text = exPlus!.sets
        weightLabel.text = exPlus!.weights
        restLabel.text = exPlus!.rest
    
        
    }
    
    
    @IBAction func editExercise(_ sender: Any) {
        self.performSegue(withIdentifier: "editExercise", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.destination is AddExerciseToWorkoutViewController {
             
            let tabView = presentingViewController as! UITabBarController
            let secondView = tabView.customizableViewControllers![0] as! ExercisePlusViewController
            let vc = segue.destination as? AddExerciseToWorkoutViewController
            // name, reps or time, sets, weight, rest
            vc?.dropDow
                      
            
        }
    }
    

    
}

