//
//  FetchUserViewController.swift
//  PersonProject
//
//  Created by Jordan Hendrickson on 7/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

//import UIKit
//
//class FetchUserViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    UserController.shared.fetchCurrentUser { (success) in
//    if success {
//    DispatchQueue.main.async {
//    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//    let viewController = storyBoard.instantiateViewController(withIdentifier: "navController")
//    UIApplication.shared.windows.first?.rootViewController = viewController
//    }
//    }else{
//    DispatchQueue.main.async {
//    self.performSegue(withIdentifier: "fromFetchToSignup", sender: nil)
//    }
//    }
//    }
//
//}
