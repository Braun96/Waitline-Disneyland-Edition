//
//  QuestionsViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/16/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit
import GoogleMobileAds
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class QuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GADBannerViewDelegate{

    @IBOutlet weak var questionsTableView: UITableView!
    @IBOutlet weak var adBannerView: GADBannerView!
    

    var land : Land?
    
    var questions = [Questions]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questions = self.land?.question?.allObjects as! [Questions]
        
        self.questionsTableView.dataSource = self
        self.questionsTableView.delegate = self
        self.navigationController!.navigationBar.isHidden = false

        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Mouse Memoirs", size: 24)!], for: UIControlState())
        navigationItem.backBarButtonItem = backButton

        questions.sort(by: {$0.questionInt?.int32Value < $1.questionInt?.int32Value})
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adBannerView.delegate = self
        adBannerView.adSize = kGADAdSizeBanner
        adBannerView.adUnitID = "ca-app-pub-6204815189288145/4633140519"
        adBannerView.rootViewController = self
        adBannerView.load(request)
        

   }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.questionsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.questions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let question = self.questions[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = question.questionTitle
        cell.textLabel?.font = UIFont(name: "Mouse Memoirs", size: 24)
       cell.imageView!.image = UIImage(data: (question.resultImage)! as Data)
        cell.imageView!.backgroundColor = UIColor.clear
        cell.isOpaque = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = self.questions[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "QuestionsToQuestionInterface", sender: question)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionInterfaceVC = segue.destination as! QuestionInterfaceViewController
        questionInterfaceVC.question = sender as? Questions
    }
    

}
