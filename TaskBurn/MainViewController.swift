//
//  MainViewController.swift
//  TaskBurn
//
//  Created by Avinash Reddy on 7/19/17.
//  Copyright © 2017 Avinash Reddy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {
    
    static let kUserLoggedInSegueIdentifier = "userLoggedIn"

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let auth = Auth.auth()  {
            // to get notification if the user signed in
            
            let auth = Auth.auth()
            auth.addStateDidChangeListener({ (auth, user) in
                if user != nil && user != self.currentUser {
                    self.currentUser = user
                    self.performSegue(withIdentifier: MainViewController.kUserLoggedInSegueIdentifier, sender: self)
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register_click(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) {
            user, error in
            
            if ((error?.localizedDescription) != nil) {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func login_click(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if ((error?.localizedDescription) != nil) {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func signout_click(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
