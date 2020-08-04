//
//  FirstViewController.swift
//  Workout App
//
//  Created by Dan Mullasseril on 6/2/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit
import Firebase

struct Workout {
    var name :String?
    var exercises:[ExercisePlus]
}

struct ExercisePlus {
    var name:String?
    var exercise:Exercise?
    var repTimeIndicator:Int?
    var repOrTime:String?
    var sets:String?
    var weights:String?
    var rest:String?
    var key:String?
}

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var databaseUpdateHandle:DatabaseHandle?
    
    // workout array
    
    var workoutArray = [Workout]()
    var exercise2Array = [Exercise]()
    
    var exerciseArray = [Exercise]()
    
    var userId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let secondVC = self.tabBarController?.customizableViewControllers?[0] as! SecondViewController
        exerciseArray = secondVC.exerciseArray
        
        // setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // hide extra cells
        tableView.tableFooterView = UIView()
        
        let sampleExerciseA = Exercise(name: "a", image: "a", description: "a", video: "a", equipment: "a", muscleGroups: "a", alternativeExercises: "a", intensity: "a", key: "a")
        let sampleExerciseB = Exercise(name: "b", image: "b", description: "b", video: "b", equipment: "b", muscleGroups: "b", alternativeExercises: "b", intensity: "b", key: "b")
        exercise2Array.append(sampleExerciseA)
        exercise2Array.append(sampleExerciseB)
        let exPlusA = ExercisePlus(name: "a", exercise: sampleExerciseA, repTimeIndicator: 0, repOrTime: "a", sets: "a", weights: "a", rest: "a", key: "a")
        let exPlusB = ExercisePlus(name: "b", exercise: sampleExerciseB, repTimeIndicator: 0, repOrTime: "b", sets: "b", weights: "b", rest: "b", key: "b")
        // workout array needs at least 1 workout
        let sampleWorkout = Workout(name: "wout", exercises: [exPlusA, exPlusB])
        workoutArray.append(sampleWorkout)
        
        // set firebase reference
        ref = Database.database().reference()
        
        // retrieve posts and listen for added exercises in database for given user
        databaseHandle = ref?.child(self.userId).child("Workouts").observe(.childAdded, with: { (DataSnapshot) in
            
            // gets new data as NSDictionary
            let name = DataSnapshot.key
            let workout = DataSnapshot.value as! NSDictionary
            print("hiya")
            print(workout)
            print(workout.allKeys)
            print(workout.allValues)
            
            var exercisesInWorkout:[ExercisePlus] = []

            for exPlus in workout.allValues {
                let exercise = exPlus as! NSDictionary
                let vals = exercise.allValues
                var currentExercise:Exercise?
                for ex in self.exerciseArray {
                    if ex.key == (vals[0] as! String) {
                        currentExercise = ex
                    }
                }
                let currExer = ExercisePlus(name: vals[1] as? String, exercise: currentExercise, repTimeIndicator: vals[2] as? Int, repOrTime: vals[3] as? String, sets: vals[5] as? String, weights: vals[6] as? String, rest: vals[4] as? String, key: vals[0] as? String)
                exercisesInWorkout.append(currExer)
                
            }
            
            // stores values of relevant data as array
            //let vals = workout.allValues
            //print(vals)
            self.workoutArray.append(Workout(name: name, exercises: exercisesInWorkout))
           
            
            // display the new exercise in view
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")
        cell?.textLabel?.text = workoutArray[indexPath.row].name
        
        return cell!
    }

    // go to workout need to figure out
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedIndex = indexPath.row
//        performSegue(withIdentifier: "GoToWorkout", sender: self)
//    }
    

    // slide to delete workout
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        self.workoutArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
     }
    }

    @IBAction func addWorkout(_ sender: Any) {
        print(presentingViewController)
        self.performSegue(withIdentifier: "AddWorkoutSegue", sender: self)
    }
    
    // Sends the userId to AddExerciseViewController whenever the user wants to add a new exercise
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is createWorkoutViewController {
            
            let vc = segue.destination as? createWorkoutViewController
            vc?.userId = self.userId
        }
    }
}

