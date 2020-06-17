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
    
    var isSignIn:Bool = true
    var userId:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
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
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // TODO: do better form validation
        if let email = emailTextField.text, let password = passwordTextField.text {
            // check if it is signing in or registering
            if isSignIn {
                // sign in user with firebase
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    
                    //guard let strongSelf = self else {return}
                    
                    // check that user isn't nil
                    if let user = authResult?.user {
                        // user is found. Go to homescreen
                        print(user.uid)
                        self?.userId = user.uid
                        print(self?.userId! ?? "error")
                        self?.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        print("error1")
                        // Error
                        
                    }
                }
            }
            else {
                // register user with firebase
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    
                    // check that user isn't nil
                    if let user = authResult?.user {
                        // user is found. Go to homescreen
                        print("here2")
                        print(user.uid)
                        self.userId = user.uid
                        print(self.userId!)
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error
                        print("error2")
                        print(error ?? "error with error message")
                        
                    }
                }
            }
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is UITabBarController {
            
            let vc = segue.destination as? UITabBarController
            let exercisesVC = vc?.customizableViewControllers?[1] as? SecondViewController
            exercisesVC?.userId = self.userId!
            
        }
        
    }
    
}
