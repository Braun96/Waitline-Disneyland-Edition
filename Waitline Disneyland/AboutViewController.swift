//
//  AboutViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/30/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit


class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = false

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        
        aboutTextView.setContentOffset(CGPoint.zero, animated: false)
    }

    

}
