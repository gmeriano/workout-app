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
    let nameEdit:String = ""
    
    @IBOutlet weak var imageField: UITextField!
    let imageEdit:String = ""
    
    @IBOutlet weak var descriptionField: UITextField!
    let descEdit:String = ""
    
    @IBOutlet weak var videoField: UITextField!
    let videoEdit:String = ""
    
    @IBOutlet weak var equipmentField: UITextField!
    let equipEdit:String = ""
    
    @IBOutlet weak var muscleGroupField: UITextField!
    let muscleEdit:String = ""
    
    @IBOutlet weak var alternativeExercisesField: UITextField!
    let altExEdit:String = ""
    
    @IBOutlet weak var intensityField: UITextField!
    let intensityEdit:String = ""
    
    // current id of user
    var userId:String = ""
    
    // false if a new exercise is being added, true if an exercise is being edited
    var editExercise:Bool = false
    
    // id of exercise if it is being edited
    var exerciseId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // get reference to database
        ref = Database.database().reference()
        
        // if editing an exercise
        if editExercise {
            
            // set text boxes to have old information
            nameField.text = nameEdit
            imageField.text = imageEdit
            descriptionField.text = descEdit
            videoField.text = videoEdit
            equipmentField.text = equipEdit
            muscleGroupField.text = muscleEdit
            alternativeExercisesField.text = altExEdit
            intensityField.text = intensityEdit
            
        }
        
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
        
        // if you are editing, rather than adding an exercise
        if editExercise {
            self.ref!.child(userId).child("Exercises").child(exerciseId!).setValue(dict)
        }
        else {
            // send data to firebase at correct location so it only adds exercise to current user
            self.ref!.child(userId).child("Exercises").child(id!.key!).setValue(dict)
        }
            
        // go back to previous screen
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}
