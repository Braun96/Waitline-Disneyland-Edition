//
//  HelpViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/30/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HelpViewController: UIViewController, GADBannerViewDelegate {
        
    @IBOutlet weak var helpTextView: UITextView!
    @IBOutlet weak var adBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = false
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adBannerView.delegate = self
        adBannerView.adSize = kGADAdSizeBanner
        adBannerView.adUnitID = "ca-app-pub-6204815189288145/4633140519"
        adBannerView.rootViewController = self
        adBannerView.load(request)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        helpTextView.setContentOffset(CGPoint.zero, animated: false)
    }

}
