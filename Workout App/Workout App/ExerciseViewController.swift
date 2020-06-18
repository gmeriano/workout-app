//
//  ExerciseViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 6/15/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak var info: UILabel!
    
    var information = ""
    var exercise:Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        info.text = exercise!.description

        // Do any additional setup after loading the view.
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
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
