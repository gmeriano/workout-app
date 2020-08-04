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
    
  
    @IBAction func deleteExercise(_ sender: Any) {
        let vc = presentingViewController as! createWorkoutViewController
        for i in 0...vc.exercisePlusArray.count {
            print(i)
            print(vc.exercisePlusArray)
            let ex = vc.exercisePlusArray[i]
            if ex.name == exPlus?.name {
                vc.exercisePlusArray.remove(at: i)
                break
            }
            
        }
        vc.tableView.reloadData()
        vc.dismiss(animated: true, completion: nil)
        
    }
    
    

    
}

