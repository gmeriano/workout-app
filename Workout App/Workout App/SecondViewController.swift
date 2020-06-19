//
//  SecondViewController.swift
//  Workout App
//
//  Created by Dan Mullasseril on 6/2/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit
import Firebase

struct Exercise {
    var name :String?
    var image :String? //UImage
    var description :String?
    var video :String? //URL
    var equipment :String? // array of strings
    var muscleGroups :String? // array of strings
    var alternativeExercises :String? // array of strings
    var intensity :String? // int
    var key :String? // key of exercise in database
}


class SecondViewController: UIViewController {

    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var databaseUpdateHandle:DatabaseHandle?
    
    // array holding all exercises for current user
    var exerciseArray = [Exercise]()
    var buttonArray = [UIButton]()
    
    // information for exercise display
    var exInfo = ""
    
    // index of clicked exercise
    var exIdx = 0
    
    // id of current user
    var userId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        // setup scrollview with embedded stackview for displaying exercises
        self.scrollView.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        // set firebase reference
        ref = Database.database().reference()
        
        // exercise array needs at least 1 exercise at load
        let sampleExercise = Exercise(name: "pushup", image: "none", description: "push yourself up", video: "none", equipment: "body", muscleGroups: "chest", alternativeExercises: "bench press", intensity: "2", key: "none")
        exerciseArray.append(sampleExercise)
        
        // retrieves posts and listens for updated exercises for given user
        databaseUpdateHandle = ref?.child(self.userId).child("Exercises").observe(.childChanged, with: { (DataSnapshot) in
        
                // gets new data as NSDictionary
                let exer = DataSnapshot.value as! NSDictionary
                print("EDITING")
                // stores values of relevant data as array
                let vals = exer.allValues
                
                // there might be a better way to do this
                // gets the values for each cooresponding key saved to variable
                let muscleGroups:String = vals[0] as! String
                let equipment:String = vals[1] as! String
                let image:String = vals[2] as! String
                let altExer:String = vals[3] as! String
                let video:String = vals[4] as! String
                let name:String = vals[5] as! String
                print(name)
                let desc:String = vals[6] as! String
                let intensity:String = vals[7] as! String
                let exKey:String = DataSnapshot.key
            
                // build exercise struct
                let actualExercise = Exercise(name: name, image: image, description: desc, video: video, equipment: equipment, muscleGroups: muscleGroups, alternativeExercises: altExer, intensity: intensity, key: exKey)
                
                // add Exercise to array
                var idx = 0
                for index in 0...self.exerciseArray.count-1 {
                    let currentKey = self.exerciseArray[index].key
                    if currentKey == exKey {
                        idx = index
                        break
                    }
                }
                self.exerciseArray.remove(at: idx)
                self.exerciseArray.insert(actualExercise, at: idx)
                self.buttonArray[idx].setTitle(name, for: .normal)
        })
        
        // retrieve posts and listen for added exercises in database for given user
        databaseHandle = ref?.child(self.userId).child("Exercises").observe(.childAdded, with: { (DataSnapshot) in
            
            // gets new data as NSDictionary
            let exer = DataSnapshot.value as! NSDictionary
            
            // stores values of relevant data as array
            let vals = exer.allValues
            
            // there might be a better way to do this
            // gets the values for each cooresponding key saved to variable
            let muscleGroups:String = vals[0] as! String
            let equipment:String = vals[1] as! String
            let image:String = vals[2] as! String
            let altExer:String = vals[3] as! String
            let video:String = vals[4] as! String
            let name:String = vals[5] as! String
            let desc:String = vals[6] as! String
            let intensity:String = vals[7] as! String
            let exKey:String = DataSnapshot.key
        
            // build exercise struct
            let actualExercise = Exercise(name: name, image: image, description: desc, video: video, equipment: equipment, muscleGroups: muscleGroups, alternativeExercises: altExer, intensity: intensity, key: exKey)
            
            // add Exercise to array
            self.exerciseArray.append(actualExercise)
            
            // display the new exercise in view
            let button = UIButton()
            button.setTitle(name, for: .normal)
            button.backgroundColor = UIColor.blue
            button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
            self.stackView.addArrangedSubview(button)
            self.buttonArray.append(button)
            self.stackView.reloadInputViews()
        })
        
        // display exercises in database previously made by user
        for index in 0...exerciseArray.count-1 {
            let button = UIButton()
            button.setTitle(exerciseArray[index].name, for: .normal)
            button.backgroundColor = UIColor.blue
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.stackView.addArrangedSubview(button)
            buttonArray.append(button)
        }
        
        
    }
    
    // goes to AddExerciseViewController to add an exercise to this view
    @IBAction func addExercise(_ sender: Any) {        
        self.performSegue(withIdentifier: "AddExerciseSegue", sender: self)
    }
    
    // Action called when an exercise is pressed
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        let name = btnsendtag.titleLabel?.text
        var idx = 0
        for ex in exerciseArray {
            if ex.name == name {
                exInfo = ex.description!
                exIdx = idx
                self.performSegue(withIdentifier: "GoToExercise", sender: self)
            }
            idx += 1
        }
    }
   
    // Sends the userId to AddExerciseViewController whenever the user wants to add a new exercise
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is AddExerciseViewController {
            
            let vc = segue.destination as? AddExerciseViewController
            vc?.userId = self.userId
        }
        
        if segue.destination is ExerciseViewController {
            
            let vc = segue.destination as? ExerciseViewController
            vc?.exercise = self.exerciseArray[exIdx]
        }
        
        
        
    }
}

