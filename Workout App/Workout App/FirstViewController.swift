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
    var exercises:[Exercise]
    var repTimeIndicator:[Int]
    var repOrTime:[Int]
    var sets:[Int]
    var weights:[Int]?
    var rest:[Int]?
}

struct ExercisePlus {
    var name:String?
    var exercise:Exercise?
    var repTimeIndicator:Int?
    var repOrTime:String?
    var sets:String?
    var weights:String?
    var rest:String?
}

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // workout array
    
var workoutArray = [Workout]()
var exerciseArray = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // hide extra cells
        tableView.tableFooterView = UIView()
        
        let sampleExerciseA = Exercise(name: "a", image: "a", description: "a", video: "a", equipment: "a", muscleGroups: "a", alternativeExercises: "a", intensity: "a", key: "a")
        let sampleExerciseB = Exercise(name: "b", image: "b", description: "b", video: "b", equipment: "b", muscleGroups: "b", alternativeExercises: "b", intensity: "b", key: "b")
        exerciseArray.append(sampleExerciseA)
        exerciseArray.append(sampleExerciseB)
        
        // workout array needs at least 1 workout
        let sampleWorkout = Workout(name: "wout", exercises: exerciseArray, repTimeIndicator: [8,12], repOrTime: [0,0], sets: [3,3], weights: [10,15], rest: [30,30])
        workoutArray.append(sampleWorkout)
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

}

