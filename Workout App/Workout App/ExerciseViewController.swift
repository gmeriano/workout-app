//
//  ExerciseViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 6/15/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var exercise:Exercise?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var videoLabel: UILabel!
    
    @IBOutlet weak var equipmentLabel: UILabel!
    
    @IBOutlet weak var muscleGroupLabel: UILabel!
    
    @IBOutlet weak var altExerciseLabel: UILabel!
    
    @IBOutlet weak var intensityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = exercise!.name
        imageLabel.text = exercise!.image
        descriptionLabel.text = exercise!.description
        videoLabel.text = exercise!.video
        equipmentLabel.text = exercise!.equipment
        muscleGroupLabel.text = exercise!.muscleGroups
        altExerciseLabel.text = exercise!.alternativeExercises
        intensityLabel.text = exercise!.intensity

        // Do any additional setup after loading the view.
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }

    // goes to add exercise view controller following prepare function
    @IBAction func editExercise(_ sender: Any) {
        self.performSegue(withIdentifier: "EditExercise", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.destination is AddExerciseViewController {
            
            let tabView = presentingViewController as! UITabBarController
            let secondView = tabView.customizableViewControllers![0] as! SecondViewController
            
            let vc = segue.destination as? AddExerciseViewController
            
            // get user id from secondViewController
            vc?.userId = secondView.userId
            
            // let AddExerciseViewController know that it is editing rather than adding an exercise
            vc?.editExercise = true
            
            // pass previous exercise data into AddExerciseViewController so that you don't have to
            // retype old data that you don't want to change
            vc?.exerciseId = exercise!.key
            vc?.nameEdit = exercise!.name ?? ""
            vc?.imageEdit = exercise!.image ?? ""
            vc?.descEdit = exercise!.description ?? ""
            vc?.videoEdit = exercise!.video ?? ""
            vc?.equipEdit = exercise!.equipment ?? ""
            vc?.muscleEdit = exercise!.muscleGroups ?? ""
            vc?.altExEdit = exercise!.alternativeExercises ?? ""
            vc?.intensityEdit = exercise!.intensity ?? ""
            
        }
    }
    
}
