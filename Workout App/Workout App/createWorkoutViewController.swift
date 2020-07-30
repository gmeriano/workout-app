//
//  createWorkoutViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 7/5/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class createWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:DatabaseReference?
    
    // current id of user
    var userId:String = ""


    @IBOutlet weak var tableView: UITableView!
    
    var exercisePlusArray = [ExercisePlus]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisePlusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")
        cell?.textLabel?.text = exercisePlusArray[indexPath.row].name
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get reference to database
        ref = Database.database().reference()
        
        print(userId)
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // hide extra cells
        tableView.tableFooterView = UIView()
    }
    

    @IBAction func submitWorkout(_ sender: Any) {
        
        let workoutDict: NSMutableDictionary = [:]
        let workoutId = ref?.childByAutoId()

        for exercise in exercisePlusArray {
            
            let id = ref?.childByAutoId()
            print(exercise.name!)
            let dict: NSDictionary = [
                "Exercise": exercise.key!,
                "Name": exercise.name!,
                "RepOrTimeInd": exercise.repTimeIndicator!,
                "RepTime": exercise.repOrTime!,
                "Sets": exercise.sets!,
                "Rest": exercise.rest!,
                "Weights": exercise.weights!
            ]
            print("trying")
            workoutDict[id!.key!] = dict
            print("success")
            
        }
        self.ref!.child(userId).child("Workouts").child(workoutId!.key!).setValue(workoutDict)
        
    }
    
}
