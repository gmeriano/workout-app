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

    @IBOutlet weak var scrollView: UIScrollView!
    
    var exerciseArray = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let exercise1 = Exercise(name: "pushup", image: nil, description: "push up", video: nil, equipment: nil, muscleGroups: nil, alternativeExercises: nil, intensity: 2)
        
        let exercise2 = Exercise(name: "situp", image: nil, description: "sit up", video: nil, equipment: nil, muscleGroups: nil, alternativeExercises: nil, intensity: 1)
        
        exerciseArray.append(exercise1)
        exerciseArray.append(exercise2)
        
        for index in 0...exerciseArray.count-1 {
            print("hi")
            let button = UIButton.init(frame: CGRect.zero)
            button.setTitle(exerciseArray[index].name, for: .normal)
            scrollView.addSubview(button)
        }
        scrollView.contentSize.height = CGFloat(45*2)
        
        
        
    }
    
}

