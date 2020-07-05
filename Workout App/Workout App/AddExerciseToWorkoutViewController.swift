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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownMenu.isSearchEnable = true
        dropDownMenu.optionArray = ["Option1", "Option2", "Option3", "poo", "hehe"]
        dropDownMenu.didSelect{(selectedText, index, id) in
            self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
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
