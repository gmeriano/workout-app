//
//  AddExerciseToWorkoutViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 7/5/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit
import iOSDropDown

class AddExerciseToWorkoutViewController: UIViewController {

    
    @IBOutlet weak var dropDownMenu: DropDown!
    
    @IBOutlet weak var repsOrTimeIndicator: UISegmentedControl!
    
    @IBOutlet weak var repsOrTimeField: UITextField!
    
    @IBOutlet weak var setsField: UITextField!
    
    @IBOutlet weak var weightsField: UITextField!
    
    @IBOutlet weak var restField: UITextField!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    var exerciseArray = [Exercise]()
    var selectedExercise:Exercise? = nil
    var workoutExercise:ExercisePlus? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup text fields
        dropDownMenu.placeholder = "Exercise"
        repsOrTimeField.placeholder = repsOrTimeIndicator.titleForSegment(at: repsOrTimeIndicator.selectedSegmentIndex)
        setsField.placeholder = "Sets"
        weightsField.placeholder = "Weights"
        restField.placeholder = "Rest"
        
        // put exercises into dropdown menu
        let tabView = presentingViewController?.presentingViewController as! UITabBarController
        let secondView = tabView.customizableViewControllers![0] as! SecondViewController
        exerciseArray = secondView.exerciseArray
        
        var exerciseNameArray = [String]()
        for exercise in exerciseArray {
            exerciseNameArray.append(exercise.name!)
        }
        
        dropDownMenu.isSearchEnable = true
        dropDownMenu.optionArray = exerciseNameArray
        dropDownMenu.didSelect{(selectedText, index, id) in
            print(self.dropDownMenu.selectedIndex)
            self.selectedExercise = self.exerciseArray[self.dropDownMenu.selectedIndex!]
        }
        
    }

    @IBAction func repOrTimeChanged(_ sender: Any) {
        repsOrTimeField.placeholder = repsOrTimeIndicator.titleForSegment(at: repsOrTimeIndicator.selectedSegmentIndex)
    }
    
    
    @IBAction func addExerciseToWorkout(_ sender: Any) {
        
        var repTime:Int?
        if (repsOrTimeIndicator.titleForSegment(at: repsOrTimeIndicator.selectedSegmentIndex) == "Reps") {
            repTime = 0
        }
        else {
            repTime = 1
        }
        
        let exerciseToSend = ExercisePlus(name: dropDownMenu.text, exercise: selectedExercise, repTimeIndicator: repTime, repOrTime: repsOrTimeField.text, sets: setsField.text, weights: weightsField.text, rest: restField.text)
        
        let createWorkoutView = presentingViewController as! createWorkoutViewController
        createWorkoutView.exercisePlusArray.append(exerciseToSend)
        createWorkoutView.tableView.reloadData()
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
