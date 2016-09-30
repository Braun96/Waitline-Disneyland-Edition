//
//  QuestionInterfaceViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/16/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class QuestionInterfaceViewController: UIViewController, UITextFieldDelegate {

    var answerSound = AVAudioPlayer()
    var question : Questions?
    

    @IBAction func goPressed(_ sender: AnyObject) {
        determiningOutcome()
    }
    
    
    //Correct Properties
    let correctColor = UIColor(red: 37/255, green: 135/255, blue: 54/255, alpha: 1)
    var correctAnswer = ""
    let correctPath = Bundle.main.path(forResource: "correctSound", ofType: "mp3")

    //Incorrect Properties
    let incorrectColor = UIColor(red: 153/255, green: 1/255, blue: 36/255, alpha: 1)
    let incorrectPath = Bundle.main.path(forResource: "incorrectSound1", ofType: "mp3")

    let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext

    @IBOutlet weak var questionViewLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func needHelpPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "QuestionInterfaceToHelp", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let correctURL = URL(fileURLWithPath: correctPath!)
        let incorrectURL = URL(fileURLWithPath: incorrectPath!)

        if inputTextField.text?.lowercased() ==  "" {
            questionViewLabel.backgroundColor = UIColor.gray
            
// Correct Outcome
        } else if inputTextField.text?.lowercased() == self.correctAnswer.lowercased() {
            inputTextField.backgroundColor = correctColor
            do {
                self.answerSound = try AVAudioPlayer(contentsOf: correctURL, fileTypeHint: nil)
            }
            catch{}
            self.answerSound.play()
            self.question?.resultImage = UIImageJPEGRepresentation(UIImage(named: "CorrectMickeyHead.jpg")!, 1) as NSData?
            do {
                try context.save()
            } catch {
                
            }
            
// Incorrect Outcome
        } else {
            inputTextField.backgroundColor = incorrectColor
            self.question?.resultImage = UIImageJPEGRepresentation(UIImage(named: "IncorrectMickey.jpg")!, 1) as NSData?
            do {
                self.answerSound = try AVAudioPlayer(contentsOf: incorrectURL, fileTypeHint: nil)
            }
            catch{}
            self.answerSound.play()
            do {
                try context.save()
            } catch {
                
            }
        }
        return true
    }
    
    func determiningOutcome() {
        let correctURL = URL(fileURLWithPath: correctPath!)
        let incorrectURL = URL(fileURLWithPath: incorrectPath!)
        
        if inputTextField.text?.lowercased() ==  "" {
            questionViewLabel.backgroundColor = UIColor.gray
            
            // Correct Outcome
        } else if inputTextField.text?.lowercased() == self.correctAnswer.lowercased() {
            inputTextField.backgroundColor = correctColor
            do {
                self.answerSound = try AVAudioPlayer(contentsOf: correctURL, fileTypeHint: nil)
            }
            catch{}
            self.answerSound.play()
            self.question?.resultImage = UIImageJPEGRepresentation(UIImage(named: "CorrectMickeyHead.jpg")!, 1) as NSData?
            do {
                try context.save()
            } catch {
                
            }
            
            // Incorrect Outcome
        } else {
            inputTextField.backgroundColor = incorrectColor
            self.question?.resultImage = UIImageJPEGRepresentation(UIImage(named: "IncorrectMickey.jpg")!, 1) as NSData?
            do {
                self.answerSound = try AVAudioPlayer(contentsOf: incorrectURL, fileTypeHint: nil)
            }
            catch{}
            self.answerSound.play()
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionViewLabel.text = self.question?.theQuestion
        self.correctAnswer = (self.question?.correctAnswer)!
        self.questionViewLabel.layer.cornerRadius = 10
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Mouse Memoirs", size: 24)!], for: UIControlState())
        navigationItem.backBarButtonItem = backButton
        self.navigationController!.navigationBar.isHidden = false
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Mouse Memoirs", size: 24)!]
        self.navigationItem.title = self.question?.questionTitle
        
        //Keyboard Type Checker
        
        if self.question?.keyboardType == true {
            
            self.inputTextField.keyboardType = UIKeyboardType.default
            
        } else if self.question?.keyboardType == false {
            
           self.inputTextField.keyboardType = UIKeyboardType.numberPad
        
        } else {
            
            self.inputTextField.keyboardType = UIKeyboardType.default
        }


        
        
        

        
    }

}
