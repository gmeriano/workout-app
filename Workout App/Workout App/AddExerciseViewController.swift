//
//  AddExerciseViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 6/15/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddExerciseViewController: UIViewController {

    var ref:DatabaseReference?
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var imageField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var videoField: UITextField!
    
    @IBOutlet weak var equipmentField: UITextField!
    
    @IBOutlet weak var muscleGroupField: UITextField!
    
    @IBOutlet weak var alternativeExercisesField: UITextField!
    
    @IBOutlet weak var intensityField: UITextField!
    
    // current id of user
    var userId:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // get reference to database
        ref = Database.database().reference()
        
    }
    
    // submit button that sends data to firebase and goes back to exercise screen
    @IBAction func goBack(_ sender: Any) {
        
        // generate id for this exercise
        let id = ref?.childByAutoId()
        
        // build NSDictionary of data to send to firebase
        let dict: NSDictionary = [
            "Name": nameField.text!,
            "ImageURL": imageField.text!,
            "Description": descriptionField.text!,
            "VideoURL": videoField.text!,
            "Equipment": equipmentField.text!,
            "MuscleGroups": muscleGroupField.text!,
            "AlternativeExercises": alternativeExercisesField.text!,
            "Intensity": intensityField.text!
        ]
        
        // send data to firebase at correct location so it only adds exercise to current user
        self.ref!.child(userId).child("Exercises").child(id!.key!).setValue(dict)
        
        // go back to previous screen
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}
