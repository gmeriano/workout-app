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


class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var databaseUpdateHandle:DatabaseHandle?
    
    // array holding all exercises for current user
    var exerciseArray = [Exercise]()
    var buttonArray = [UIButton]()
    var searchExercise = [Exercise]()
    
    // is the user searching
    var searching = false
    
    // information for exercise display
    var exInfo = ""
    
    // index of clicked exercise
    var exIdx = 0
    
    // id of current user
    var userId:String = ""
    
    // name of exercise to be removed from the array
    var remExercise = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        // setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // hide extra cells
        tableView.tableFooterView = UIView()

        
        
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
                //self.buttonArray[idx].setTitle(name, for: .normal)
            self.tableView.reloadData()
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
            self.tableView.reloadData()
        })
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
           return searchExercise.count
        } else {
            return exerciseArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")
        if searching {
            cell?.textLabel?.text = searchExercise[indexPath.row].name
        } else {
            cell?.textLabel?.text = exerciseArray[indexPath.row].name
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        performSegue(withIdentifier: "GoToExercise", sender: self)
    }
    
    // slide to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        self.exerciseArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
     }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchExercise = exerciseArray.filter({$0.name?.prefix(searchText.count) == searchText})
        searchExercise = exerciseArray.filter({($0.name?.contains(searchText.lowercased()))!})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    // goes to AddExerciseViewController to add an exercise to this view
    @IBAction func addExercise(_ sender: Any) {        
        self.performSegue(withIdentifier: "AddExerciseSegue", sender: self)
    }
    
   
    // Sends the userId to AddExerciseViewController whenever the user wants to add a new exercise
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is AddExerciseViewController {
            
            let vc = segue.destination as? AddExerciseViewController
            vc?.userId = self.userId
        }
        
        if segue.destination is ExerciseViewController {
            
            let vc = segue.destination as? ExerciseViewController
//            vc?.exercise = self.exerciseArray[exIdx]
            vc?.exercise = exerciseArray[tableView.indexPathForSelectedRow!.row]
        }
        
        
        
    }
}

