//
//  AboutViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/30/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit
import GoogleMobileAds



class AboutViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var adBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = false

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adBannerView.delegate = self
        adBannerView.adSize = kGADAdSizeBanner
        adBannerView.adUnitID = "ca-app-pub-6204815189288145/4633140519"
        adBannerView.rootViewController = self
        adBannerView.load(request)
       
        
        aboutTextView.setContentOffset(CGPoint.zero, animated: false)
    }

    

}
