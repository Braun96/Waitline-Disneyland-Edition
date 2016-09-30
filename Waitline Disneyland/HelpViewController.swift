//
//  HelpViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/30/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
        
    @IBOutlet weak var helpTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        helpTextView.setContentOffset(CGPoint.zero, animated: false)
    }

}
