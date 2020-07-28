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

    @IBOutlet weak var valueLabel: UILabel!
    
    var exerciseArray = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
