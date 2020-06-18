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
}


class SecondViewController: UIViewController {

    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var exerciseArray = [Exercise]()
    
    var userId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.scrollView.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        
        let exercise1 = Exercise(name: "pushup", image: nil, description: "push up", video: nil, equipment: nil, muscleGroups: nil, alternativeExercises: nil, intensity: "2")
        
        let exercise2 = Exercise(name: "situp", image: nil, description: "sit up", video: nil, equipment: nil, muscleGroups: nil, alternativeExercises: nil, intensity: "1")
        
        exerciseArray.append(exercise1)
        exerciseArray.append(exercise2)
        
        // set firebase reference
        ref = Database.database().reference()
        
        // retrieve posts and listen for changes
        databaseHandle = ref?.child("Exercises").observe(.childAdded, with: { (DataSnapshot) in
            
            let exer = DataSnapshot.value as! NSDictionary
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
        
            let actualExercise = Exercise(name: name, image: image, description: desc, video: video, equipment: equipment, muscleGroups: muscleGroups, alternativeExercises: altExer, intensity: intensity)
            
            self.exerciseArray.append(actualExercise)
            print("Added exercise")
            print(actualExercise.name)
            
            let button = UIButton()
            button.setTitle(name, for: .normal)
            button.backgroundColor = UIColor.blue
            button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
            self.stackView.addArrangedSubview(button)
            
            self.stackView.reloadInputViews()
        })
        
        for index in 0...exerciseArray.count-1 {
            print("hi")
            let button = UIButton()
            button.setTitle(exerciseArray[index].name, for: .normal)
            button.backgroundColor = UIColor.blue
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.stackView.addArrangedSubview(button)
        }
        
        
    }
    
    @IBAction func addExercise(_ sender: Any) {
        print("plus button pressed")
        
        self.performSegue(withIdentifier: "AddExerciseSegue", sender: self)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        let name = btnsendtag.titleLabel?.text
        for ex in exerciseArray {
            if ex.name == name {
                print(ex.intensity)
            }
        }
    }
   
    
}

