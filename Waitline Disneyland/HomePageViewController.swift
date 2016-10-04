//
//  HomePageViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/29/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit
import CoreData


class HomePageViewController: UIViewController {
    

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
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            CompletionAlert()
        } catch {
            print("There Was an error")
            FailedCompletionAlert()
        }
    }
    
    func FailedCompletionAlert() {
        let failedCompletionAlert = UIAlertController(title: "Something Went Wrong", message: "Sorry folks! Something when wrong when trying to delete your answers. Please try again later", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in failedCompletionAlert.dismiss(animated: true, completion: nil)
        }
        failedCompletionAlert.addAction(okAction)
        self.present(failedCompletionAlert, animated: true, completion: nil)
    }
    
    func CompletionAlert() {
        let completedAlert = UIAlertController(title: "Sucess!", message: "Your answers were sucessfully deleted!", preferredStyle: .alert)
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
            
        case "3.1" :
            if versionDefaults.bool(forKey: "version 3.1") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version3.1")
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
        
        case "2.9" :
            if versionDefaults.bool(forKey: "2.9") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version2.9")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
            
        case "2.8" :
            if versionDefaults.bool(forKey: "version2.8") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version2.8")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
            
        case "2.7" :
            if versionDefaults.bool(forKey: "version2.7") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version2.7")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
        
        case "2.6" :
            if versionDefaults.bool(forKey: "version2.6") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version2.6")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
        case "2.5" :
            if versionDefaults.bool(forKey: "version2.5") {
                //has updated
                print("Correct Version Number \(version)")
            } else {
                versionDefaults.set(true, forKey: "version2.5")
                versionDefaults.synchronize()
                CoreDataReset()
                print("updated by case \(version)")
            }
        default :
            if versionDefaults.bool(forKey: "versiondefault")   {
                print("Correct Version Number \(version)")
            } else {
            versionDefaults.set(true, forKey: "versiondefault")
            versionDefaults.synchronize()
            CoreDataReset()
            print("updated by default \(version)")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionChecker()
        UINavigationBar.appearance().tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Mouse Memoirs", size: 24)!], for: UIControlState())
        navigationItem.backBarButtonItem = backButton
        
        
        
        self.navigationController!.navigationBar.isHidden = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = true

    }
}


