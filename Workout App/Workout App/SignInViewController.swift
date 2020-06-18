//
//  SignInViewController.swift
//  Workout App
//
//  Created by Rita Meriano on 6/17/20.
//  Copyright © 2020 Gabe Dan. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var ref:DatabaseReference?
    
    // keeps track of if screen is on sign in or register mode
    var isSignIn:Bool = true
    
    // id of user
    var userId:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // setup reference to database
        ref = Database.database().reference()

    }
    
    
    // called if user switches from sign in to register mode or vice versa
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        // flip from sign in to register or vice versa
        isSignIn = !isSignIn
        
        // set labels for either sign in or register
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    // when user hits sign in or register button
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // TODO: do better form validation
        
        // get user input for email and password
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            // check if it is signing in or registering
            
            // SIGN-IN
            if isSignIn {
                // sign in user with firebase
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                                        
                    // check that user isn't nil
                    if let user = authResult?.user {
                        
                        // set user id
                        self?.userId = user.uid
                        
                        // go to home screen
                        self?.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        print("Error at sign in")
                        
                    }
                }
            }
                
            // REGISTER
            else {
                // register user with firebase
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    
                    // check that user isn't nil
                    if let user = authResult?.user {
                        
                        // set user id
                        self.userId = user.uid
                        
                        // setup database with user's id
                        self.ref!.child(self.userId!).setValue("Exercises")
                        
                        // go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        print("Error at registration")
                        
                    }
                }
            }
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Dismisses the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is UITabBarController {
            
            // sends the userId to SecondViewController
            let vc = segue.destination as? UITabBarController
            let exercisesVC = vc?.customizableViewControllers?[1] as? SecondViewController
            exercisesVC?.userId = self.userId!
            
        }
        
    }
    
    
    @IBAction func devTestingLoginDan(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: "dpm7@rice.edu", password: "password") { [weak self] authResult, error in
                                
            // check that user isn't nil
            if let user = authResult?.user {
                
                // set user id
                self?.userId = user.uid
                
                // go to home screen
                self?.performSegue(withIdentifier: "goToHome", sender: self)
            }
            else {
                print("Error at sign in")
                
            }
        }
        
    }
    
    
    @IBAction func devTestingLoginGabe(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: "gvmeriano@gmail.com", password: "testing") { [weak self] authResult, error in
                                
            // check that user isn't nil
            if let user = authResult?.user {
                
                // set user id
                self?.userId = user.uid
                
                // go to home screen
                self?.performSegue(withIdentifier: "goToHome", sender: self)
            }
            else {
                print("Error at sign in")
                
            }
        }
        
    }
    
    
}
