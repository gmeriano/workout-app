//
//  SecondViewController.swift
//  Workout App
//
//  Created by Dan Mullasseril on 6/2/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit

struct Exercise {
    var name :String?
    var image :UIImage?
    var description :String?
    var video :URL?
    var equipment :[String]?
    var muscleGroups :[String]?
    var alternativeExercises :[String]?
    var intensity :Int?
}


class SecondViewController: UIViewController {

    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var exerciseArray = [Exercise]()
    
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
        
        
        let exercise1 = Exercise(name: "pushup", image: nil, description: "push up", video: nil, equipment: nil, muscleGroups: nil, alternativeExercises: nil, intensity: 2)
        
        let exercise2 = Exercise(name: "situp", image: nil, description: "sit up", video: nil, equipment: nil, muscleGroups: nil, alternativeExercises: nil, intensity: 1)
        
        exerciseArray.append(exercise1)
        exerciseArray.append(exercise2)
        
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

