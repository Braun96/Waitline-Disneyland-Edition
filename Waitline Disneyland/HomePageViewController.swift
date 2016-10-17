//
//  HomePageViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/29/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds


class HomePageViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    var Score = 0
    

    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    

    @IBAction func playPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "PlayToLandSelector", sender: self)
    }
    @IBAction func helpPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "HelpButtonPressed", sender: self)
    }
    @IBAction func aboutPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "AboutViewControllerSegue", sender: self)
    }
    @IBAction func resetButton(_ sender: AnyObject) {
        resetAlert()
    }
    
    
    
    func CoreDataReset() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Land")
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch {
        }
    }
    
    func CoreDataResetAtButton() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Land")
        fetchRequest.returnsObjectsAsFaults = false
        let ScoreDefault = UserDefaults.standard
        ScoreDefault.removeObject(forKey: "Score")
        ScoreDefault.synchronize()
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            ScoreLabel.text = "0 Points"
            CompletionAlert()
        } catch {
            print("There Was an error")
            FailedCompletionAlert()
        }
    }
    
    func FailedCompletionAlert() {
        let failedCompletionAlert = UIAlertController(title: "Something Went Wrong", message: "Sorry folks! Something when wrong when trying to delete your answers and score. Please try again later", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in failedCompletionAlert.dismiss(animated: true, completion: nil)
        }
        failedCompletionAlert.addAction(okAction)
        self.present(failedCompletionAlert, animated: true, completion: nil)
    }
    
    func CompletionAlert() {
        let completedAlert = UIAlertController(title: "Sucess!", message: "Your answers and score were sucessfully deleted!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in completedAlert.dismiss(animated: true, completion: nil)
        }
        completedAlert.addAction(okAction)
        self.present(completedAlert, animated: true, completion: nil)
    }
    
    func resetAlert() {
        let alert = UIAlertController(title: "Reset Answers", message: "Are you sure you want to delete all of your answers and your score?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in alert.dismiss(animated: true, completion: nil)
        }
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertActionStyle.default) {
            UIAlertAction in self.CoreDataResetAtButton()
   
        }
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func versionChecker() {
        let versionDefaults = UserDefaults.standard
        
        switch version {
            
        case "4.1" :
            if versionDefaults.bool(forKey: "version 4.1") {
                
                print("Correct Version Number \(version)")
                
            } else {
                versionDefaults.set(true, forKey: "version 4.1")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
                
            }
            
        case "4.0" :
            if versionDefaults.bool(forKey: "version 4.0") {
                
                print("Correct Version Number \(version)")
                
            } else {
                versionDefaults.set(true, forKey: "version 4.0")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
                
            }
        case "3.5" :
            if versionDefaults.bool(forKey: "version 3.5") {
                
                print("Correct Version Number \(version)")
                
            } else {
                versionDefaults.set(true, forKey: "version 3.5")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
                
            }
            
        case "3.4" :
            if versionDefaults.bool(forKey: "version 3.4") {
                
                print("Correct Version Number \(version)")
                
            } else {
                versionDefaults.set(true, forKey: "version 3.4")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
                
            }
            
        case "3.3" :
            if versionDefaults.bool(forKey: "version 3.3") {
                
                print("Correct Version Number \(version)")
                
            } else {
                versionDefaults.set(true, forKey: "version 3.3")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
                
            }
            
        case "3.2" :
            if versionDefaults.bool(forKey: "version 3.2") {
                
                print("Correct Version Number \(version)")
                
            } else {
                versionDefaults.set(true, forKey: "version 3.2")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            
            }
            
            case "3.1" :
            if versionDefaults.bool(forKey: "version 3.1") {
            
                print("Correct Version Number \(version)")
                
            } else {
                versionDefaults.set(true, forKey: "version 3.1")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
            
        case "3" :
            if versionDefaults.bool(forKey: "version3") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version3")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
            
        case "3.0" :
            if versionDefaults.bool(forKey: "version3.0") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version3.0")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
            
        default :
            print("We hit the default case for some reason")
            
    }
    }


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionChecker()
        UINavigationBar.appearance().tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Mouse Memoirs", size: 24)!], for: UIControlState())
        navigationItem.backBarButtonItem = backButton
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adBannerView.delegate = self
        adBannerView.adSize = kGADAdSizeBanner
        adBannerView.adUnitID = "ca-app-pub-6204815189288145/4633140519"
        adBannerView.rootViewController = self
        adBannerView.load(request)
        
        

        
        
        
        
        
        self.navigationController!.navigationBar.isHidden = true

        
}

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = true
        
        let ScoreDefault = UserDefaults.standard
        
        if (ScoreDefault.value(forKey: "Score") != nil) {
            Score = ScoreDefault.value(forKey: "Score") as! NSInteger
            ScoreLabel.text = NSString(format: "%i Points", Score) as String?
        }

}

}

