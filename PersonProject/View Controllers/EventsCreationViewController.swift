//
//  EventsCreationViewController.swift
//  PersonProject
//
//  Created by Jordan Hendrickson on 7/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import UIKit

class EventsCreationViewController: UIViewController {

    @IBOutlet weak var eventNameLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    var location: Events?
    
    func updateViews(){
        print(location?.name)
        guard let location = location else {return}
        self.eventNameLabel.text = location.name
    }
}
