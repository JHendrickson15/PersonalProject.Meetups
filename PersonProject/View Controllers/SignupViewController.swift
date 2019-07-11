////
////  SignupViewController.swift
////  PersonProject
////
////  Created by Jordan Hendrickson on 7/10/19.
////  Copyright © 2019 Jordan Hendrickson. All rights reserved.
////
//
//import UIKit
//
//class SignupViewController: UIViewController {
//
//    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var signupButton: UIButton!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//    @IBAction func signupButtonTapped(_ sender: Any) {
//
//        guard let username = usernameTextField.text,
//        !username.isEmpty,
//        let password = passwordTextField.text,
//        !password.isEmpty
//            else {return}
//        
//        UserController.shared.createNewUser(username: username, password: password) { (success) in
//            if success {
//                DispatchQueue.main.async {
//                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                    let viewController = storyBoard.instantiateViewController(withIdentifier: "navController")
//                    UIApplication.shared.windows.first?.rootViewController = viewController
//                }
//            }else{
//            }
//        }
//    }
//
//}
