//
//  AddExerciseViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 6/15/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        
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
