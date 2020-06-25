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
    var exercises:[Exercise]
    var repTimeIndicator:[Int]
    var repOrTime:[Int]
    var sets:[Int]
    var weights:[Int]?
    var rest:[Int]?
}

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

