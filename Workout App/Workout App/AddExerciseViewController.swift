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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
    }
    
    // submit button that sends data to firebase and goes back to exercise screen
    @IBAction func goBack(_ sender: Any) {
        
        // generate id for this exercise
        let id = ref?.childByAutoId()
        
        // send data to firebase
        self.ref!.child("Exercises").child(id!.key!).child("Name").setValue(nameField.text!)
        self.ref!.child("Exercises").child(id!.key!).child("ImageURL").setValue(imageField.text!)
        self.ref!.child("Exercises").child(id!.key!).child("Description").setValue(descriptionField.text!)
        self.ref!.child("Exercises").child(id!.key!).child("VideoURL").setValue(videoField.text!)
        self.ref!.child("Exercises").child(id!.key!).child("Equipment").setValue(equipmentField.text!)
        self.ref!.child("Exercises").child(id!.key!).child("MuscleGroups").setValue(muscleGroupField.text!)
        self.ref!.child("Exercises").child(id!.key!).child("AlternativeExercises").setValue(alternativeExercisesField.text!)
        self.ref!.child("Exercises").child(id!.key!).child("Intensity").setValue(intensityField.text!)
        
        // go back to previous screen
        presentingViewController?.dismiss(animated: true, completion: nil)
        
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
