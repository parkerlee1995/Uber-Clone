//
//  ViewController.swift
//  Uber
//
//  Created by Parker Lee on 10/20/18.
//  Copyright © 2018 Parker Lee. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var riderDriverSwitch: UISwitch!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var riderLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    
    var signUpMode: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            displayAlert(title: "Missing Information", message: "You must provide both a valid email and password")
        } else {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    if signUpMode {
                        //SIGN UP
                        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            } else {
                                print("Sign Up successful!")
                                self.performSegue(withIdentifier: "riderSegue", sender: nil)
                            }
                        }
                    } else {
                        //LOG IN
                        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            } else {
                                print("Log In successful!")
                                self.performSegue(withIdentifier: "riderSegue", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        
        if signUpMode {
            signUpButton.setTitle("Log In", for: .normal)
            logInButton.setTitle("Switch to Sign Up", for: .normal)
            riderLabel.isHidden = true
            driverLabel.isHidden = true
            riderDriverSwitch.isHidden = true
            signUpMode = false
        } else {
            signUpButton.setTitle("Sign Up", for: .normal)
            logInButton.setTitle("Switch to Log In", for: .normal)
            riderLabel.isHidden = false
            driverLabel.isHidden = false
            riderDriverSwitch.isHidden = false
            signUpMode = true
        }
        
    }
    
}

