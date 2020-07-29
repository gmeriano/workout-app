//
//  createWorkoutViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 7/5/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit

class createWorkoutViewController: UIViewController {

    var exercises = [ExercisePlus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    


    @IBAction func test(_ sender: Any) {
        
        for exercise in exercises {
            print(exercise.name)
        }
        
    }
    
}
