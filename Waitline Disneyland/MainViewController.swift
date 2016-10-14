//
//  ViewController.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 1/16/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
// GitHub Test

import UIKit
import CoreData
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


class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var landNameTableView: UITableView!
    @IBOutlet weak var collectionViewOfLands: UICollectionView!
    
    
    
    
    var lands = [Land]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionViewOfLands.dataSource = self
        self.collectionViewOfLands.delegate = self
        
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let landRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Land")

        do {
            try self.lands = context.fetch(landRequest) as! [Land]
            if self.lands.count <= 0 {
                fillWaitline()
            }
        } catch {
        }
        
        grabLands()
        
        lands.sort(by: {$0.landName < $1.landName})
        UINavigationBar.appearance().tintColor = UIColor.black
        self.navigationController!.navigationBar.isHidden = false
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Mouse Memoirs", size: 24)!], for: UIControlState())
        navigationItem.backBarButtonItem = backButton
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOfLands.dequeueReusableCell(withReuseIdentifier: "landPhotoCollectionCell", for: indexPath) as! LandSelectorCollectionViewCell
        let land = self.lands[(indexPath as NSIndexPath).row]
        
        cell.landPictureImageView.image = UIImage(named: land.artWorkForLand!)
        cell.landIdentifacationLabel.text = land.landName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewOfLands.bounds.size.width - 60, height: self.collectionViewOfLands.bounds.size.height - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theLandSelected = self.lands[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "LandsToQuestionsSegue", sender: theLandSelected)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionsViewController = segue.destination as! QuestionsViewController
        questionsViewController.land = sender as? Land
        
    }
    
    func grabLands() {
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let landRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Land")

        do {
        try self.lands = context.fetch(landRequest) as! [Land]
        } catch {
        }
        self.collectionViewOfLands.reloadData()
    }
    
    func landNumberChecker(){
    if self.lands.count <= 0 {
    fillWaitline()
    } else {
        }
    }
    
    
    }

    func fillWaitline() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let landDescription = NSEntityDescription.entity(forEntityName: "Land", in: context)
        let questionDescription = NSEntityDescription.entity(forEntityName: "Questions", in: context)
        let greyMouse = UIImageJPEGRepresentation(UIImage(named: "UnansweredMickey.jpg")!, 1) as NSData?
        
        
//Main Street USA!!!
        
        
        let mainStreetUSA = Land(entity: landDescription!, insertInto: context)
        
        mainStreetUSA.landName = "Main Street U.S.A."
        mainStreetUSA.artWorkForLand = "MainStreetPicture.jpg"
        
        //Main Street Windows (1-50)
        let msWindows1 = Questions(entity: questionDescription!, insertInto: context)
        msWindows1.questionTitle = "Main Street Windows 1"
        msWindows1.theQuestion = "Who is the Proprietor of the Exotic Art Store on Main Street?"
        msWindows1.correctAnswer = "Marc Davis"
        msWindows1.keyboardType = true
        msWindows1.resultImage = greyMouse
        msWindows1.answerBool = false
        msWindows1.questionInt = 1
        msWindows1.land = mainStreetUSA
        
        let msWindows2 = Questions(entity: questionDescription!, insertInto: context)
        msWindows2.questionTitle = "Main Street Windows 2"
        msWindows2.theQuestion = "The slogan of the Photographic Studio, as shown on the window, is \"Bright Views __ _____\"."
        msWindows2.correctAnswer = "to order"
        msWindows2.keyboardType = true
        msWindows2.resultImage = greyMouse
        msWindows2.answerBool = false
        msWindows2.questionInt = 2
        msWindows2.land = mainStreetUSA
        
        let msWindows3 = Questions(entity: questionDescription!, insertInto: context)
        msWindows3.questionTitle = "Main Street Windows 3"
        msWindows3.theQuestion = "\"Can Do Machine Works\" is printed on what buisnesses window on Main Street? (3 Words)"
        msWindows3.correctAnswer = "The Magic Shop"
        msWindows3.keyboardType = true
        msWindows3.resultImage = greyMouse
        msWindows3.answerBool = false
        msWindows3.questionInt = 3
        msWindows3.land = mainStreetUSA
        
        let msWindows4 = Questions(entity: questionDescription!, insertInto: context)
        msWindows4.questionTitle = "Main Street Windows 4"
        msWindows4.theQuestion = "When looking at the window at City Hall you see that J.B. Lindquist is named as Honorary ______________ of Disneyland."
        msWindows4.correctAnswer = "Mayor"
        msWindows4.keyboardType = true
        msWindows4.resultImage = greyMouse
        msWindows4.answerBool = false
        msWindows4.questionInt = 4
        msWindows4.land = mainStreetUSA
        
        let msWindows5 = Questions(entity: questionDescription!, insertInto: context)
        msWindows5.questionTitle = "Main Street Windows 5"
        msWindows5.theQuestion = "Walt honored his father Elias Disney with a window on Main Street.  This window lists Elias as a __________."
        msWindows5.correctAnswer = "Contractor"
        msWindows5.keyboardType = true
        msWindows5.resultImage = greyMouse
        msWindows5.answerBool = false
        msWindows5.questionInt = 5
        msWindows5.land = mainStreetUSA
        
        //Main Street Cars (51-100)
        let msCars1 = Questions(entity: questionDescription!, insertInto: context)
        msCars1.questionTitle = "Main Street Cars 1"
        msCars1.theQuestion = "On select days, what number fire engine can you ride down Main Street?"
        msCars1.correctAnswer = "1"
        msCars1.keyboardType = false
        msCars1.resultImage = greyMouse
        msCars1.answerBool = false
        msCars1.questionInt = 51
        msCars1.land = mainStreetUSA
        
        let msCars2 = Questions(entity: questionDescription!, insertInto: context)
        msCars2.questionTitle = "Main Street Cars 2"
        msCars2.theQuestion = "What is the main color of the Omnibus that takes guests up and down Main Street?"
        msCars2.correctAnswer = "Green"
        msCars2.keyboardType = true
        msCars2.resultImage = greyMouse
        msCars2.answerBool = false
        msCars2.questionInt = 52
        msCars2.land = mainStreetUSA
        
        let msCars3 = Questions(entity: questionDescription!, insertInto: context)
        msCars3.questionTitle = "Main Street Cars 3"
        msCars3.theQuestion = "On the back of the Main Street Firetruck is a folded up firehose. What is the color of the firehose?"
        msCars3.correctAnswer = "white"
        msCars3.keyboardType = true
        msCars3.resultImage = greyMouse
        msCars3.answerBool = false
        msCars3.questionInt = 53
        msCars3.land = mainStreetUSA
        
        //Main Street Food(101-150)
        let msFood = Questions(entity: questionDescription!, insertInto: context)
        msFood.questionTitle = "Main Street Food"
        msFood.theQuestion = "What restaurant on Main Street has a Golden Chicken on its weather vane? (2 Words)"
        msFood.correctAnswer = "Plaza Inn"
        msFood.keyboardType = true
        msFood.resultImage = greyMouse
        msFood.answerBool = false
        msFood.questionInt = 101
        msFood.land = mainStreetUSA
        
        //Main Street Cinema (151-200)
        let msCinema1 = Questions(entity: questionDescription!, insertInto: context)
        msCinema1.questionTitle = "Main Street Cinema 1"
        msCinema1.theQuestion = "How many different Cartoons are being shown in the theater?"
        msCinema1.correctAnswer = "6"
        msCinema1.keyboardType = false
        msCinema1.resultImage = greyMouse
        msCinema1.answerBool = false
        msCinema1.questionInt = 151
        msCinema1.land = mainStreetUSA
        
        let msCinema2 = Questions(entity: questionDescription!, insertInto: context)
        msCinema2.questionTitle = "Main Street Cinema 2"
        msCinema2.theQuestion = "At the Main Street Cinema, who is selling tickets?"
        msCinema2.correctAnswer = "Tilly"
        msCinema2.keyboardType = true
        msCinema2.resultImage = greyMouse
        msCinema2.answerBool = false
        msCinema2.questionInt = 152
        msCinema2.land = mainStreetUSA
        
        //Main Street Misc (201-250)
        let fireDepartment = Questions(entity: questionDescription!, insertInto: context)
        fireDepartment.questionTitle = "Fire Department"
        fireDepartment.theQuestion = "What is the Main Street Fire Department number?"
        fireDepartment.correctAnswer = "105"
        fireDepartment.keyboardType = false
        fireDepartment.resultImage = greyMouse
        fireDepartment.answerBool = false
        fireDepartment.questionInt = 201
        fireDepartment.land = mainStreetUSA
        
        let movieTime = Questions(entity: questionDescription!, insertInto: context)
        movieTime.questionTitle = "Movie Time"
        movieTime.theQuestion = "What 1928 cartoon classic is played in the Main Street Cinema? (Two Words)"
        movieTime.correctAnswer = "Steamboat Willie"
        movieTime.keyboardType = true
        movieTime.resultImage = greyMouse
        movieTime.answerBool = false
        movieTime.questionInt = 202
        movieTime.land = mainStreetUSA
        
        let president = Questions(entity: questionDescription!, insertInto: context)
        president.questionTitle = "President"
        president.theQuestion = "Which President of the United States is audio-animatronically represented in a show on Main Street? (Two Words)"
        president.correctAnswer = "Abraham Lincoln"
        president.keyboardType = true
        president.resultImage = greyMouse
        president.answerBool = false
        president.questionInt = 203
        president.land = mainStreetUSA
        
        let trains = Questions(entity: questionDescription!, insertInto: context)
        trains.questionTitle = "Trains"
        trains.theQuestion = "What is the name of the Presidential train car on the Disneyland Railroad? (Two Words)"
        trains.correctAnswer = "Lilly Belle"
        trains.keyboardType = true
        trains.resultImage = greyMouse
        trains.answerBool = false
        trains.questionInt = 204
        trains.land = mainStreetUSA
        
        let statue = Questions(entity: questionDescription!, insertInto: context)
        statue.questionTitle = "Statue"
        statue.theQuestion = "What is the name of the statue that is in the Hub at the end of Main Street?"
        statue.correctAnswer = "Partners"
        statue.keyboardType = true
        statue.resultImage = greyMouse
        statue.answerBool = false
        statue.questionInt = 205
        statue.land = mainStreetUSA
        
        let moreStatues = Questions(entity: questionDescription!, insertInto: context)
        moreStatues.questionTitle = "More Statues"
        moreStatues.theQuestion = "How many small statues surround the Partners statue in the Hub at the end of Main Street?"
        moreStatues.correctAnswer = "8"
        moreStatues.keyboardType = false
        moreStatues.resultImage = greyMouse
        moreStatues.answerBool = false
        moreStatues.questionInt = 206
        moreStatues.land = mainStreetUSA
        
        let ridingTheRails = Questions(entity: questionDescription!, insertInto: context)
        ridingTheRails.questionTitle = "Riding the Rails"
        ridingTheRails.theQuestion = "How many stops does the Disneyland Railroad Make?"
        ridingTheRails.correctAnswer = "4"
        ridingTheRails.keyboardType = false
        ridingTheRails.resultImage = greyMouse
        ridingTheRails.answerBool = false
        ridingTheRails.questionInt = 207
        ridingTheRails.land = mainStreetUSA
        
        let moreTrains = Questions(entity: questionDescription!, insertInto: context)
        moreTrains.questionTitle = "More Trains"
        moreTrains.theQuestion = "The train car Lilly Belle is named after Walt's _____________?"
        moreTrains.correctAnswer = "Wife"
        moreTrains.keyboardType = true
        moreTrains.resultImage = greyMouse
        moreTrains.answerBool = false
        moreTrains.questionInt = 208
        moreTrains.land = mainStreetUSA
        
        let workingHard = Questions(entity: questionDescription!, insertInto: context)
        workingHard.questionTitle = "Working Hard"
        workingHard.theQuestion = "What are the workers at Disneyland called?"
        workingHard.correctAnswer = "Cast Members"
        workingHard.keyboardType = true
        workingHard.resultImage = greyMouse
        workingHard.answerBool = false
        workingHard.questionInt = 209
        workingHard.land = mainStreetUSA
        
        let playingHard = Questions(entity: questionDescription!, insertInto: context)
        playingHard.questionTitle = "Playing Hard"
        playingHard.theQuestion = "What are the rides at Disneyland called?"
        playingHard.correctAnswer = "Attractions"
        playingHard.keyboardType = true
        playingHard.resultImage = greyMouse
        playingHard.answerBool = false
        playingHard.questionInt = 210
        playingHard.land = mainStreetUSA
        
        let redWagon = Questions(entity: questionDescription!, insertInto: context)
        redWagon.questionTitle = "Red Wagon"
        redWagon.theQuestion = "The Red Wagon near the end of Main Street is famous for selling what?"
        redWagon.correctAnswer = "Corn Dogs"
        redWagon.keyboardType = true
        redWagon.resultImage = greyMouse
        redWagon.answerBool = false
        redWagon.questionInt = 211
        redWagon.land = mainStreetUSA
        
        let saying = Questions(entity: questionDescription!, insertInto: context)
        saying.questionTitle = "Saying"
        saying.theQuestion = "As you enter Disneyland and go under the bridge there is a plaque.  Complete the saying.  \"Here you leave today and enter the world of yesterday, tomorrow, and ____________.\" (One Word)"
        saying.correctAnswer = "Fantasy"
        saying.keyboardType = true
        saying.resultImage = greyMouse
        saying.answerBool = false
        saying.questionInt = 212
        saying.land = mainStreetUSA
        
        let apartment = Questions(entity: questionDescription!, insertInto: context)
        apartment.questionTitle = "Apartment"
        apartment.theQuestion = "Walt's apartment is located above the ___________. (One Word)"
        apartment.correctAnswer = "Firehouse"
        apartment.keyboardType = true
        apartment.resultImage = greyMouse
        apartment.answerBool = false
        apartment.questionInt = 213
        apartment.land = mainStreetUSA
        
        let boom = Questions(entity: questionDescription!, insertInto: context)
        boom.questionTitle = "Boom"
        boom.theQuestion = "What is in the main hub that was used by the French Army? (one word plural form)"
        boom.correctAnswer = "Cannons"
        boom.keyboardType = true
        boom.resultImage = greyMouse
        boom.answerBool = false
        boom.questionInt = 214
        boom.land = mainStreetUSA
        
        let buildings = Questions(entity: questionDescription!, insertInto: context)
        buildings.questionTitle = "Buildings"
        buildings.theQuestion = "Which building houses the attraction Great Moments with Mr. Lincoln? (3 Words)"
        buildings.correctAnswer = "The Opera House"
        buildings.keyboardType = true
        buildings.resultImage = greyMouse
        buildings.answerBool = false
        buildings.questionInt = 215
        buildings.land = mainStreetUSA
        
        let trainRide = Questions(entity: questionDescription!, insertInto: context)
        trainRide.questionTitle = "Train Ride"
        trainRide.theQuestion = "When riding the train on the grand circle tour of Disneyland, you travel along the rim of the ____________ Canyon."
        trainRide.correctAnswer = "Grand"
        trainRide.keyboardType = true
        trainRide.resultImage = greyMouse
        trainRide.answerBool = false
        trainRide.questionInt = 216
        trainRide.land = mainStreetUSA
        
        
        let visitors = Questions(entity: questionDescription!, insertInto: context)
        visitors.questionTitle = "Visitors"
        visitors.theQuestion = "What are visitors to Disneyland called?"
        visitors.correctAnswer = "Guests"
        visitors.keyboardType = true
        visitors.resultImage = greyMouse
        visitors.answerBool = false
        visitors.questionInt = 217
        visitors.land = mainStreetUSA
        
        let stayHappy = Questions(entity: questionDescription!, insertInto: context)
        stayHappy.questionTitle = "Stay happy"
        stayHappy.theQuestion = "Which building, as you enter the park, houses Guest Relations?"
        stayHappy.correctAnswer = "City Hall"
        stayHappy.keyboardType = true
        stayHappy.resultImage = greyMouse
        stayHappy.answerBool = false
        stayHappy.questionInt = 218
        stayHappy.land = mainStreetUSA
        
        let fortuneTelling = Questions(entity: questionDescription!, insertInto: context)
        fortuneTelling.questionTitle = "Fortune Telling"
        fortuneTelling.theQuestion = "What is the name of the fortune teller in the Penny Arcade?"
        fortuneTelling.correctAnswer = "Esmeralda"
        fortuneTelling.keyboardType = true
        fortuneTelling.resultImage = greyMouse
        fortuneTelling.answerBool = false
        fortuneTelling.questionInt = 219
        fortuneTelling.land = mainStreetUSA
        
        let lookClosely = Questions(entity: questionDescription!, insertInto: context)
        lookClosely.questionTitle = "Look Closely"
        lookClosely.theQuestion = "The names of important contributors to Disneyland are seen on the ________________ on Main Street. (plural form)"
        lookClosely.correctAnswer = "Windows"
        lookClosely.keyboardType = true
        lookClosely.resultImage = greyMouse
        lookClosely.answerBool = false
        lookClosely.questionInt = 220
        lookClosely.land = mainStreetUSA

        let elevation = Questions(entity: questionDescription!, insertInto: context)
        elevation.questionTitle = "Elevation"
        elevation.theQuestion = "According to the sign on the Disneyland Railroad, what is the elevation given at the Main Street Station?  ________feet above sea level."
        elevation.correctAnswer = "138"
        elevation.keyboardType = false
        elevation.resultImage = greyMouse
        elevation.answerBool = false
        elevation.questionInt = 221
        elevation.land = mainStreetUSA
        
        let bakery = Questions(entity: questionDescription!, insertInto: context)
        bakery.questionTitle = "Bakery"
        bakery.theQuestion = "The __________________ Bakery opened near the end of Main Street in Disneyland in 2012. (2 words)"
        bakery.correctAnswer = "Jolly Holiday"
        bakery.keyboardType = true
        bakery.resultImage = greyMouse
        bakery.answerBool = false
        bakery.questionInt = 222
        bakery.land = mainStreetUSA
        
        let caboose = Questions(entity: questionDescription!, insertInto: context)
        caboose.questionTitle = "Caboose"
        caboose.theQuestion = "What car number is the Lilly Belle?"
        caboose.correctAnswer = "106"
        caboose.keyboardType = false
        caboose.resultImage = greyMouse
        caboose.answerBool = false
        caboose.questionInt = 223
        caboose.land = mainStreetUSA
        
        let posters = Questions(entity: questionDescription!, insertInto: context)
        posters.questionTitle = "Posters"
        posters.theQuestion = "How many different attraction posters are in a single tunnel that you walk through under the Rail Road tracks?"
        posters.correctAnswer = "8"
        posters.keyboardType = false
        posters.resultImage = greyMouse
        posters.answerBool = false
        posters.questionInt = 224
        posters.land = mainStreetUSA
        
        let operaHouse = Questions(entity: questionDescription!, insertInto: context)
        operaHouse.questionTitle = "Opera House"
        operaHouse.theQuestion = "Above the opera house are how many golden theatre masks?"
        operaHouse.correctAnswer = "2"
        operaHouse.keyboardType = false
        operaHouse.resultImage = greyMouse
        operaHouse.answerBool = false
        operaHouse.questionInt = 225
        operaHouse.land = mainStreetUSA
        
        let emporium = Questions(entity: questionDescription!, insertInto: context)
        emporium.questionTitle = "Emporium"
        emporium.theQuestion = "What is the street number of the Emporium?"
        emporium.correctAnswer = "101"
        emporium.keyboardType = false
        emporium.resultImage = greyMouse
        emporium.answerBool = false
        emporium.questionInt = 226
        emporium.land = mainStreetUSA
        
        let palmParlor = Questions(entity: questionDescription!, insertInto: context)
        palmParlor.questionTitle = "Palm Parlor"
        palmParlor.theQuestion = "What is the name of the palm parlor on Main Street? (3 Words)"
        palmParlor.correctAnswer = "fargo's palm parlor"
        palmParlor.keyboardType = true
        palmParlor.resultImage = greyMouse
        palmParlor.answerBool = false
        palmParlor.questionInt = 227
        palmParlor.land = mainStreetUSA
        
        let plazaInn = Questions(entity: questionDescription!, insertInto: context)
        plazaInn.questionTitle = "Plaza Inn"
        plazaInn.theQuestion = "What the two main colors of the Plaza Inn are ______ and white."
        plazaInn.correctAnswer = "pink"
        plazaInn.keyboardType = true
        plazaInn.resultImage = greyMouse
        plazaInn.answerBool = false
        plazaInn.questionInt = 228
        plazaInn.land = mainStreetUSA
        
        
        
        
        
        
        

        
        
        
        
        
        
        
//Adventureland!!!!
        
        
        
        
        
        
        
        
        
        
        let adventureland = Land(entity: landDescription!, insertInto: context)
        
        adventureland.landName = "Adventureland"
        adventureland.artWorkForLand = "TikiRoom.jpg"

        //Tiki Room (1-50)
        let tikiRoom1 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom1.questionTitle = "Tiki Room 1"
        tikiRoom1.theQuestion = "What is the full name of The Tiki Room?"
        tikiRoom1.correctAnswer = "Walt Disney's Enchanted Tiki Room"
        tikiRoom1.keyboardType = true
        tikiRoom1.questionInt = 1
        tikiRoom1.resultImage = greyMouse
        tikiRoom1.answerBool = false
        tikiRoom1.land = adventureland
        
        let tikiRoom2 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom2.questionTitle = "Tiki Room 2"
        tikiRoom2.theQuestion = "In the Enchanted Tiki Garden what is the name of the God that says he roped the playful sun?"
        tikiRoom2.correctAnswer = "MAUi"
        tikiRoom2.keyboardType = true
        tikiRoom2.questionInt = 2
        tikiRoom2.resultImage = greyMouse
        tikiRoom2.answerBool = false
        tikiRoom2.land = adventureland
        
        let tikiRoom3 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom3.questionTitle = "Tiki Room 3"
        tikiRoom3.theQuestion = "In the Enchanted Tiki Garden what god is known as The Midnight Dancer?"
        tikiRoom3.correctAnswer = "KoRo"
        tikiRoom3.keyboardType = true
        tikiRoom3.questionInt = 3
        tikiRoom3.resultImage = greyMouse
        tikiRoom3.answerBool = false
        tikiRoom3.land = adventureland
        
        let tikiRoom4 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom4.questionTitle = "Tiki Room 4"
        tikiRoom4.theQuestion = "In the Enchanted Tiki Garden there is one god who stands out above them all. He says that \"from his limbs let new life fall\". What is the name of this god"
        tikiRoom4.correctAnswer = "Tangaroa"
        tikiRoom4.keyboardType = true
        tikiRoom4.questionInt = 4
        tikiRoom4.resultImage = greyMouse
        tikiRoom4.answerBool = false
        tikiRoom4.land = adventureland
        
        let tikiRoom5 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom5.questionTitle = "Tiki Room 5"
        tikiRoom5.theQuestion = "What company presents the Enchanted Tiki Room?"
        tikiRoom5.correctAnswer = "Dole"
        tikiRoom5.keyboardType = true
        tikiRoom5.questionInt = 5
        tikiRoom5.resultImage = greyMouse
        tikiRoom5.answerBool = false
        tikiRoom5.land = adventureland
        
        let tikiRoom6 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom6.questionTitle = "Tiki Room 6"
        tikiRoom6.theQuestion = "At the beginning of the show in the Tiki Room a Cast Member wakes up a bird. What is the name of the bird that is woken up?"
        tikiRoom6.correctAnswer = "Jose"
        tikiRoom6.keyboardType = true
        tikiRoom6.questionInt = 6
        tikiRoom6.resultImage = greyMouse
        tikiRoom6.answerBool = false
        tikiRoom6.land = adventureland
        
        let tikiRoom7 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom7.questionTitle = "Tiki Room 7"
        tikiRoom7.theQuestion = "While in the tiki room you will notice that there are a few birds who seem to be the stars of the show. How many birds are the main stars?"
        tikiRoom7.correctAnswer = "4"
        tikiRoom7.keyboardType = false
        tikiRoom7.questionInt = 7
        tikiRoom7.resultImage = greyMouse
        tikiRoom7.answerBool = false
        tikiRoom7.land = adventureland
        
        let tikiRoom8 = Questions(entity: questionDescription!, insertInto: context)
        tikiRoom8.questionTitle = "Tiki Room 8"
        tikiRoom8.theQuestion = "At the very end of the Tiki Room show the birds explain that they are going to do a \"Wonderful Magic Trick For you\". What movie is the song they sing from? (Two Words)"
        tikiRoom8.correctAnswer = "Snow White"
        tikiRoom8.keyboardType = true
        tikiRoom8.questionInt = 8
        tikiRoom8.resultImage = greyMouse
        tikiRoom8.answerBool = false
        tikiRoom8.land = adventureland
        
        
        
        //Jungle Cruise (51-100)
        
        let jungleCruise1 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise1.questionTitle = "Jungle Cruise 1"
        jungleCruise1.theQuestion = "How many spears stick out from the Jungle Cruise sign?"
        jungleCruise1.correctAnswer = "4"
        jungleCruise1.keyboardType = false
        jungleCruise1.questionInt = 51
        jungleCruise1.resultImage = greyMouse
        jungleCruise1.answerBool = false
        jungleCruise1.land = adventureland
        
        let jungleCruise2 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise2.questionTitle = "Jungle Cruise 2"
        jungleCruise2.theQuestion = "According to the ticket window near the entrance to the Jungle Cruise, how often do cruises depart?"
        jungleCruise2.correctAnswer = "Daily"
        jungleCruise2.keyboardType = true
        jungleCruise2.questionInt = 52
        jungleCruise2.resultImage = greyMouse
        jungleCruise2.answerBool = false
        jungleCruise2.land = adventureland
        
        let jungleCruise3 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise3.questionTitle = "Jungle Cruise 3"
        jungleCruise3.theQuestion = "At the beginning of the Jungle Cruise queue you will hear a radio that is sitting on a shelf. How many dials are on this radio?"
        jungleCruise3.correctAnswer = "2"
        jungleCruise3.keyboardType = false
        jungleCruise3.questionInt = 53
        jungleCruise3.resultImage = greyMouse
        jungleCruise3.answerBool = false
        jungleCruise3.land = adventureland
        
        let jungleCruise4 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise4.questionTitle = "Jungle Cruise 4"
        jungleCruise4.theQuestion = "Look for a keyring hanging from a wall mounted desk in the queue. How many keys are on that ring?"
        jungleCruise4.correctAnswer = "5"
        jungleCruise4.keyboardType = false
        jungleCruise4.questionInt = 54
        jungleCruise4.resultImage = greyMouse
        jungleCruise4.answerBool = false
        jungleCruise4.land = adventureland
        
        let jungleCruise5 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise5.questionTitle = "Jungle Cruise 5"
        jungleCruise5.theQuestion = "While walking through the queue of The Jungle Cruise you will see a board game that the skippers like to play. What game is it?"
        jungleCruise5.correctAnswer = "Chess"
        jungleCruise5.keyboardType = true
        jungleCruise5.resultImage = greyMouse
        jungleCruise5.answerBool = false
        jungleCruise5.questionInt = 55
        jungleCruise5.land = adventureland
    
        let jungleCruise6 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise6.questionTitle = "Jungle Cruise 6"
        jungleCruise6.theQuestion = "At the top of the stair case in the Jungle Cruise Queue there is a animal sitting on the top rafter. What species of animal is it? (One word)"
        jungleCruise6.correctAnswer = "Bird"
        jungleCruise6.keyboardType = true
        jungleCruise6.resultImage = greyMouse
        jungleCruise6.answerBool = false
        jungleCruise6.questionInt = 56
        jungleCruise6.land = adventureland
        
        let jungleCruise7 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise7.questionTitle = "Jungle Cruise 7"
        jungleCruise7.theQuestion = "While riding the Jungle Cruise, hippos try to charge the boat. What does the skipper use to try to scare off the Hippos? (One word)"
        jungleCruise7.correctAnswer = "Gun"
        jungleCruise7.keyboardType = true
        jungleCruise7.resultImage = greyMouse
        jungleCruise7.answerBool = false
        jungleCruise7.questionInt = 57
        jungleCruise7.land = adventureland
        
        let jungleCruise8 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise8.questionTitle = "Jungle Cruise 8"
        jungleCruise8.theQuestion = "On the dock adjacent to where you load the boats are how many lamp poles?"
        jungleCruise8.correctAnswer = "6"
        jungleCruise8.keyboardType = false
        jungleCruise8.resultImage = greyMouse
        jungleCruise8.answerBool = false
        jungleCruise8.questionInt = 58
        jungleCruise8.land = adventureland
        
        let jungleCruise9 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise9.questionTitle = "Jungle Cruise 9"
        jungleCruise9.theQuestion = "The last person you will see on the Jungle Cruise is a trader standing on the bank of the river. He is known as the \"Head Salesmen of the jungle\". What is the trader's name? (Two Words)"
        jungleCruise9.correctAnswer = "Trader Sam"
        jungleCruise9.keyboardType = true
        jungleCruise9.resultImage = greyMouse
        jungleCruise9.answerBool = false
        jungleCruise9.questionInt = 59
        jungleCruise9.land = adventureland
        
        let jungleCruise10 = Questions(entity: questionDescription!, insertInto: context)
        jungleCruise10.questionTitle = "Jungle Cruise 10"
        jungleCruise10.theQuestion = "On the Jungle Cruise, what do those who drive the boats call themselves?"
        jungleCruise10.correctAnswer = "Skippers"
        jungleCruise10.keyboardType = true
        jungleCruise10.resultImage = greyMouse
        jungleCruise10.answerBool = false
        jungleCruise10.questionInt = 60
        jungleCruise10.land = adventureland
        
        //Indiana Jones (101-150)
    
        let indianaJones1 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones1.questionTitle = "Indiana Jones 1"
        indianaJones1.theQuestion = "In the Indiana Jones Queue there are pillars with snakes carved on them. How many pillars are there?"
        indianaJones1.correctAnswer = "6"
        indianaJones1.keyboardType = false
        indianaJones1.resultImage = greyMouse
        indianaJones1.answerBool = false
        indianaJones1.questionInt = 101
        indianaJones1.land = adventureland
        
        let indianaJones2 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones2.questionTitle = "Indiana Jones 2"
        indianaJones2.theQuestion = "What car company made the truck that sits in the queue for Indiana Jones? (Hyphenated)"
        indianaJones2.correctAnswer = "Mercedes-Benz"
        indianaJones2.keyboardType = true
        indianaJones2.resultImage = greyMouse
        indianaJones2.answerBool = false
        indianaJones2.questionInt = 102
        indianaJones2.land = adventureland
        
        let indianaJones3 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones3.questionTitle = "Indiana Jones 3"
        indianaJones3.theQuestion = "What is the license plate number for the truck sitting in the Indiana Jones queue?"
        indianaJones3.correctAnswer = "WH-11204"
        indianaJones3.keyboardType = true
        indianaJones3.resultImage = greyMouse
        indianaJones3.answerBool = false
        indianaJones3.questionInt = 103
        indianaJones3.land = adventureland
        
        let indianaJones4 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones4.questionTitle = "Indiana Jones 4"
        indianaJones4.theQuestion = "The Diesel truck sitting in the queue for Indiana Jones was part of what archaeological expedition? (Two Words)"
        indianaJones4.correctAnswer = "Lost Delta"
        indianaJones4.keyboardType = true
        indianaJones4.resultImage = greyMouse
        indianaJones4.answerBool = false
        indianaJones4.questionInt = 104
        indianaJones4.land = adventureland
        
        let indianaJones5 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones5.questionTitle = "Indiana Jones 5"
        indianaJones5.theQuestion = "The building surrounding the generator in the queue for Indiana Jones tells you \"Caution _____ ______\""
        indianaJones5.correctAnswer = "High Voltage"
        indianaJones5.keyboardType = true
        indianaJones5.resultImage = greyMouse
        indianaJones5.answerBool = false
        indianaJones5.questionInt = 105
        indianaJones5.land = adventureland
        
        let indianaJones6 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones6.questionTitle = "Indiana Jones 6"
        indianaJones6.theQuestion = "The truck in the Indiana Jones queue has how many tire on it?"
        indianaJones6.correctAnswer = "10"
        indianaJones6.keyboardType = false
        indianaJones6.resultImage = greyMouse
        indianaJones6.answerBool = false
        indianaJones6.questionInt = 106
        indianaJones6.land = adventureland
        
        let indianaJones7 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones7.questionTitle = "Indiana Jones 7"
        indianaJones7.theQuestion = "What kind of animal is carved into the rock outside of the Temple?"
        indianaJones7.correctAnswer = "Snake"
        indianaJones7.keyboardType = true
        indianaJones7.resultImage = greyMouse
        indianaJones7.answerBool = false
        indianaJones7.questionInt = 107
        indianaJones7.land = adventureland
        
        let indianaJones8 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones8.questionTitle = "Indiana Jones 8"
        indianaJones8.theQuestion = "How many lamps are there sitting on the crumbling stairs leading up to the Temple?"
        indianaJones8.correctAnswer = "1"
        indianaJones8.keyboardType = false
        indianaJones8.resultImage = greyMouse
        indianaJones8.answerBool = false
        indianaJones8.questionInt = 108
        indianaJones8.land = adventureland
        
        let indianaJones9 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones9.questionTitle = "Indiana Jones 9"
        indianaJones9.theQuestion = "How many snakes are there carved into the pillars infront of the Temple?"
        indianaJones9.correctAnswer = "4"
        indianaJones9.keyboardType = false
        indianaJones9.resultImage = greyMouse
        indianaJones9.answerBool = false
        indianaJones9.questionInt = 109
        indianaJones9.land = adventureland
        
        let indianaJones10 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones10.questionTitle = "Indiana Jones 10"
        indianaJones10.theQuestion = "While in the outside part of the queue for Indiana Jones who can sometimes here yelling up in the tree tops? "
        indianaJones10.correctAnswer = "Tarzan"
        indianaJones10.keyboardType = true
        indianaJones10.resultImage = greyMouse
        indianaJones10.answerBool = false
        indianaJones10.questionInt = 110
        indianaJones10.land = adventureland
        
        let indianaJones11 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones11.questionTitle = "Indiana Jones 11"
        indianaJones11.theQuestion = "What is the name of the Temple that you enter? (Six Words)"
        indianaJones11.correctAnswer = "The Temple of the Forbidden Eye"
        indianaJones11.keyboardType = true
        indianaJones11.resultImage = greyMouse
        indianaJones11.answerBool = false
        indianaJones11.questionInt = 111
        indianaJones11.land = adventureland
        
        let indianaJones12 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones12.questionTitle = "Indiana Jones 12"
        indianaJones12.theQuestion = "While you are walking through the Indiana Jones Queue, you enter a cave that has a warning on a sign above your head. What species of animal does the sign warn you to not disturb? (singular)"
        indianaJones12.correctAnswer = "Bat"
        indianaJones12.keyboardType = true
        indianaJones12.resultImage = greyMouse
        indianaJones12.answerBool = false
        indianaJones12.questionInt = 112
        indianaJones12.land = adventureland
        
        let indianaJones13 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones13.questionTitle = "Indiana Jones 13"
        indianaJones13.theQuestion = "When in the room where the ceiling falls you will notice some skeletons of people not lucky enough to get out in time. How many skulls can you see in the room?"
        indianaJones13.correctAnswer = "11"
        indianaJones13.keyboardType = false
        indianaJones13.resultImage = greyMouse
        indianaJones13.answerBool = false
        indianaJones13.questionInt = 113
        indianaJones13.land = adventureland
        
        let indianaJones14 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones14.questionTitle = "Indiana Jones 14"
        indianaJones14.theQuestion = "While watching the movie in the Indiana Jones Queue and while riding the ride you are cautioned to avoid the eyes of the god of the temple. What is the name of that god?"
        indianaJones14.correctAnswer = "Mara"
        indianaJones14.keyboardType = true
        indianaJones14.resultImage = greyMouse
        indianaJones14.answerBool = false
        indianaJones14.questionInt = 114
        indianaJones14.land = adventureland
        
        let indianaJones15 = Questions(entity: questionDescription!, insertInto: context)
        indianaJones15.questionTitle = "Indiana Jones 15"
        indianaJones15.theQuestion = "What year did the Indiana Jones attraction open?"
        indianaJones15.correctAnswer = "1995"
        indianaJones15.keyboardType = false
        indianaJones15.resultImage = greyMouse
        indianaJones15.answerBool = false
        indianaJones15.questionInt = 115
        indianaJones15.land = adventureland
        
        // Tarzans Treehouse (151-200)
        
        let tarzansTreehouse1 = Questions(entity: questionDescription!, insertInto: context)
        tarzansTreehouse1.questionTitle = "Tarzan's Treehouse 1"
        tarzansTreehouse1.theQuestion = "While climbing through Tarzan's Tree House you see Jane sitting on a bench drawing on her notepad. Who is she drawing?"
        tarzansTreehouse1.correctAnswer = "Tarzan"
        tarzansTreehouse1.keyboardType = true
        tarzansTreehouse1.resultImage = greyMouse
        tarzansTreehouse1.answerBool = false
        tarzansTreehouse1.questionInt = 151
        tarzansTreehouse1.land = adventureland
        
        let tarzansTreehouse2 = Questions(entity: questionDescription!, insertInto: context)
        tarzansTreehouse2.questionTitle = "Tarzan's Treehouse 2"
        tarzansTreehouse2.theQuestion = "How many stairs are there from the entrance of the Tree House until you reach the Safari Camp below?"
        tarzansTreehouse2.correctAnswer = "129"
        tarzansTreehouse2.keyboardType = false
        tarzansTreehouse2.resultImage = greyMouse
        tarzansTreehouse2.answerBool = false
        tarzansTreehouse2.questionInt = 152
        tarzansTreehouse2.land = adventureland
        
        
        //Misc Adventureland (201-   )
        let attractions = Questions(entity: questionDescription!, insertInto: context)
        attractions.questionTitle = "Attractions"
        attractions.theQuestion = "How many attractions are located in Adventureland?"
        attractions.correctAnswer = "4"
        attractions.keyboardType = false
        attractions.resultImage = greyMouse
        attractions.answerBool = false
        attractions.questionInt = 201
        attractions.land = adventureland
        
        let anExoticStore = Questions(entity: questionDescription!, insertInto: context)
        anExoticStore.questionTitle = "An Exotic Store"
        anExoticStore.theQuestion = "When you enter Adventureland and pass the restrooms you will see an exotic looking store. What is the name of that store? (Two words)"
        anExoticStore.correctAnswer = "Adventureland Bazaar"
        anExoticStore.keyboardType = true
        anExoticStore.resultImage = greyMouse
        anExoticStore.answerBool = false
        anExoticStore.questionInt = 202
        anExoticStore.land = adventureland
        
        let imports = Questions(entity: questionDescription!, insertInto: context)
        imports.questionTitle = "Imports"
        imports.theQuestion = "Right by the Jungle Cruise queue is a small import shack where you can buy fruits and vegetables. What is the name of this import shack?"
        imports.correctAnswer = "Tropical Imports"
        imports.keyboardType = true
        imports.resultImage = greyMouse
        imports.answerBool = false
        imports.questionInt = 203
        imports.land = adventureland
        
        let shishKebabs = Questions(entity: questionDescription!, insertInto: context)
        shishKebabs.questionTitle = "Shish Kebabs"
        shishKebabs.theQuestion = "What is the name of the shish kebab restaurant in Adventureland?"
        shishKebabs.correctAnswer = "Bengal Barbecue"
        shishKebabs.keyboardType = true
        shishKebabs.resultImage = greyMouse
        shishKebabs.answerBool = false
        shishKebabs.questionInt = 204
        shishKebabs.land = adventureland
        
        let flagsFlying = Questions(entity: questionDescription!, insertInto: context)
        flagsFlying.questionTitle = "Flags Flying"
        flagsFlying.theQuestion = "There are two noticeable flags flying in Adventureland. One from the boat in the tree at Tarzan's Tree house, and one atop of the Jungle Cruise building. What nation flies this flag?"
        flagsFlying.correctAnswer = "England"
        flagsFlying.keyboardType = true
        flagsFlying.resultImage = greyMouse
        flagsFlying.answerBool = false
        flagsFlying.questionInt = 205
        flagsFlying.land = adventureland

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//New Orleans Square!!
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let newOrleansSquare = Land(entity: landDescription!, insertInto: context)
        
        newOrleansSquare.landName = "New Orleans Square"
        newOrleansSquare.artWorkForLand = "HauntedMansion.jpg"
        
        // Haunted Mansion (1-50)
        
        let hauntedMansion1 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion1.questionTitle = "Haunted Mansion 1"
        hauntedMansion1.theQuestion = "Atop the Haunted Mansion sits a weathervane. What is this weathervane in the shape of? (One Word)"
        hauntedMansion1.correctAnswer = "Boat"
        hauntedMansion1.keyboardType = true
        hauntedMansion1.resultImage = greyMouse
        hauntedMansion1.answerBool = false
        hauntedMansion1.questionInt = 1
        hauntedMansion1.land = newOrleansSquare
        
        let hauntedMansion2 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion2.questionTitle = "Haunted Mansion 2"
        hauntedMansion2.theQuestion = "When you enter the Haunted Mansion Queue you will notice on your left a small stone pillar in the grass. This stone pillar uses the sun to tell time. What is the name of this sort of device. (Two Words)"
        hauntedMansion2.correctAnswer = "Sun dial"
        hauntedMansion2.keyboardType = true
        hauntedMansion2.resultImage = greyMouse
        hauntedMansion2.answerBool = false
        hauntedMansion2.questionInt = 2
        hauntedMansion2.land = newOrleansSquare
        
        let hauntedMansion3 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion3.questionTitle = "Haunted Mansion 3"
        hauntedMansion3.theQuestion = "In the first room you enter when in the Mansion, prior to the stretching room, you will notice a large candle chandelier hanging in the center of the room. How many candles are on the chandelier?"
        hauntedMansion3.correctAnswer = "36"
        hauntedMansion3.keyboardType = false
        hauntedMansion3.resultImage = greyMouse
        hauntedMansion3.answerBool = false
        hauntedMansion3.questionInt = 3
        hauntedMansion3.land = newOrleansSquare
        
        let hauntedMansion4 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion4.questionTitle = "Haunted Mansion 4"
        hauntedMansion4.theQuestion = "In the stretching room of the Haunted Mansion how many portraits are there?"
        hauntedMansion4.correctAnswer = "4"
        hauntedMansion4.keyboardType = false
        hauntedMansion4.resultImage = greyMouse
        hauntedMansion4.answerBool = false
        hauntedMansion4.questionInt = 4
        hauntedMansion4.land = newOrleansSquare
        
        let hauntedMansion5 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion5.questionTitle = "Haunted Mansion 5"
        hauntedMansion5.theQuestion = "There are many gargoyles resting under the paintings in the stretching room. How many gargoyles are there total?"
        hauntedMansion5.correctAnswer = "8"
        hauntedMansion5.keyboardType = false
        hauntedMansion5.resultImage = greyMouse
        hauntedMansion5.answerBool = false
        hauntedMansion5.questionInt = 5
        hauntedMansion5.land = newOrleansSquare
        
        let hauntedMansion6 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion6.questionTitle = "Haunted Mansion 6"
        hauntedMansion6.theQuestion = "Each of the gargoyles in the stretching room are holding candles. How many candles does one gargoyle hold?"
        hauntedMansion6.correctAnswer = "2"
        hauntedMansion6.keyboardType = false
        hauntedMansion6.resultImage = greyMouse
        hauntedMansion6.answerBool = false
        hauntedMansion6.questionInt = 6
        hauntedMansion6.land = newOrleansSquare
        
        let hauntedMansion7 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion7.questionTitle = "Haunted Mansion 7"
        hauntedMansion7.theQuestion = "Finish this quote from the Ghost Host, \"This chamber has no windows and no _______\"."
        hauntedMansion7.correctAnswer = "doors"
        hauntedMansion7.keyboardType = true
        hauntedMansion7.resultImage = greyMouse
        hauntedMansion7.answerBool = false
        hauntedMansion7.questionInt = 7
        hauntedMansion7.land = newOrleansSquare
        
        let hauntedMansion8 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion8.questionTitle = "Haunted Mansion 8"
        hauntedMansion8.theQuestion = "As you exit the stretching room you will notice some paintings to your right that seem to change. How many changing painting are there on the wall?"
        hauntedMansion8.correctAnswer = "5"
        hauntedMansion8.keyboardType = false
        hauntedMansion8.resultImage = greyMouse
        hauntedMansion8.answerBool = false
        hauntedMansion8.questionInt = 8
        hauntedMansion8.land = newOrleansSquare
        
        let hauntedMansion9 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion9.questionTitle = "Haunted Mansion 9"
        hauntedMansion9.theQuestion = "The last painting on the wall depicts a beautiful woman that changes into what Greek mythological monster?"
        hauntedMansion9.correctAnswer = "Medusa"
        hauntedMansion9.keyboardType = true
        hauntedMansion9.resultImage = greyMouse
        hauntedMansion9.answerBool = false
        hauntedMansion9.questionInt = 9
        hauntedMansion9.land = newOrleansSquare
        
        let hauntedMansion10 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion10.questionTitle = "Haunted Mansion 10"
        hauntedMansion10.theQuestion = "How many \"Happy Haunts\" call the Haunted Mansion home?"
        hauntedMansion10.correctAnswer = "999"
        hauntedMansion10.keyboardType = false
        hauntedMansion10.resultImage = greyMouse
        hauntedMansion10.answerBool = false
        hauntedMansion10.questionInt = 10
        hauntedMansion10.land = newOrleansSquare
        
        let hauntedMansion11 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion11.questionTitle = "Haunted Mansion 11"
        hauntedMansion11.theQuestion = "After you exit the stretching room in the Haunted Mansion there are statues on the wall directly in front of you who's eyes seem to follow you. How many statues are there?"
        hauntedMansion11.correctAnswer = "2"
        hauntedMansion11.keyboardType = false
        hauntedMansion11.resultImage = greyMouse
        hauntedMansion11.answerBool = false
        hauntedMansion11.questionInt = 11
        hauntedMansion11.land = newOrleansSquare
        
        let hauntedMansion12 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion12.questionTitle = "Haunted Mansion 12"
        hauntedMansion12.theQuestion = "One of the statue heads that seem to follow you is wearing a tie. What type of tie is he wearing? (Two Words)"
        hauntedMansion12.correctAnswer = "Bow Tie"
        hauntedMansion12.keyboardType = true
        hauntedMansion12.resultImage = greyMouse
        hauntedMansion12.answerBool = false
        hauntedMansion12.questionInt = 12
        hauntedMansion12.land = newOrleansSquare
        
        let hauntedMansion13 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion13.questionTitle = "Haunted Mansion 13"
        hauntedMansion13.theQuestion = "On the Haunted Mansion you ride in some special vehicles. What does the \"Ghost Host\" call these cars (One Word, Plural)?"
        hauntedMansion13.correctAnswer = "Doombuggies"
        hauntedMansion13.keyboardType = true
        hauntedMansion13.resultImage = greyMouse
        hauntedMansion13.answerBool = false
        hauntedMansion13.questionInt = 13
        hauntedMansion13.land = newOrleansSquare
        
        let hauntedMansion14 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion14.questionTitle = "Haunted Mansion 14"
        hauntedMansion14.theQuestion = "For many years this famous haunt has been hiding in the Haunted Mansion. He has just returned and is making his appearance just outside of the attic scene. What is the name of this ghost? ( Three Words)"
        hauntedMansion14.correctAnswer = "The hatbox Ghost"
        hauntedMansion14.keyboardType = true
        hauntedMansion14.resultImage = greyMouse
        hauntedMansion14.answerBool = false
        hauntedMansion14.questionInt = 14
        hauntedMansion14.land = newOrleansSquare
        
        let hauntedMansion15 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion15.questionTitle = "Haunted Mansion 15"
        hauntedMansion15.theQuestion = "Near the end of the Haunted Mansion ride you encounter a few \"Hitch-Hiking Ghosts\" who you are told \"will follow you home\". How many of these of these ghosts do you see?"
        hauntedMansion15.correctAnswer = "3"
        hauntedMansion15.keyboardType = false
        hauntedMansion15.resultImage = greyMouse
        hauntedMansion15.answerBool = false
        hauntedMansion15.questionInt = 15
        hauntedMansion15.land = newOrleansSquare
        
        let hauntedMansion16 = Questions(entity: questionDescription!, insertInto: context)
        hauntedMansion16.questionTitle = "Haunted Mansion 16"
        hauntedMansion16.theQuestion = "What famous ghost rematerialized in the Haunted Mansion in 2015? (Three Words)"
        hauntedMansion16.correctAnswer = "The Hatbox Ghost"
        hauntedMansion16.keyboardType = true
        hauntedMansion16.resultImage = greyMouse
        hauntedMansion16.answerBool = false
        hauntedMansion16.questionInt = 16
        hauntedMansion16.land = newOrleansSquare
        
        // Pirates of the Carribean (51-100)
        
        let poc1 = Questions(entity: questionDescription!, insertInto: context)
        poc1.questionTitle = "Pirates of the Caribbean 1"
        poc1.theQuestion = "Above the Pirates of the Caribbean attraction is a special suite. What is the name of this suite? (Two Words)"
        poc1.correctAnswer = "Dream Suite"
        poc1.keyboardType = true
        poc1.resultImage = greyMouse
        poc1.answerBool = false
        poc1.questionInt = 51
        poc1.land = newOrleansSquare
        
        let poc2 = Questions(entity: questionDescription!, insertInto: context)
        poc2.questionTitle = "Pirates of the Caribbean 2"
        poc2.theQuestion = "Can you see Piates Lair on Tom Sawyer Island from the Pirates of the Caribbean queue?"
        poc2.correctAnswer = "Yes"
        poc2.keyboardType = true
        poc2.resultImage = greyMouse
        poc2.answerBool = false
        poc2.questionInt = 52
        poc2.land = newOrleansSquare
        
        let poc3 = Questions(entity: questionDescription!, insertInto: context)
        poc3.questionTitle = "Pirates of the Caribbean 3"
        poc3.theQuestion = "Right as you enter the Pirates of the Caribbean attraction you will see, on your left, a painting of a famous pirate. Who is this pirate? (Three Words)"
        poc3.correctAnswer = "Captain Jack Sparrow"
        poc3.keyboardType = true
        poc3.resultImage = greyMouse
        poc3.answerBool = false
        poc3.questionInt = 53
        poc3.land = newOrleansSquare
        
        let poc4 = Questions(entity: questionDescription!, insertInto: context)
        poc4.questionTitle = "Pirates of the Caribbean 4"
        poc4.theQuestion = "Right as you enter the Pirates of the Caribbean attraction you will see a bird standing on a shovel talking. What type of bird is it?"
        poc4.correctAnswer = "Parrot"
        poc4.keyboardType = true
        poc4.resultImage = greyMouse
        poc4.answerBool = false
        poc4.questionInt = 54
        poc4.land = newOrleansSquare
        
        let poc5 = Questions(entity: questionDescription!, insertInto: context)
        poc5.questionTitle = "Pirates of the Caribbean 5"
        poc5.theQuestion = "The bird on the shovel has feathers that are mainly two colors, blue and ______."
        poc5.correctAnswer = "yellow"
        poc5.keyboardType = true
        poc5.resultImage = greyMouse
        poc5.answerBool = false
        poc5.questionInt = 55
        poc5.land = newOrleansSquare
        
        let poc6 = Questions(entity: questionDescription!, insertInto: context)
        poc6.questionTitle = "Pirates of the Caribbean 6"
        poc6.theQuestion = "Above where you board the boats for Pirates of the Caribbean there is a sign. What does the sign say?"
        poc6.correctAnswer = "Laffite's Landing"
        poc6.keyboardType = true
        poc6.resultImage = greyMouse
        poc6.answerBool = false
        poc6.questionInt = 56
        poc6.land = newOrleansSquare
        
        let poc7 = Questions(entity: questionDescription!, insertInto: context)
        poc7.questionTitle = "Pirates of the Caribbean 7"
        poc7.theQuestion = "What is the name of the restaurant you float by while on Pirates of the Caribbean? (Three Words)"
        poc7.correctAnswer = "The Blue Bayou"
        poc7.keyboardType = true
        poc7.resultImage = greyMouse
        poc7.answerBool = false
        poc7.questionInt = 57
        poc7.land = newOrleansSquare
        
        let poc8 = Questions(entity: questionDescription!, insertInto: context)
        poc8.questionTitle = "Pirates of the Caribbean 8"
        poc8.theQuestion = "How many rows of seats are there on the boats for Pirates of the Caribbean?"
        poc8.correctAnswer = "6"
        poc8.keyboardType = false
        poc8.resultImage = greyMouse
        poc8.answerBool = false
        poc8.questionInt = 58
        poc8.land = newOrleansSquare
        
        let poc9 = Questions(entity: questionDescription!, insertInto: context)
        poc9.questionTitle = "Pirates of the Caribbean 9"
        poc9.theQuestion = "In the begining swamp scene of Pirates of the Caribbean there is a old man sitting on a rocking chair on a porch. Is he playing a banjo?"
        poc9.correctAnswer = "No"
        poc9.keyboardType = true
        poc9.resultImage = greyMouse
        poc9.answerBool = false
        poc9.questionInt = 59
        poc9.land = newOrleansSquare
        
        let poc10 = Questions(entity: questionDescription!, insertInto: context)
        poc10.questionTitle = "Pirates of the Caribbean 10"
        poc10.theQuestion = "How many drops do you experience when you are riding Pirates of the Caribbean?"
        poc10.correctAnswer = "2"
        poc10.keyboardType = false
        poc10.resultImage = greyMouse
        poc10.answerBool = false
        poc10.questionInt = 60
        poc10.land = newOrleansSquare
        
        let poc11 = Questions(entity: questionDescription!, insertInto: context)
        poc11.questionTitle = "Pirates of the Caribbean 11"
        poc11.theQuestion = "You float by a tavern with some skeletons in it. How many skeletons are in the tavern?"
        poc11.correctAnswer = "4"
        poc11.keyboardType = false
        poc11.resultImage = greyMouse
        poc11.answerBool = false
        poc11.questionInt = 61
        poc11.land = newOrleansSquare
        
        let poc12 = Questions(entity: questionDescription!, insertInto: context)
        poc12.questionTitle = "Pirates of the Caribbean 12"
        poc12.theQuestion = "On Pirates of the Caribbean the swashbuckling pirates are dunking a peasant in a well. The peasant's wife screams from the window \"Don't do it ______, don't be chicken!\" Fill in the blank."
        poc12.correctAnswer = "Carlos"
        poc12.keyboardType = true
        poc12.resultImage = greyMouse
        poc12.answerBool = false
        poc12.questionInt = 62
        poc12.land = newOrleansSquare
        
        let poc13 = Questions(entity: questionDescription!, insertInto: context)
        poc13.questionTitle = "Pirates of the Caribbean 13"
        poc13.theQuestion = "While riding Pirates of the Caribbean you see an auction happening. Who do the drunken pirates shout that they want during this auction? (Three Words)"
        poc13.correctAnswer = "the red head"
        poc13.keyboardType = true
        poc13.resultImage = greyMouse
        poc13.answerBool = false
        poc13.questionInt = 63
        poc13.land = newOrleansSquare
        
        let poc14 = Questions(entity: questionDescription!, insertInto: context)
        poc14.questionTitle = "Pirates of the Caribbean 14"
        poc14.theQuestion = "In one of the last scenes of the Pirates of the Caribbean ride you will see some men in prison cells, some are begging a dog for the key. How many men are alive in the cells?"
        poc14.correctAnswer = "6"
        poc14.keyboardType = false
        poc14.resultImage = greyMouse
        poc14.answerBool = false
        poc14.questionInt = 64
        poc14.land = newOrleansSquare
        
        let poc15 = Questions(entity: questionDescription!, insertInto: context)
        poc15.questionTitle = "Pirates of the Caribbean 15"
        poc15.theQuestion = "How many times do you see Captain Jack Sparrow in the attraction?"
        poc15.correctAnswer = "3"
        poc15.keyboardType = false
        poc15.resultImage = greyMouse
        poc15.answerBool = false
        poc15.questionInt = 65
        poc15.land = newOrleansSquare
        
        let poc16 = Questions(entity: questionDescription!, insertInto: context)
        poc16.questionTitle = "Pirates of the Caribbean 16"
        poc16.theQuestion = "As you exit Pirates of the Caribbean you pass a gift shop on your right. What is the name of that gift shop?"
        poc16.correctAnswer = "Pieces of Eight"
        poc16.keyboardType = true
        poc16.resultImage = greyMouse
        poc16.answerBool = false
        poc16.questionInt = 66
        poc16.land = newOrleansSquare
        
        
        //New Orleans Square Train Station (101-150)
        let nosTrainStation1 = Questions(entity: questionDescription!, insertInto: context)
        nosTrainStation1.questionTitle = "Train Station 1"
        nosTrainStation1.theQuestion = "What number of stop is New Orleans Square train station in the Grand Circle Tour?"
        nosTrainStation1.correctAnswer = "2"
        nosTrainStation1.keyboardType = false
        nosTrainStation1.resultImage = greyMouse
        nosTrainStation1.answerBool = false
        nosTrainStation1.questionInt = 101
        nosTrainStation1.land = newOrleansSquare
        
        let nosTrainStation2 = Questions(entity: questionDescription!, insertInto: context)
        nosTrainStation2.questionTitle = "Train Station 2"
        nosTrainStation2.theQuestion = "The New Orleans Square Train Station shares its station with another land. What land does it share with?"
        nosTrainStation2.correctAnswer = "Frontierland"
        nosTrainStation2.keyboardType = true
        nosTrainStation2.resultImage = greyMouse
        nosTrainStation2.answerBool = false
        nosTrainStation2.questionInt = 102
        nosTrainStation2.land = newOrleansSquare
        
        let nosTrainStation3 = Questions(entity: questionDescription!, insertInto: context)
        nosTrainStation3.questionTitle = "Train Station 3"
        nosTrainStation3.theQuestion = "While waiting for the train at the New Orleans Square Station you will hear a ticking noise. What is the name of the machine that makes this ticking noise?"
        nosTrainStation3.correctAnswer = "Telegraph"
        nosTrainStation3.keyboardType = true
        nosTrainStation3.resultImage = greyMouse
        nosTrainStation3.answerBool = false
        nosTrainStation3.questionInt = 103
        nosTrainStation3.land = newOrleansSquare
        
        let nosTrainStation4 = Questions(entity: questionDescription!, insertInto: context)
        nosTrainStation4.questionTitle = "Train Station 4"
        nosTrainStation4.theQuestion = "According a the sign at the station, how many feet in elevation is New Orleans Square?"
        nosTrainStation4.correctAnswer = "144"
        nosTrainStation4.keyboardType = false
        nosTrainStation4.resultImage = greyMouse
        nosTrainStation4.answerBool = false
        nosTrainStation4.questionInt = 104
        nosTrainStation4.land = newOrleansSquare
        
        //New Orleans Square Shops (151-200)
        let noss1 = Questions(entity: questionDescription!, insertInto: context)
        noss1.questionTitle = "New Orleans Square Shops 1"
        noss1.theQuestion = "What is the street address of \"Le Bat en Rouge\"?"
        noss1.correctAnswer = "35"
        noss1.keyboardType = false
        noss1.resultImage = greyMouse
        noss1.answerBool = false
        noss1.questionInt = 151
        noss1.land = newOrleansSquare
        
        // Misc New Orleans Square (201-250)
        let jazzBand = Questions(entity: questionDescription!, insertInto: context)
        jazzBand.questionTitle = "Jazz Band"
        jazzBand.theQuestion = "On select days a Jazz Band plays on a stage in a restaurant in New Orleans Square. What is the name of the restaurant that the Jazz Band plays in?"
        jazzBand.correctAnswer = "French Market"
        jazzBand.keyboardType = true
        jazzBand.resultImage = greyMouse
        jazzBand.answerBool = false
        jazzBand.questionInt = 201
        jazzBand.land = newOrleansSquare
        
        let privateClub = Questions(entity: questionDescription!, insertInto: context)
        privateClub.questionTitle = "Private Club"
        privateClub.theQuestion = "In New Orleans Square there is a private club. What is the name of that club?"
        privateClub.correctAnswer = "Club 33"
        privateClub.keyboardType = true
        privateClub.resultImage = greyMouse
        privateClub.answerBool = false
        privateClub.questionInt = 202
        privateClub.land = newOrleansSquare
        
        let attractionsNOS = Questions(entity: questionDescription!, insertInto: context)
        attractionsNOS.questionTitle = "Attractions"
        attractionsNOS.theQuestion = "How many different attractions are housed in New Orleans Square?"
        attractionsNOS.correctAnswer = "4"
        attractionsNOS.keyboardType = false
        attractionsNOS.resultImage = greyMouse
        attractionsNOS.answerBool = false
        attractionsNOS.questionInt = 203
        attractionsNOS.land = newOrleansSquare
        //Check Answer
        
        // New Orleans Square Food (251-300)
        let nosFood1 = Questions(entity: questionDescription!, insertInto: context)
        nosFood1.questionTitle = "Food 1"
        nosFood1.theQuestion = "At the New Orleans Square Mint Julep Bar the Mint Julep is described on the menu as a refreshing mint drink with a hint of ____ flavor."
        nosFood1.correctAnswer = "lime"
        nosFood1.keyboardType = true
        nosFood1.resultImage = greyMouse
        nosFood1.answerBool = false
        nosFood1.questionInt = 251
        nosFood1.land = newOrleansSquare
        
        let nosFood2 = Questions(entity: questionDescription!, insertInto: context)
        nosFood2.questionTitle = "Food 2"
        nosFood2.theQuestion = "The Mint Julep Bar serves beignets in the shape of whose head?"
        nosFood2.correctAnswer = "Mickey"
        nosFood2.keyboardType = true
        nosFood2.resultImage = greyMouse
        nosFood2.answerBool = false
        nosFood2.questionInt = 252
        nosFood2.land = newOrleansSquare
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//Fantasyland!!!!!
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let fantasyland = Land(entity: landDescription!, insertInto: context)
        
        fantasyland.landName = "Fantasyland"
        fantasyland.artWorkForLand = "FantasylandTower.jpg"

        
        //The Mad Tea Party (1-50)
        let madTeaParty1 = Questions(entity: questionDescription!, insertInto: context)
        madTeaParty1.questionTitle = "The Mad Tea Party 1"
        madTeaParty1.theQuestion = "How different tea cups can you pick from to spin on while riding The Mad Tea Party?"
        madTeaParty1.correctAnswer = "18"
        madTeaParty1.keyboardType = false
        madTeaParty1.resultImage = greyMouse
        madTeaParty1.answerBool = false
        madTeaParty1.questionInt = 1
        madTeaParty1.land = fantasyland
        
        let madTeaParty2 = Questions(entity: questionDescription!, insertInto: context)
        madTeaParty2.questionTitle = "The Mad Tea Party 2"
        madTeaParty2.theQuestion = "How many different color tea cups are there? (Color, Not Design)"
        madTeaParty2.correctAnswer = "7"
        madTeaParty2.keyboardType = false
        madTeaParty2.resultImage = greyMouse
        madTeaParty2.answerBool = false
        madTeaParty2.questionInt = 2
        madTeaParty2.land = fantasyland
        
        let madTeaParty3 = Questions(entity: questionDescription!, insertInto: context)
        madTeaParty3.questionTitle = "The Mad Tea Party 3"
        madTeaParty3.theQuestion = "The wheel in the center of your tea cup tells you to spin it in what direction?"
        madTeaParty3.correctAnswer = "clockwise"
        madTeaParty3.keyboardType = true
        madTeaParty3.resultImage = greyMouse
        madTeaParty3.answerBool = false
        madTeaParty3.questionInt = 3
        madTeaParty3.land = fantasyland
        
        //Alice in Wonderland (51-100)
        let alice1 = Questions(entity: questionDescription!, insertInto: context)
        alice1.questionTitle = "Alice in Wonderland 1"
        alice1.theQuestion = "What character is giving the safety spiel for Alice in Wonderland?"
        alice1.correctAnswer = "Alice"
        alice1.keyboardType = true
        alice1.resultImage = greyMouse
        alice1.answerBool = false
        alice1.questionInt = 51
        alice1.land = fantasyland
        
        let alice2 = Questions(entity: questionDescription!, insertInto: context)
        alice2.questionTitle = "Alice in Wonderland 2"
        alice2.theQuestion = "When riding the Alice in Wonderland ride, the cars you sit in resemble a _______________."
        alice2.correctAnswer = "Caterpillar"
        alice2.keyboardType = true
        alice2.resultImage = greyMouse
        alice2.answerBool = false
        alice2.questionInt = 52
        alice2.land = fantasyland
        
        let alice3 = Questions(entity: questionDescription!, insertInto: context)
        alice3.questionTitle = "Alice in Wonderland 3"
        alice3.theQuestion = "When riding the Alice in Wonderland ride you begin by taking a journey down the _________________."
        alice3.correctAnswer = "Rabbit Hole"
        alice3.keyboardType = true
        alice3.resultImage = greyMouse
        alice3.answerBool = false
        alice3.questionInt = 53
        alice3.land = fantasyland
        
        let alice4 = Questions(entity: questionDescription!, insertInto: context)
        alice4.questionTitle = "Alice in Wonderland 4"
        alice4.theQuestion = "At the beginning of the Alice in Wonderland ride, how many times does Alice say down?"
        alice4.correctAnswer = "3"
        alice4.keyboardType = false
        alice4.resultImage = greyMouse
        alice4.answerBool = false
        alice4.questionInt = 54
        alice4.land = fantasyland
        
        //Snow Whites Scary Adventure (101-150)
        
        let snowWhite1 = Questions(entity: questionDescription!, insertInto: context)
        snowWhite1.questionTitle = "Snow White 1"
        snowWhite1.theQuestion = "If you look up before entering the Snow White ride you can see the Evil Queen peering out of a _____________."
        snowWhite1.correctAnswer = "Window"
        snowWhite1.keyboardType = true
        snowWhite1.resultImage = greyMouse
        snowWhite1.answerBool = false
        snowWhite1.questionInt = 101
        snowWhite1.land = fantasyland
        
        let snowWhite2 = Questions(entity: questionDescription!, insertInto: context)
        snowWhite2.questionTitle = "Snow White 2"
        snowWhite2.theQuestion = "When entering the queue for Snow White's Scary Adventures, there is a brass ______________ that when touched will trigger the sound of the evil queen's cackle"
        snowWhite2.correctAnswer = "Apple"
        snowWhite2.keyboardType = true
        snowWhite2.resultImage = greyMouse
        snowWhite2.answerBool = false
        snowWhite2.questionInt = 102
        snowWhite2.land = fantasyland
        
        let snowWhite3 = Questions(entity: questionDescription!, insertInto: context)
        snowWhite3.questionTitle = "Snow White 3"
        snowWhite3.theQuestion = "How many windows can you see on the Dwarf's House while standing in line?"
        snowWhite3.correctAnswer = "4"
        snowWhite3.keyboardType = false
        snowWhite3.resultImage = greyMouse
        snowWhite3.answerBool = false
        snowWhite3.questionInt = 103
        snowWhite3.land = fantasyland
        
        let snowWhite4 = Questions(entity: questionDescription!, insertInto: context)
        snowWhite4.questionTitle = "Snow White 4"
        snowWhite4.theQuestion = "Each of the ride vehicles have their own name on this attraction. How many different names are there?"
        snowWhite4.correctAnswer = "7"
        snowWhite4.keyboardType = false
        snowWhite4.resultImage = greyMouse
        snowWhite4.answerBool = false
        snowWhite4.questionInt = 104
        snowWhite4.land = fantasyland
        
        let snowWhite5 = Questions(entity: questionDescription!, insertInto: context)
        snowWhite5.questionTitle = "Snow White 5"
        snowWhite5.theQuestion = "While standing in line for \"Snow White's Scary Adventure\" can you see \"The Mad Tea Party\"? (Yes or No)"
        snowWhite5.correctAnswer = "No"
        snowWhite5.keyboardType = true
        snowWhite5.resultImage = greyMouse
        snowWhite5.answerBool = false
        snowWhite5.questionInt = 105
        snowWhite5.land = fantasyland
        
        //Dumbo (151-200)
        let dumbo1 = Questions(entity: questionDescription!, insertInto: context)
        dumbo1.questionTitle = "Dumbo 1"
        dumbo1.theQuestion = "What is the full name of the flying elephant ride in Fantasyland? (4 words)"
        dumbo1.correctAnswer = "Dumbo the Flying Elephant"
        dumbo1.keyboardType = true
        dumbo1.resultImage = greyMouse
        dumbo1.answerBool = false
        dumbo1.questionInt = 151
        dumbo1.land = fantasyland
        
        //Its a Small World (201-250)
        
        let smallWorld1 = Questions(entity: questionDescription!, insertInto: context)
        smallWorld1.questionTitle = "It's a Small World 1"
        smallWorld1.theQuestion = "How many children are represented on the sign of It's a Small World?"
        smallWorld1.correctAnswer = "14"
        smallWorld1.keyboardType = false
        smallWorld1.resultImage = greyMouse
        smallWorld1.answerBool = false
        smallWorld1.questionInt = 201
        smallWorld1.land = fantasyland
        
        let smallWorld2 = Questions(entity: questionDescription!, insertInto: context)
        smallWorld2.questionTitle = "It's a Small World 2"
        smallWorld2.theQuestion = "What company \"Presents\" It's a Small World?"
        smallWorld2.correctAnswer = "Siemens"
        smallWorld2.keyboardType = true
        smallWorld2.resultImage = greyMouse
        smallWorld2.answerBool = false
        smallWorld2.questionInt = 202
        smallWorld2.land = fantasyland
        
        let smallWorld3 = Questions(entity: questionDescription!, insertInto: context)
        smallWorld3.questionTitle = "It's a Small World 3"
        smallWorld3.theQuestion = "When looking at the clock face of the Small World ride there is a list of numbers on the right hand side.  What is the uppermost number?"
        smallWorld3.correctAnswer = "2"
        smallWorld3.keyboardType = false
        smallWorld3.resultImage = greyMouse
        smallWorld3.answerBool = false
        smallWorld3.questionInt = 203
        smallWorld3.land = fantasyland
        
        let smallWorld4 = Questions(entity: questionDescription!, insertInto: context)
        smallWorld4.questionTitle = "It's a Small World 4"
        smallWorld4.theQuestion = "When entering the African continent on your journey through It's A Small World, there are children swinging on the elephant's trunk.  What color is the elephant?"
        smallWorld4.correctAnswer = "Pink"
        smallWorld4.keyboardType = true
        smallWorld4.resultImage = greyMouse
        smallWorld4.answerBool = false
        smallWorld4.questionInt = 204
        smallWorld4.land = fantasyland
        
        let smallWorld5 = Questions(entity: questionDescription!, insertInto: context)
        smallWorld5.questionTitle = "It's a Small World 5"
        smallWorld5.theQuestion = "In the final area you pass through on the Small World ride, all of the dolls are now dressed in what color?"
        smallWorld5.correctAnswer = "White"
        smallWorld5.keyboardType = true
        smallWorld5.resultImage = greyMouse
        smallWorld5.answerBool = false
        smallWorld5.questionInt = 205
        smallWorld5.land = fantasyland
        
        let smallWorld6 = Questions(entity: questionDescription!, insertInto: context)
        smallWorld6.questionTitle = "It's a Small World 6"
        smallWorld6.theQuestion = "How many different \"Mountain\" attractions can you see from the Queue?"
        smallWorld6.correctAnswer = "1"
        smallWorld6.keyboardType = false
        smallWorld6.resultImage = greyMouse
        smallWorld6.answerBool = false
        smallWorld6.questionInt = 206
        smallWorld6.land = fantasyland
        
        //Pinocchio (251-300)
        let pinocchio1 = Questions(entity: questionDescription!, insertInto: context)
        pinocchio1.questionTitle = "Pinocchio 1"
        pinocchio1.theQuestion = "Before entering the queue for Pinocchio's Daring Journey, if you look up you will see Pinocchio.  In the scene drawn behind him, what farm animal do you see? (1 word)"
        pinocchio1.correctAnswer = "Cow"
        pinocchio1.keyboardType = true
        pinocchio1.resultImage = greyMouse
        pinocchio1.answerBool = false
        pinocchio1.questionInt = 251
        pinocchio1.land = fantasyland
        
        let pinocchio2 = Questions(entity: questionDescription!, insertInto: context)
        pinocchio2.questionTitle = "Pinocchio 2"
        pinocchio2.theQuestion = "While standing in line for Pinocchio you will see Jiminy Cricket painted on the wall holding an umbrella. What color is the umbrella he is holding?"
        pinocchio2.correctAnswer = "red"
        pinocchio2.keyboardType = true
        pinocchio2.resultImage = greyMouse
        pinocchio2.answerBool = false
        pinocchio2.questionInt = 252
        pinocchio2.land = fantasyland
        
        let pinocchio3 = Questions(entity: questionDescription!, insertInto: context)
        pinocchio3.questionTitle = "Pinocchio 3"
        pinocchio3.theQuestion = "While standing in line for Pinocchio you will see Pinocchio painted on the wall holding a red ________ in his hand. What is he holding? (One Word)"
        pinocchio3.correctAnswer = "apple"
        pinocchio3.keyboardType = true
        pinocchio3.resultImage = greyMouse
        pinocchio3.answerBool = false
        pinocchio3.questionInt = 253
        pinocchio3.land = fantasyland
        
        let pinocchio4 = Questions(entity: questionDescription!, insertInto: context)
        pinocchio4.questionTitle = "Pinocchio 4"
        pinocchio4.theQuestion = "Above pinocchio in the painting is a street sign. How many different directions are listed on the sign?"
        pinocchio4.correctAnswer = "3"
        pinocchio4.keyboardType = false
        pinocchio4.resultImage = greyMouse
        pinocchio4.answerBool = false
        pinocchio4.questionInt = 254
        pinocchio4.land = fantasyland
        
        let pinocchio5 = Questions(entity: questionDescription!, insertInto: context)
        pinocchio5.questionTitle = "Pinocchio 5"
        pinocchio5.theQuestion = "How many puppets, including pinocchio, are in cages while on the ride? "
        pinocchio5.correctAnswer = "3"
        pinocchio5.keyboardType = false
        pinocchio5.resultImage = greyMouse
        pinocchio5.answerBool = false
        pinocchio5.questionInt = 255
        pinocchio5.land = fantasyland
        
        let pinocchio6 = Questions(entity: questionDescription!, insertInto: context)
        pinocchio6.questionTitle = "Pinocchio 6"
        pinocchio6.theQuestion = "When riding Pinocchio's Daring Journey you see a carousel.  It is named ____________ Carousel."
        pinocchio6.correctAnswer = "Candy"
        pinocchio6.keyboardType = true
        pinocchio6.resultImage = greyMouse
        pinocchio6.answerBool = false
        pinocchio6.questionInt = 256
        pinocchio6.land = fantasyland
        
        let pinocchio7 = Questions(entity: questionDescription!, insertInto: context)
        pinocchio7.questionTitle = "Pinocchio 7"
        pinocchio7.theQuestion = "When riding the Pinocchio ride, in the Pleasure Island sequence you ride past _____________ row."
        pinocchio7.correctAnswer = "Tobacco"
        pinocchio7.keyboardType = true
        pinocchio7.resultImage = greyMouse
        pinocchio7.answerBool = false
        pinocchio7.questionInt = 257
        pinocchio7.land = fantasyland
        
        //Peter Pans Flight (301-350)
        let peterPansFlight1 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight1.questionTitle = "Peter Pans Flight 1"
        peterPansFlight1.theQuestion = "While waiting in line you will see a mural of London. The clock shows approximately __:15."
        peterPansFlight1.correctAnswer = "7"
        peterPansFlight1.keyboardType = false
        peterPansFlight1.resultImage = greyMouse
        peterPansFlight1.answerBool = false
        peterPansFlight1.questionInt = 301
        peterPansFlight1.land = fantasyland
        
        let peterPansFlight2 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight2.questionTitle = "Peter Pans Flight 2"
        peterPansFlight2.theQuestion = "What type of ship do you fly in on Peter Pan? (1 Word)"
        peterPansFlight2.correctAnswer = "Pirate"
        peterPansFlight2.keyboardType = true
        peterPansFlight2.resultImage = greyMouse
        peterPansFlight2.answerBool = false
        peterPansFlight2.questionInt = 302
        peterPansFlight2.land = fantasyland
        
        let peterPansFlight3 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight3.questionTitle = "Peter Pans Flight 3"
        peterPansFlight3.theQuestion = "How many different color sails are on the Pirate Ships?"
        peterPansFlight3.correctAnswer = "4"
        peterPansFlight3.keyboardType = false
        peterPansFlight3.resultImage = greyMouse
        peterPansFlight3.answerBool = false
        peterPansFlight3.questionInt = 303
        peterPansFlight3.land = fantasyland
        
        let peterPansFlight4 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight4.questionTitle = "Peter Pans Flight 4"
        peterPansFlight4.theQuestion = "Can you see Skull Island depicted on the mural in the queue for Peter Pan?"
        peterPansFlight4.correctAnswer = "Yes"
        peterPansFlight4.keyboardType = true
        peterPansFlight4.resultImage = greyMouse
        peterPansFlight4.answerBool = false
        peterPansFlight4.questionInt = 304
        peterPansFlight4.land = fantasyland
        
        let peterPansFlight5 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight5.questionTitle = "Peter Pans Flight 5"
        peterPansFlight5.theQuestion = "Looking at the mural, how many cannons can you see on Captain Hook’s Pirate Ship?"
        peterPansFlight5.correctAnswer = "2"
        peterPansFlight5.keyboardType = false
        peterPansFlight5.resultImage = greyMouse
        peterPansFlight5.answerBool = false
        peterPansFlight5.questionInt = 305
        peterPansFlight5.land = fantasyland
        
        let peterPansFlight6 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight6.questionTitle = "Peter Pans Flight 6"
        peterPansFlight6.theQuestion = "How many mermaids can you see on the mural?"
        peterPansFlight6.correctAnswer = "3"
        peterPansFlight6.keyboardType = false
        peterPansFlight6.resultImage = greyMouse
        peterPansFlight6.answerBool = false
        peterPansFlight6.questionInt = 306
        peterPansFlight6.land = fantasyland
        
        let peterPansFlight7 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight7.questionTitle = "Peter Pans Flight 7"
        peterPansFlight7.theQuestion = "How many Teepees can you see on the mural?"
        peterPansFlight7.correctAnswer = "8"
        peterPansFlight7.keyboardType = false
        peterPansFlight7.resultImage = greyMouse
        peterPansFlight7.answerBool = false
        peterPansFlight7.questionInt = 307
        peterPansFlight7.land = fantasyland
        
        let peterPansFlight8 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight8.questionTitle = "Peter Pans Flight 8"
        peterPansFlight8.theQuestion = "What color of hat is John wearing in the mural?"
        peterPansFlight8.correctAnswer = "black"
        peterPansFlight8.keyboardType = true
        peterPansFlight8.resultImage = greyMouse
        peterPansFlight8.answerBool = false
        peterPansFlight8.questionInt = 308
        peterPansFlight8.land = fantasyland
        
        let peterPansFlight9 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight9.questionTitle = "Peter Pans Flight 9"
        peterPansFlight9.theQuestion = "How many sails does Captain Hook’s Ship have on the mural?"
        peterPansFlight9.correctAnswer = "6"
        peterPansFlight9.keyboardType = false
        peterPansFlight9.resultImage = greyMouse
        peterPansFlight9.answerBool = false
        peterPansFlight9.questionInt = 309
        peterPansFlight9.land = fantasyland
        
        let peterPansFlight10 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight10.questionTitle = "Peter Pans Flight 10"
        peterPansFlight10.theQuestion = "How many cannons are on the side of the ship you fly in?"
        peterPansFlight10.correctAnswer = "4"
        peterPansFlight10.keyboardType = false
        peterPansFlight10.resultImage = greyMouse
        peterPansFlight10.answerBool = false
        peterPansFlight10.questionInt = 310
        peterPansFlight10.land = fantasyland
        
        let peterPansFlight11 = Questions(entity: questionDescription!, insertInto: context)
        peterPansFlight11.questionTitle = "Peter Pans Flight 11"
        peterPansFlight11.theQuestion = "What Peter Pan character gives the safety spiel while you wait in line?"
        peterPansFlight11.correctAnswer = "Jane"
        peterPansFlight11.keyboardType = true
        peterPansFlight11.resultImage = greyMouse
        peterPansFlight11.answerBool = false
        peterPansFlight11.questionInt = 311
        peterPansFlight11.land = fantasyland
        
        //Mr. Toad's Wild Ride (351-400)
        let mrToad1 = Questions(entity: questionDescription!, insertInto: context)
        mrToad1.questionTitle = "Mr. Toad 1"
        mrToad1.theQuestion = "Can you see the Casey Jr. Train from any point of the Mr. Toad queue? (Yes or No)"
        mrToad1.correctAnswer = "yes"
        mrToad1.keyboardType = true
        mrToad1.resultImage = greyMouse
        mrToad1.answerBool = false
        mrToad1.questionInt = 351
        mrToad1.land = fantasyland
        
        let mrToad2 = Questions(entity: questionDescription!, insertInto: context)
        mrToad2.questionTitle = "Mr. Toad 2"
        mrToad2.theQuestion = "In the garden part of the queue for Mr. Toad's Wild Ride there are small statues of his friends faces on the wall. How many friends are represented?"
        mrToad2.correctAnswer = "4"
        mrToad2.keyboardType = false
        mrToad2.resultImage = greyMouse
        mrToad2.answerBool = false
        mrToad2.questionInt = 352
        mrToad2.land = fantasyland
        
        let mrToad3 = Questions(entity: questionDescription!, insertInto: context)
        mrToad3.questionTitle = "Mr. Toad 3"
        mrToad3.theQuestion = "Mr. Toad's Crest is displayed above the entrance to Toad Hall. It reads \"Semper ______\"."
        mrToad3.correctAnswer = "absurda"
        mrToad3.keyboardType = true
        mrToad3.resultImage = greyMouse
        mrToad3.answerBool = false
        mrToad3.questionInt = 353
        mrToad3.land = fantasyland
        
        let mrToad4 = Questions(entity: questionDescription!, insertInto: context)
        mrToad4.questionTitle = "Mr. Toad 4"
        mrToad4.theQuestion = "Before you enter Mr. Toad's Wild Ride the board explaining the ride reads in part, \"careening through the streets of ___________ to nowhere in particular.\""
        mrToad4.correctAnswer = "London"
        mrToad4.keyboardType = true
        mrToad4.resultImage = greyMouse
        mrToad4.answerBool = false
        mrToad4.questionInt = 354
        mrToad4.land = fantasyland
        
        let mrToad5 = Questions(entity: questionDescription!, insertInto: context)
        mrToad5.questionTitle = "Mr. Toad 5"
        mrToad5.theQuestion = "How many different ride vehicle colors are there for this attraction?"
        mrToad5.correctAnswer = "6"
        mrToad5.keyboardType = false
        mrToad5.resultImage = greyMouse
        mrToad5.answerBool = false
        mrToad5.questionInt = 355
        mrToad5.land = fantasyland
        
        let mrToad6 = Questions(entity: questionDescription!, insertInto: context)
        mrToad6.questionTitle = "Mr. Toad 6"
        mrToad6.theQuestion = "How many candle sticks are on the large chandelier in Toad Hall?"
        mrToad6.correctAnswer = "16"
        mrToad6.keyboardType = false
        mrToad6.resultImage = greyMouse
        mrToad6.answerBool = false
        mrToad6.questionInt = 356
        mrToad6.land = fantasyland
        
        let mrToad7 = Questions(entity: questionDescription!, insertInto: context)
        mrToad7.questionTitle = "Mr. Toad 7"
        mrToad7.theQuestion = "There is a statue of Mr. Toad above the entrance to his ride.  How many of his hands can you see?"
        mrToad7.correctAnswer = "1"
        mrToad7.keyboardType = false
        mrToad7.resultImage = greyMouse
        mrToad7.answerBool = false
        mrToad7.questionInt = 357
        mrToad7.land = fantasyland
        
        let mrToad8 = Questions(entity: questionDescription!, insertInto: context)
        mrToad8.questionTitle = "Mr. Toad 8"
        mrToad8.theQuestion = "Mr. Toad's Wild Ride concludes with a journey through ___________."
        mrToad8.correctAnswer = "Hell"
        mrToad8.keyboardType = true
        mrToad8.resultImage = greyMouse
        mrToad8.answerBool = false
        mrToad8.questionInt = 358
        mrToad8.land = fantasyland
        
        let mrToad9 = Questions(entity: questionDescription!, insertInto: context)
        mrToad9.questionTitle = "Mr. Toad 9"
        mrToad9.theQuestion = "What is the color of the car outside of Mr. Toad's Wild Ride that you can take pictures in?"
        mrToad9.correctAnswer = "red"
        mrToad9.keyboardType = true
        mrToad9.resultImage = greyMouse
        mrToad9.answerBool = false
        mrToad9.questionInt = 359
        mrToad9.land = fantasyland
        
        //King Arthurs Carrousel (401-450)
        let kaCarrousel1 = Questions(entity: questionDescription!, insertInto: context)
        kaCarrousel1.questionTitle = "King Arthur Carrousel 1"
        kaCarrousel1.theQuestion = "What color are all the horses on King Arthur's Carrousel?"
        kaCarrousel1.correctAnswer = "White"
        kaCarrousel1.keyboardType = true
        kaCarrousel1.resultImage = greyMouse
        kaCarrousel1.answerBool = false
        kaCarrousel1.questionInt = 401
        kaCarrousel1.land = fantasyland
        
        let kaCarrousel2 = Questions(entity: questionDescription!, insertInto: context)
        kaCarrousel2.questionTitle = "King Arthur Carrousel 2"
        kaCarrousel2.theQuestion = "How many horses are on King Arthurs Carrousel?"
        kaCarrousel2.correctAnswer = "68"
        kaCarrousel2.keyboardType = false
        kaCarrousel2.resultImage = greyMouse
        kaCarrousel2.answerBool = false
        kaCarrousel2.questionInt = 402
        kaCarrousel2.land = fantasyland
        
        //Matterhorn (451-500)
        let matterhorn1 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn1.questionTitle = "Matterhorn 1"
        matterhorn1.theQuestion = "How many different colors are used on the bobsleds?"
        matterhorn1.correctAnswer = "3"
        matterhorn1.keyboardType = false
        matterhorn1.resultImage = greyMouse
        matterhorn1.answerBool = false
        matterhorn1.questionInt = 451
        matterhorn1.land = fantasyland
        
        let matterhorn2 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn2.questionTitle = "Matterhorn 2"
        matterhorn2.theQuestion = "Can you see the Alice in Wonderland attraction from the queue?"
        matterhorn2.correctAnswer = "yes"
        matterhorn2.keyboardType = true
        matterhorn2.resultImage = greyMouse
        matterhorn2.answerBool = false
        matterhorn2.questionInt = 452
        matterhorn2.land = fantasyland
        
        let matterhorn3 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn3.questionTitle = "Matterhorn 3"
        matterhorn3.theQuestion = "On the sign for the Matterhorn you will see a man playing a Didgeridoo. What color is the Didgeridoo?"
        matterhorn3.correctAnswer = "yellow"
        matterhorn3.keyboardType = true
        matterhorn3.resultImage = greyMouse
        matterhorn3.answerBool = false
        matterhorn3.questionInt = 453
        matterhorn3.land = fantasyland
        
        let matterhorn4 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn4.questionTitle = "Matterhorn 4"
        matterhorn4.theQuestion = "Behind the sign for the Matterhorn Bobsleds are many countries flags painted on wood. What country has the largest flag representation?"
        matterhorn4.correctAnswer = "Switzerland"
        matterhorn4.keyboardType = true
        matterhorn4.resultImage = greyMouse
        matterhorn4.answerBool = false
        matterhorn4.questionInt = 454
        matterhorn4.land = fantasyland
        
        let matterhorn5 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn5.questionTitle = "Matterhorn 5"
        matterhorn5.theQuestion = "From the Matterhorn queue you will hear some music coming from some spinning tea cups. What is the name of the attraction producing the music?"
        matterhorn5.correctAnswer = "The Mad Tea Party"
        matterhorn5.keyboardType = true
        matterhorn5.resultImage = greyMouse
        matterhorn5.answerBool = false
        matterhorn5.questionInt = 455
        matterhorn5.land = fantasyland
        
        let matterhorn6 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn6.questionTitle = "Matterhorn 6"
        matterhorn6.theQuestion = "Can you see Star Tours from the Matterhorn queue?"
        matterhorn6.correctAnswer = "No"
        matterhorn6.keyboardType = true
        matterhorn6.resultImage = greyMouse
        matterhorn6.answerBool = false
        matterhorn6.questionInt = 456
        matterhorn6.land = fantasyland
        
        let matterhorn7 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn7.questionTitle = "Matterhorn 7"
        matterhorn7.theQuestion = "One under the building's roof for the Matterhorn Bobsleds you wind back and forth how many times before you load the bobsleds?"
        matterhorn7.correctAnswer = "3"
        matterhorn7.keyboardType = false
        matterhorn7.resultImage = greyMouse
        matterhorn7.answerBool = false
        matterhorn7.questionInt = 457
        matterhorn7.land = fantasyland
        
        let matterhorn8 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn8.questionTitle = "Matterhorn 8"
        matterhorn8.theQuestion = "How many riders per seat on the Matterhorn?"
        matterhorn8.correctAnswer = "1"
        matterhorn8.keyboardType = false
        matterhorn8.resultImage = greyMouse
        matterhorn8.answerBool = false
        matterhorn8.questionInt = 458
        matterhorn8.land = fantasyland
        
        let matterhorn9 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn9.questionTitle = "Matterhorn 9"
        matterhorn9.theQuestion = "How many seats are there in each bobsled."
        matterhorn9.correctAnswer = "3"
        matterhorn9.keyboardType = false
        matterhorn9.resultImage = greyMouse
        matterhorn9.answerBool = false
        matterhorn9.questionInt = 459
        matterhorn9.land = fantasyland
        
        let matterhorn10 = Questions(entity: questionDescription!, insertInto: context)
        matterhorn10.questionTitle = "Matterhorn 10"
        matterhorn10.theQuestion = "When receiving instruction on the Matterhorn, you are told to remain ______________. (2 words)"
        matterhorn10.correctAnswer = "seated please"
        matterhorn10.keyboardType = true
        matterhorn10.resultImage = greyMouse
        matterhorn10.answerBool = false
        matterhorn10.questionInt = 460
        matterhorn10.land = fantasyland
        
        //Sleeping Beauty Castle (501-550)
        let sleepingBeautyCastle1 = Questions(entity: questionDescription!, insertInto: context)
        sleepingBeautyCastle1.questionTitle = "Sleeping Beauty Castle 1"
        sleepingBeautyCastle1.theQuestion = "What are the first two words on the storybook page as you enter the Castle?"
        sleepingBeautyCastle1.correctAnswer = "Sleeping Beauty"
        sleepingBeautyCastle1.keyboardType = true
        sleepingBeautyCastle1.resultImage = greyMouse
        sleepingBeautyCastle1.answerBool = false
        sleepingBeautyCastle1.questionInt = 501
        sleepingBeautyCastle1.land = fantasyland
        
        let sleepingBeautyCastle2 = Questions(entity: questionDescription!, insertInto: context)
        sleepingBeautyCastle2.questionTitle = "Sleeping Beauty Castle 2"
        sleepingBeautyCastle2.theQuestion = "What is the name of the new born Princess?"
        sleepingBeautyCastle2.correctAnswer = "Aurora"
        sleepingBeautyCastle2.keyboardType = true
        sleepingBeautyCastle2.resultImage = greyMouse
        sleepingBeautyCastle2.answerBool = false
        sleepingBeautyCastle2.questionInt = 502
        sleepingBeautyCastle2.land = fantasyland
        
        let sleepingBeautyCastle3 = Questions(entity: questionDescription!, insertInto: context)
        sleepingBeautyCastle3.questionTitle = "Sleeping Beauty Castle 3"
        sleepingBeautyCastle3.theQuestion = "The storybook tells us the King Stefen is having the villagers burn what?"
        sleepingBeautyCastle3.correctAnswer = "spinning wheels"
        sleepingBeautyCastle3.keyboardType = true
        sleepingBeautyCastle3.resultImage = greyMouse
        sleepingBeautyCastle3.answerBool = false
        sleepingBeautyCastle3.questionInt = 503
        sleepingBeautyCastle3.land = fantasyland
        
        let sleepingBeautyCastle4 = Questions(entity: questionDescription!, insertInto: context)
        sleepingBeautyCastle4.questionTitle = "Sleeping Beauty Castle 4"
        sleepingBeautyCastle4.theQuestion = "How many good fairies put the kingdom to sleep?"
        sleepingBeautyCastle4.correctAnswer = "3"
        sleepingBeautyCastle4.keyboardType = false
        sleepingBeautyCastle4.resultImage = greyMouse
        sleepingBeautyCastle4.answerBool = false
        sleepingBeautyCastle4.questionInt = 504
        sleepingBeautyCastle4.land = fantasyland
        
        let sleepingBeautyCastle5 = Questions(entity: questionDescription!, insertInto: context)
        sleepingBeautyCastle5.questionTitle = "Sleeping Beauty Castle 5"
        sleepingBeautyCastle5.theQuestion = "What is the name of the prince in the story? (2 Words)"
        sleepingBeautyCastle5.correctAnswer = "Prince Phillip"
        sleepingBeautyCastle5.keyboardType = true
        sleepingBeautyCastle5.resultImage = greyMouse
        sleepingBeautyCastle5.answerBool = false
        sleepingBeautyCastle5.questionInt = 505
        sleepingBeautyCastle5.land = fantasyland
        
        let sleepingBeautyCastle6 = Questions(entity: questionDescription!, insertInto: context)
        sleepingBeautyCastle6.questionTitle = "Sleeping Beauty Castle 6"
        sleepingBeautyCastle6.theQuestion = "How many stairs are their in Sleeping Beauty's Castle from beginning to end?"
        sleepingBeautyCastle6.correctAnswer = "62"
        sleepingBeautyCastle6.keyboardType = false
        sleepingBeautyCastle6.resultImage = greyMouse
        sleepingBeautyCastle6.answerBool = false
        sleepingBeautyCastle6.questionInt = 506
        sleepingBeautyCastle6.land = fantasyland
        
        let sleepingBeautyCastle7 = Questions(entity: questionDescription!, insertInto: context)
        sleepingBeautyCastle7.questionTitle = "Sleeping Beauty Castle 7"
        sleepingBeautyCastle7.theQuestion = "How many lightpoles are on the bridge leading up to Sleeping Beauty Castle?"
        sleepingBeautyCastle7.correctAnswer = "6"
        sleepingBeautyCastle7.keyboardType = false
        sleepingBeautyCastle7.resultImage = greyMouse
        sleepingBeautyCastle7.answerBool = false
        sleepingBeautyCastle7.questionInt = 507
        sleepingBeautyCastle7.land = fantasyland
        
        //Misc Fantasyland (551-600)
        let hats = Questions(entity: questionDescription!, insertInto: context)
        hats.questionTitle = "Hats"
        hats.theQuestion = "What is the name of the hat shop in Fantasyland? (Three Words)"
        hats.correctAnswer = "The Mad Hatter"
        hats.keyboardType = true
        hats.resultImage = greyMouse
        hats.answerBool = false
        hats.questionInt = 551
        hats.land = fantasyland
        
        let flRestaurant = Questions(entity: questionDescription!, insertInto: context)
        flRestaurant.questionTitle = "Fantasyland Food"
        flRestaurant.theQuestion = "What is the name of the Restaurant in Fantasyland located across from Casey Junior?"
        flRestaurant.correctAnswer = "Village Haus"
        flRestaurant.keyboardType = true
        flRestaurant.resultImage = greyMouse
        flRestaurant.answerBool = false
        flRestaurant.questionInt = 552
        flRestaurant.land = fantasyland
        
        let restrooms = Questions(entity: questionDescription!, insertInto: context)
        restrooms.questionTitle = "Restrooms"
        restrooms.theQuestion = "The restrooms located on the path between the castle and the Matterhorn have signs that say _____________ instead of Men."
        restrooms.correctAnswer = "Kings"
        restrooms.keyboardType = true
        restrooms.resultImage = greyMouse
        restrooms.answerBool = false
        restrooms.questionInt = 553
        restrooms.land = fantasyland
        
        let door = Questions(entity: questionDescription!, insertInto: context)
        door.questionTitle = "Door"
        door.theQuestion = "There is a small pink door after you exit Alice in Wonderland and go towards the hat shop.  What does the small golden plaque on the door say?"
        door.correctAnswer = "W. Rabbit"
        door.keyboardType = true
        door.resultImage = greyMouse
        door.answerBool = false
        door.questionInt = 554
        door.land = fantasyland
        
        let clock = Questions(entity: questionDescription!, insertInto: context)
        clock.questionTitle = "Fantasyland Clock"
        clock.theQuestion = "What type of numbers does the the clock above the Bibbidi Bobbidi Boutique use? Standard or Roman Numerals? (One Word)"
        clock.correctAnswer = "Roman"
        clock.keyboardType = true
        clock.resultImage = greyMouse
        clock.answerBool = false
        clock.questionInt = 555
        clock.land = fantasyland
        
        let trash = Questions(entity: questionDescription!, insertInto: context)
        trash.questionTitle = "Trash"
        trash.theQuestion = "What is the main color on the trash cans in Fantasyland?"
        trash.correctAnswer = "brown"
        trash.keyboardType = true
        trash.resultImage = greyMouse
        trash.answerBool = false
        trash.questionInt = 556
        trash.land = fantasyland
        
        let wishingWell1 = Questions(entity: questionDescription!, insertInto: context)
        wishingWell1.questionTitle = "Wishing Well 1"
        wishingWell1.theQuestion = "Who's Wishing Well is to the east of Sleeping Beauty Castle? (non-possesive)"
        wishingWell1.correctAnswer = "Snow White"
        wishingWell1.keyboardType = true
        wishingWell1.resultImage = greyMouse
        wishingWell1.answerBool = false
        wishingWell1.questionInt = 557
        wishingWell1.land = fantasyland
        
        let wishingWell2 = Questions(entity: questionDescription!, insertInto: context)
        wishingWell2.questionTitle = "Wishing Well 2"
        wishingWell2.theQuestion = "When at the Snow White Wishing Well and Grotto, what animal is standing by Snow White?"
        wishingWell2.correctAnswer = "deer"
        wishingWell2.keyboardType = true
        wishingWell2.resultImage = greyMouse
        wishingWell2.answerBool = false
        wishingWell2.questionInt = 558
        wishingWell2.land = fantasyland
        
        let wishingWell3 = Questions(entity: questionDescription!, insertInto: context)
        wishingWell3.questionTitle = "Wishing Well 3"
        wishingWell3.theQuestion = "How many marble statues are always visable?"
        wishingWell3.correctAnswer = "17"
        wishingWell3.keyboardType = false
        wishingWell3.resultImage = greyMouse
        wishingWell3.answerBool = false
        wishingWell3.questionInt = 559
        wishingWell3.land = fantasyland
        
        let wishingWell4 = Questions(entity: questionDescription!, insertInto: context)
        wishingWell4.questionTitle = "Wishing Well 4"
        wishingWell4.theQuestion = "How many marble statues are there total?"
        wishingWell4.correctAnswer = "20"
        wishingWell4.keyboardType = false
        wishingWell4.resultImage = greyMouse
        wishingWell4.answerBool = false
        wishingWell4.questionInt = 560
        wishingWell4.land = fantasyland
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
// Critter Country
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let critterCountry = Land(entity: landDescription!, insertInto: context)
        
        critterCountry.landName = "Critter Country"
        critterCountry.artWorkForLand = "SplashMountain.jpg"
        
        //Splash Mountain (1-50)
        let sm1 = Questions(entity: questionDescription!, insertInto: context)
        sm1.questionTitle = "Splash Mountain 1"
        sm1.theQuestion = "When entering the Queue for Splash Mountain, you will see a sign on your right. How far does it say the drop at the end is?"
        sm1.correctAnswer = "50 feet"
        sm1.keyboardType = true
        sm1.resultImage = greyMouse
        sm1.answerBool = false
        sm1.questionInt = 1
        sm1.land = critterCountry
        
        let sm2 = Questions(entity: questionDescription!, insertInto: context)
        sm2.questionTitle = "Splash Mountain 2"
        sm2.theQuestion = "Once you enter the barn part of the queue for Splash Mountain if you look up you will see a chandelier with oil lamps. How many lamps are on the chandelier?"
        sm2.correctAnswer = "5"
        sm2.keyboardType = false
        sm2.resultImage = greyMouse
        sm2.answerBool = false
        sm2.questionInt = 2
        sm2.land = critterCountry
        
        let sm3 = Questions(entity: questionDescription!, insertInto: context)
        sm3.questionTitle = "Splash Mountain 3"
        sm3.theQuestion = "When you are nearly to the front of Splash Mountain you can look through some large holes in the rock to see what character singing Zip-A-Dee-Doo-Dah on a rug in his home?"
        sm3.correctAnswer = "Brer Rabbit"
        sm3.keyboardType = true
        sm3.resultImage = greyMouse
        sm3.answerBool = false
        sm3.questionInt = 3
        sm3.land = critterCountry
        
        let sm4 = Questions(entity: questionDescription!, insertInto: context)
        sm4.questionTitle = "Splash Mountain 4"
        sm4.theQuestion = "When riding Splash Mountain, what do you ride in? (Singular)"
        sm4.correctAnswer = "Log"
        sm4.keyboardType = true
        sm4.resultImage = greyMouse
        sm4.answerBool = false
        sm4.questionInt = 4
        sm4.land = critterCountry
        
        let sm5 = Questions(entity: questionDescription!, insertInto: context)
        sm5.questionTitle = "Splash Mountain 5"
        sm5.theQuestion = "When climbing the hill to the final drop in Splash Mountain there are 2 birds.  What kind are they? (plural)"
        sm5.correctAnswer = "Vultures"
        sm5.keyboardType = true
        sm5.resultImage = greyMouse
        sm5.answerBool = false
        sm5.questionInt = 5
        sm5.land = critterCountry
        
        let sm6 = Questions(entity: questionDescription!, insertInto: context)
        sm6.questionTitle = "Splash Mountain 6"
        sm6.theQuestion = "In the laughing place area, Brer Bear has something on his nose and Brer Rabbit is laughing. What is on his nose? (1 word)"
        sm6.correctAnswer = "Beehive"
        sm6.keyboardType = true
        sm6.resultImage = greyMouse
        sm6.answerBool = false
        sm6.questionInt = 6
        sm6.land = critterCountry
        
        let sm7 = Questions(entity: questionDescription!, insertInto: context)
        sm7.questionTitle = "Splash Mountain 7"
        sm7.theQuestion = "Right before you get to the big drop in Splash Mountain, how many mother animals are telling their children to stay away from the laughing place?"
        sm7.correctAnswer = "2"
        sm7.keyboardType = false
        sm7.resultImage = greyMouse
        sm7.answerBool = false
        sm7.questionInt = 7
        sm7.land = critterCountry
        
        let sm8 = Questions(entity: questionDescription!, insertInto: context)
        sm8.questionTitle = "Splash Mountain 8"
        sm8.theQuestion = "When riding Splash Mountain, you will see a wrapped up rabbit before the big drop, what is he wrapped in? (plural form)"
        sm8.correctAnswer = "Ropes"
        sm8.keyboardType = true
        sm8.resultImage = greyMouse
        sm8.answerBool = false
        sm8.questionInt = 8
        sm8.land = critterCountry
        
        let sm9 = Questions(entity: questionDescription!, insertInto: context)
        sm9.questionTitle = "Splash Mountain 9"
        sm9.theQuestion = "While climbing the final hill in Splash Mountain, you will see an animal threatening Brer Rabbit. What animal is it? (1 word)"
        sm9.correctAnswer = "Fox"
        sm9.keyboardType = true
        sm9.resultImage = greyMouse
        sm9.answerBool = false
        sm9.questionInt = 9
        sm9.land = critterCountry
        
        let sm10 = Questions(entity: questionDescription!, insertInto: context)
        sm10.questionTitle = "Splash Mountain 10"
        sm10.theQuestion = "Before entering the final scene in Splash Mountain, look to your left. What does the top sign say?"
        sm10.correctAnswer = "Catfish Bend"
        sm10.keyboardType = true
        sm10.resultImage = greyMouse
        sm10.answerBool = false
        sm10.questionInt = 10
        sm10.land = critterCountry
        
        let sm11 = Questions(entity: questionDescription!, insertInto: context)
        sm11.questionTitle = "Splash Mountain 11"
        sm11.theQuestion = "When riding Splash Mountain you will see a raccoon and a porcupine. What is the raccoon playing? (1 word)"
        sm11.correctAnswer = "harmonica"
        sm11.keyboardType = true
        sm11.resultImage = greyMouse
        sm11.answerBool = false
        sm11.questionInt = 11
        sm11.land = critterCountry
        
        //Winnie The Pooh (51-100)
        let wtp1 = Questions(entity: questionDescription!, insertInto: context)
        wtp1.questionTitle = "Winnie the Pooh 1"
        wtp1.theQuestion = "On the Winnie the Pooh ride sign, who is upside down?"
        wtp1.correctAnswer = "Tigger"
        wtp1.keyboardType = true
        wtp1.resultImage = greyMouse
        wtp1.answerBool = false
        wtp1.questionInt = 51
        wtp1.land = critterCountry
        
        let wtp2 = Questions(entity: questionDescription!, insertInto: context)
        wtp2.questionTitle = "Winnie the Pooh 2"
        wtp2.theQuestion = "What Rail Road passes over the queue for Winnie the Pooh? (Four Words)"
        wtp2.correctAnswer = "The Disneyland Rail Road"
        wtp2.keyboardType = true
        wtp2.resultImage = greyMouse
        wtp2.answerBool = false
        wtp2.questionInt = 52
        wtp2.land = critterCountry
        
        let wtp3 = Questions(entity: questionDescription!, insertInto: context)
        wtp3.questionTitle = "Winnie the Pooh 3"
        wtp3.theQuestion = "What is the name of the restaurant right next to the Winnie the Pooh attraction? (Four Words)"
        wtp3.correctAnswer = "The Hungry Bear Restaurant"
        wtp3.keyboardType = true
        wtp3.resultImage = greyMouse
        wtp3.answerBool = false
        wtp3.questionInt = 53
        wtp3.land = critterCountry
        
        let wtp4 = Questions(entity: questionDescription!, insertInto: context)
        wtp4.questionTitle = "Winnie the Pooh 4"
        wtp4.theQuestion = "What do you ride in on the Winnie the Pooh ride? (singular form)"
        wtp4.correctAnswer = "Beehive"
        wtp4.keyboardType = true
        wtp4.resultImage = greyMouse
        wtp4.answerBool = false
        wtp4.questionInt = 54
        wtp4.land = critterCountry
        
        let wtp5 = Questions(entity: questionDescription!, insertInto: context)
        wtp5.questionTitle = "Winnie the Pooh 5"
        wtp5.theQuestion = "How many rows are in the Bee-Hives that you ride in?"
        wtp5.correctAnswer = "3"
        wtp5.keyboardType = false
        wtp5.resultImage = greyMouse
        wtp5.answerBool = false
        wtp5.questionInt = 55
        wtp5.land = critterCountry
        
        let wtp6 = Questions(entity: questionDescription!, insertInto: context)
        wtp6.questionTitle = "Winnie the Pooh 6"
        wtp6.theQuestion = "While in the queue and on the ride you will notice that Winnie the Pooh has a hard time spelling what word correctly."
        wtp6.correctAnswer = "Honey"
        wtp6.keyboardType = true
        wtp6.resultImage = greyMouse
        wtp6.answerBool = false
        wtp6.questionInt = 56
        wtp6.land = critterCountry
        
        let wtp7 = Questions(entity: questionDescription!, insertInto: context)
        wtp7.questionTitle = "Winnie the Pooh 7"
        wtp7.theQuestion = "What color is Winnie the Pooh's shirt?"
        wtp7.correctAnswer = "red"
        wtp7.keyboardType = true
        wtp7.resultImage = greyMouse
        wtp7.answerBool = false
        wtp7.questionInt = 57
        wtp7.land = critterCountry
        
        let wtp8 = Questions(entity: questionDescription!, insertInto: context)
        wtp8.questionTitle = "Winnie the Pooh 8"
        wtp8.theQuestion = "At the beginning of the Winnie the Pooh ride, if I look to my right I see a patch of _____________."
        wtp8.correctAnswer = "carrots"
        wtp8.keyboardType = true
        wtp8.resultImage = greyMouse
        wtp8.answerBool = false
        wtp8.questionInt = 58
        wtp8.land = critterCountry
        
        let wtp9 = Questions(entity: questionDescription!, insertInto: context)
        wtp9.questionTitle = "Winnie the Pooh 9"
        wtp9.theQuestion = "When riding the Winnie the Pooh ride, what is Piglet holding onto in the wind?"
        wtp9.correctAnswer = "broom"
        wtp9.keyboardType = true
        wtp9.resultImage = greyMouse
        wtp9.answerBool = false
        wtp9.questionInt = 59
        wtp9.land = critterCountry
        
        let wtp10 = Questions(entity: questionDescription!, insertInto: context)
        wtp10.questionTitle = "Winnie the Pooh 10"
        wtp10.theQuestion = "At the end of the Winnie the Pooh ride there is a party. The characters celebrating are Rabbit, Piglet, Pooh, Tigger, and ____________."
        wtp10.correctAnswer = "Owl"
        wtp10.keyboardType = true
        wtp10.resultImage = greyMouse
        wtp10.answerBool = false
        wtp10.questionInt = 60
        wtp10.land = critterCountry
        
        let wtp11 = Questions(entity: questionDescription!, insertInto: context)
        wtp11.questionTitle = "Winnie the Pooh 11"
        wtp11.theQuestion = "When getting off the Winnie the Pooh ride, what insect do you hear? (plural)"
        wtp11.correctAnswer = "Bees"
        wtp11.keyboardType = true
        wtp11.resultImage = greyMouse
        wtp11.answerBool = false
        wtp11.questionInt = 61
        wtp11.land = critterCountry
        
        let wtp12 = Questions(entity: questionDescription!, insertInto: context)
        wtp12.questionTitle = "Winnie the Pooh 12"
        wtp12.theQuestion = "In the Winnie the Pooh ride, how many times does the character Tigger appear?"
        wtp12.correctAnswer = "5"
        wtp12.keyboardType = false
        wtp12.resultImage = greyMouse
        wtp12.answerBool = false
        wtp12.questionInt = 62
        wtp12.land = critterCountry
        
        let wtp13 = Questions(entity: questionDescription!, insertInto: context)
        wtp13.questionTitle = "Winnie the Pooh 13"
        wtp13.theQuestion = "Near the end of the Winnie the Pooh ride, you will see all of the gang at Pooh's birthday party. The banner above their head says \"______ for Pooh\"."
        wtp13.correctAnswer = "hooray"
        wtp13.keyboardType = true
        wtp13.resultImage = greyMouse
        wtp13.answerBool = false
        wtp13.questionInt = 63
        wtp13.land = critterCountry
        
        let wtp14 = Questions(entity: questionDescription!, insertInto: context)
        wtp14.questionTitle = "Winnie the Pooh 14"
        wtp14.theQuestion = "What attraction did The Many Adventures of Winnie the Pooh replace? (Four Words)"
        wtp14.correctAnswer = "The Country Bear Jamboree"
        wtp14.keyboardType = true
        wtp14.resultImage = greyMouse
        wtp14.answerBool = false
        wtp14.questionInt = 64
        wtp14.land = critterCountry
        
        //Canoes (101-150)
        let canoes1 = Questions(entity: questionDescription!, insertInto: context)
        canoes1.questionTitle = "Canoes 1"
        canoes1.theQuestion = "What is the full name of the canoe attraction? (4 Words)"
        canoes1.correctAnswer = "Davy Crockett's Explorer Canoes"
        canoes1.keyboardType = true
        canoes1.resultImage = greyMouse
        canoes1.answerBool = false
        canoes1.questionInt = 101
        canoes1.land = critterCountry
        
        let canoes2 = Questions(entity: questionDescription!, insertInto: context)
        canoes2.questionTitle = "Canoes 2"
        canoes2.theQuestion = "On what river can you ride the Davy Crockett's Explorer Canoes?"
        canoes2.correctAnswer = "Rivers of America"
        canoes2.keyboardType = true
        canoes2.resultImage = greyMouse
        canoes2.answerBool = false
        canoes2.questionInt = 102
        canoes2.land = critterCountry
        
        //Critter Country Misc (151-200)
        let ccAttractions = Questions(entity: questionDescription!, insertInto: context)
        ccAttractions.questionTitle = "Critter Country Attractions"
        ccAttractions.theQuestion = "How many attractions are in Critter Country?"
        ccAttractions.correctAnswer = "3"
        ccAttractions.keyboardType = false
        ccAttractions.resultImage = greyMouse
        ccAttractions.answerBool = false
        ccAttractions.questionInt = 151
        ccAttractions.land = critterCountry
        
        let hungry = Questions(entity: questionDescription!, insertInto: context)
        hungry.questionTitle = "Hungry"
        hungry.theQuestion = "What is the restaurant in Critter Country named? (2 words)"
        hungry.correctAnswer = "Hungry Bear"
        hungry.keyboardType = true
        hungry.resultImage = greyMouse
        hungry.answerBool = false
        hungry.questionInt = 152
        hungry.land = critterCountry
        
        let theCandyShop = Questions(entity: questionDescription!, insertInto: context)
        theCandyShop.questionTitle = "The Candy Shop"
        theCandyShop.theQuestion = "What is the name of the candy shop in Critter Country?"
        theCandyShop.correctAnswer = "Pooh Corner"
        theCandyShop.keyboardType = true
        theCandyShop.resultImage = greyMouse
        theCandyShop.answerBool = false
        theCandyShop.questionInt = 153
        theCandyShop.land = critterCountry
        
        let ccEntrance = Questions(entity: questionDescription!, insertInto: context)
        ccEntrance.questionTitle = "Entrance"
        ccEntrance.theQuestion = "How many animals are on the entrance sign to Critter Country?"
        ccEntrance.correctAnswer = "6"
        ccEntrance.keyboardType = false
        ccEntrance.resultImage = greyMouse
        ccEntrance.answerBool = false
        ccEntrance.questionInt = 154
        ccEntrance.land = critterCountry
        
        let whatIsHeHolding = Questions(entity: questionDescription!, insertInto: context)
        whatIsHeHolding.questionTitle = "Food"
        whatIsHeHolding.theQuestion = "At the entrance to the Hungry Bear restaurant there is a bear holding a plate.  What food is on it? (1 word)"
        whatIsHeHolding.correctAnswer = "hamburger"
        whatIsHeHolding.keyboardType = true
        whatIsHeHolding.resultImage = greyMouse
        whatIsHeHolding.answerBool = false
        whatIsHeHolding.questionInt = 155
        whatIsHeHolding.land = critterCountry
        
        let theBriarPatch = Questions(entity: questionDescription!, insertInto: context)
        theBriarPatch.questionTitle = "The Briar Patch"
        theBriarPatch.theQuestion = "When looking at the sign on the Briar Patch, there is a picture of Brer Rabbit.  What is he doing?"
        theBriarPatch.correctAnswer = "sleeping"
        theBriarPatch.keyboardType = true
        theBriarPatch.resultImage = greyMouse
        theBriarPatch.answerBool = false
        theBriarPatch.questionInt = 156
        theBriarPatch.land = critterCountry
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//Tomorrowland
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let tomorrowland = Land(entity: landDescription!, insertInto: context)
        
        tomorrowland.landName = "Tomorrowland"
        tomorrowland.artWorkForLand = "SpaceMountain.jpg"
        
        //Astro Orbitor (1-50)
        let astroOrbitor1 = Questions(entity: questionDescription!, insertInto: context)
        astroOrbitor1.questionTitle = "Astro Orbitor 1"
        astroOrbitor1.theQuestion = "When riding Astro Orbitor are you rotating clockwise or counterclockwise?"
        astroOrbitor1.correctAnswer = "clockwise"
        astroOrbitor1.keyboardType = true
        astroOrbitor1.resultImage = greyMouse
        astroOrbitor1.answerBool = false
        astroOrbitor1.questionInt = 1
        astroOrbitor1.land = tomorrowland
        
        let astroOrbitor2 = Questions(entity: questionDescription!, insertInto: context)
        astroOrbitor2.questionTitle = "Astro Orbitor 2"
        astroOrbitor2.theQuestion = "How many rocket ships are on the Astro Orbitor?"
        astroOrbitor2.correctAnswer = "12"
        astroOrbitor2.keyboardType = false
        astroOrbitor2.resultImage = greyMouse
        astroOrbitor2.answerBool = false
        astroOrbitor2.questionInt = 2
        astroOrbitor2.land = tomorrowland

        let astroOrbitor3 = Questions(entity: questionDescription!, insertInto: context)
        astroOrbitor3.questionTitle = "Astro Orbitor 3"
        astroOrbitor3.theQuestion = "How many Tomorrowland attractions can you see from the queue?"
        astroOrbitor3.correctAnswer = "2"
        astroOrbitor3.keyboardType = false
        astroOrbitor3.resultImage = greyMouse
        astroOrbitor3.answerBool = false
        astroOrbitor3.questionInt = 3
        astroOrbitor3.land = tomorrowland
        
        //Finding Nemo Submarine Voyage (51-100)
        let findingNemo1 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo1.questionTitle = "Finding Nemo 1"
        findingNemo1.theQuestion = "What color are the submarines on the Finding Nemo Submarine Voyage?"
        findingNemo1.correctAnswer = "Yellow"
        findingNemo1.keyboardType = true
        findingNemo1.resultImage = greyMouse
        findingNemo1.answerBool = false
        findingNemo1.questionInt = 51
        findingNemo1.land = tomorrowland
        
        let findingNemo2 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo2.questionTitle = "Finding Nemo 2"
        findingNemo2.theQuestion = "What color is the buoy that the birds are on outside the Submarine Voyage ride?"
        findingNemo2.correctAnswer = "red"
        findingNemo2.keyboardType = true
        findingNemo2.resultImage = greyMouse
        findingNemo2.answerBool = false
        findingNemo2.questionInt = 52
        findingNemo2.land = tomorrowland
        
        let findingNemo3 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo3.questionTitle = "Finding Nemo 3"
        findingNemo3.theQuestion = "What kind of birds are chirping \"Mine, Mine, Mine\" outside of the Finding Nemo Submarine ride? (plural form)"
        findingNemo3.correctAnswer = "Seagulls"
        findingNemo3.keyboardType = true
        findingNemo3.resultImage = greyMouse
        findingNemo3.answerBool = false
        findingNemo3.questionInt = 53
        findingNemo3.land = tomorrowland
        
        let findingNemo4 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo4.questionTitle = "Finding Nemo 4"
        findingNemo4.theQuestion = "What is the ship number of the Neptune submarine?"
        findingNemo4.correctAnswer = "707"
        findingNemo4.keyboardType = false
        findingNemo4.resultImage = greyMouse
        findingNemo4.answerBool = false
        findingNemo4.questionInt = 54
        findingNemo4.land = tomorrowland
        
        let findingNemo5 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo5.questionTitle = "Finding Nemo 5"
        findingNemo5.theQuestion = "What is the ship number of the Explorer submarine?"
        findingNemo5.correctAnswer = "607"
        findingNemo5.keyboardType = false
        findingNemo5.resultImage = greyMouse
        findingNemo5.answerBool = false
        findingNemo5.questionInt = 55
        findingNemo5.land = tomorrowland
        
        let findingNemo6 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo6.questionTitle = "Finding Nemo 6"
        findingNemo6.theQuestion = "What is the ship number of the Argonaut submarine?"
        findingNemo6.correctAnswer = "807"
        findingNemo6.keyboardType = false
        findingNemo6.resultImage = greyMouse
        findingNemo6.answerBool = false
        findingNemo6.questionInt = 56
        findingNemo6.land = tomorrowland
        
        let findingNemo7 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo7.questionTitle = "Finding Nemo 7"
        findingNemo7.theQuestion = "What is the ship number of the Scout submarine?"
        findingNemo7.correctAnswer = "207"
        findingNemo7.keyboardType = false
        findingNemo7.resultImage = greyMouse
        findingNemo7.answerBool = false
        findingNemo7.questionInt = 57
        findingNemo7.land = tomorrowland
        
        let findingNemo8 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo8.questionTitle = "Finding Nemo 8"
        findingNemo8.theQuestion = "What is the ship number of the Voyager submarine?"
        findingNemo8.correctAnswer = "307"
        findingNemo8.keyboardType = false
        findingNemo8.resultImage = greyMouse
        findingNemo8.answerBool = false
        findingNemo8.questionInt = 58
        findingNemo8.land = tomorrowland
        
        let findingNemo9 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo9.questionTitle = "Finding Nemo 9"
        findingNemo9.theQuestion = "What is the ship number of the Seafarer submarine?"
        findingNemo9.correctAnswer = "507"
        findingNemo9.keyboardType = false
        findingNemo9.resultImage = greyMouse
        findingNemo9.answerBool = false
        findingNemo9.questionInt = 59
        findingNemo9.land = tomorrowland
        
        let findingNemo10 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo10.questionTitle = "Finding Nemo 10"
        findingNemo10.theQuestion = "How many birds are standing on the buoy in the submarine lagoon?"
        findingNemo10.correctAnswer = "3"
        findingNemo10.keyboardType = false
        findingNemo10.resultImage = greyMouse
        findingNemo10.answerBool = false
        findingNemo10.questionInt = 60
        findingNemo10.land = tomorrowland
        
        let findingNemo11 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo11.questionTitle = "Finding Nemo 11"
        findingNemo11.theQuestion = "How many \"Mountians\" can you see from the Finding Nemo Submarine Voyage queue?"
        findingNemo11.correctAnswer = "2"
        findingNemo11.keyboardType = false
        findingNemo11.resultImage = greyMouse
        findingNemo11.answerBool = false
        findingNemo11.questionInt = 61
        findingNemo11.land = tomorrowland

        let findingNemo12 = Questions(entity: questionDescription!, insertInto: context)
        findingNemo12.questionTitle = "Finding Nemo 12"
        findingNemo12.theQuestion = "At the beginning of the Finding Nemo Submarine Voyage the announcer says \"Stand by to __________.\""
        findingNemo12.correctAnswer = "Dive"
        findingNemo12.keyboardType = true
        findingNemo12.resultImage = greyMouse
        findingNemo12.answerBool = false
        findingNemo12.questionInt = 62
        findingNemo12.land = tomorrowland
        
        //Buzzlightyear Astro Blasters (101-150)
        let buzzLightyear1 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear1.questionTitle = "Buzz Lightyear Astro Blasters 1"
        buzzLightyear1.theQuestion = "At the entrance to Buzz Lightyear Astro Blasters, the word \"Astro\" is inside what shapes? (plural)"
        buzzLightyear1.correctAnswer = "circles"
        buzzLightyear1.keyboardType = true
        buzzLightyear1.resultImage = greyMouse
        buzzLightyear1.answerBool = false
        buzzLightyear1.questionInt = 101
        buzzLightyear1.land = tomorrowland
        
        let buzzLightyear2 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear2.questionTitle = "Buzz Lightyear Astro Blasters 2"
        buzzLightyear2.theQuestion = "In the Buzz Lightyear Astro Blaster queue there is a sign that says \"Welcome Future ______________\" (2 words)"
        buzzLightyear2.correctAnswer = "Space Rangers"
        buzzLightyear2.resultImage = greyMouse
        buzzLightyear2.answerBool = false
        buzzLightyear2.keyboardType = true
        buzzLightyear2.questionInt = 102
        buzzLightyear2.land = tomorrowland
        
        let buzzLightyear3 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear3.questionTitle = "Buzz Lightyear Astro Blasters 3"
        buzzLightyear3.theQuestion = "When Buzz debriefs you in the queue, he tells you to report to the? (2 word)"
        buzzLightyear3.correctAnswer = "Flight Deck"
        buzzLightyear3.keyboardType = true
        buzzLightyear3.resultImage = greyMouse
        buzzLightyear3.answerBool = false
        buzzLightyear3.questionInt = 103
        buzzLightyear3.land = tomorrowland
        
        let buzzLightyear4 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear4.questionTitle = "Buzz Lightyear Astro Blasters 4"
        buzzLightyear4.theQuestion = "What company's logo from the Toy Story movies is on the chest of the Little Green Men?"
        buzzLightyear4.correctAnswer = "Pizza Planet"
        buzzLightyear4.keyboardType = true
        buzzLightyear4.resultImage = greyMouse
        buzzLightyear4.answerBool = false
        buzzLightyear4.questionInt = 104
        buzzLightyear4.land = tomorrowland
        
        let buzzLightyear5 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear5.questionTitle = "Buzz Lightyear Astro Blasters 5"
        buzzLightyear5.theQuestion = "As you are loading Buzz Lightyear Astro Blasters you are reminded that \"the targets are worth more when _________.\""
        buzzLightyear5.correctAnswer = "lit"
        buzzLightyear5.keyboardType = true
        buzzLightyear5.resultImage = greyMouse
        buzzLightyear5.answerBool = false
        buzzLightyear5.questionInt = 105
        buzzLightyear5.land = tomorrowland
        
        let buzzLightyear6 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear6.questionTitle = "Buzz Lightyear Astro Blasters 6"
        buzzLightyear6.theQuestion = "Who is the Evil Emperor in Buzz Lightyear Astro Blasters?"
        buzzLightyear6.correctAnswer = "Zurg"
        buzzLightyear6.keyboardType = true
        buzzLightyear6.resultImage = greyMouse
        buzzLightyear6.answerBool = false
        buzzLightyear6.questionInt = 106
        buzzLightyear6.land = tomorrowland
        
        let buzzLightyear7 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear7.questionTitle = "Buzz Lightyear Astro Blasters 7"
        buzzLightyear7.theQuestion = "When looking at the status board at the end of the Buzz Lightyear ride, you learn that if you score 0 - 1000 points you are a _____________. (2 words)"
        buzzLightyear7.correctAnswer = "Star Cadet"
        buzzLightyear7.keyboardType = true
        buzzLightyear7.resultImage = greyMouse
        buzzLightyear7.answerBool = false
        buzzLightyear7.questionInt = 107
        buzzLightyear7.land = tomorrowland
        
        let buzzLightyear8 = Questions(entity: questionDescription!, insertInto: context)
        buzzLightyear8.questionTitle = "Buzz Lightyear Astro Blasters 8"
        buzzLightyear8.theQuestion = "What is the name of the store at the end of the Buzz Lightyear ride? (5 Words)"
        buzzLightyear8.correctAnswer = "Little Green Men Store Command"
        buzzLightyear8.keyboardType = true
        buzzLightyear8.resultImage = greyMouse
        buzzLightyear8.answerBool = false
        buzzLightyear8.questionInt = 108
        buzzLightyear8.land = tomorrowland
        
        
        //Autopia (151-200)
        let autopia1 = Questions(entity: questionDescription!, insertInto: context)
        autopia1.questionTitle = "Autopia 1"
        autopia1.theQuestion = "What company powers Autopia?"
        autopia1.correctAnswer = "Honda"
        autopia1.keyboardType = true
        autopia1.resultImage = greyMouse
        autopia1.answerBool = false
        autopia1.questionInt = 151
        autopia1.land = tomorrowland
        
        let autopia2 = Questions(entity: questionDescription!, insertInto: context)
        autopia2.questionTitle = "Autopia 2"
        autopia2.theQuestion = "What train station can you see from the Autopia queue? (One Word)"
        autopia2.correctAnswer = "Tomorrowland"
        autopia2.keyboardType = true
        autopia2.resultImage = greyMouse
        autopia2.answerBool = false
        autopia2.questionInt = 152
        autopia2.land = tomorrowland
        
        let autopia3 = Questions(entity: questionDescription!, insertInto: context)
        autopia3.questionTitle = "Autopia 3"
        autopia3.theQuestion = "How many different lanes are there on Autopia?"
        autopia3.correctAnswer = "4"
        autopia3.keyboardType = false
        autopia3.resultImage = greyMouse
        autopia3.answerBool = false
        autopia3.questionInt = 153
        autopia3.land = tomorrowland

        let autopia4 = Questions(entity: questionDescription!, insertInto: context)
        autopia4.questionTitle = "Autopia 4"
        autopia4.theQuestion = "Each lane has multiple stations where drivers can load and unload cars. On one lane how many stations can you load on?"
        autopia4.correctAnswer = "8"
        autopia4.keyboardType = false
        autopia4.resultImage = greyMouse
        autopia4.answerBool = false
        autopia4.questionInt = 154
        autopia4.land = tomorrowland
        
        let autopia5 = Questions(entity: questionDescription!, insertInto: context)
        autopia5.questionTitle = "Autopia 5"
        autopia5.theQuestion = "The queue buildings for Autopia are two shades of what color?"
        autopia5.correctAnswer = "blue"
        autopia5.keyboardType = true
        autopia5.resultImage = greyMouse
        autopia5.answerBool = false
        autopia5.questionInt = 155
        autopia5.land = tomorrowland
        
        let autopia6 = Questions(entity: questionDescription!, insertInto: context)
        autopia6.questionTitle = "Autopia 6"
        autopia6.theQuestion = "How many car lengths are you supposed to keep between you and the car ahead of you?"
        autopia6.correctAnswer = "1"
        autopia6.keyboardType = false
        autopia6.resultImage = greyMouse
        autopia6.answerBool = false
        autopia6.questionInt = 156
        autopia6.land = tomorrowland
        
        let autopia7 = Questions(entity: questionDescription!, insertInto: context)
        autopia7.questionTitle = "Autopia 7"
        autopia7.theQuestion = "How many inches tall do you have to be to drive alone on Autopia?"
        autopia7.correctAnswer = "54"
        autopia7.keyboardType = false
        autopia7.resultImage = greyMouse
        autopia7.answerBool = false
        autopia7.questionInt = 157
        autopia7.land = tomorrowland
        
        let autopia8 = Questions(entity: questionDescription!, insertInto: context)
        autopia8.questionTitle = "Autopia 8"
        autopia8.theQuestion = "When driving on Autopia one of the first signs you see reads, \"Hungry?... Fill it up! You'll be _______________ you did.\""
        autopia8.correctAnswer = "Tankful"
        autopia8.keyboardType = true
        autopia8.resultImage = greyMouse
        autopia8.answerBool = false
        autopia8.questionInt = 158
        autopia8.land = tomorrowland
        
        let autopia9 = Questions(entity: questionDescription!, insertInto: context)
        autopia9.questionTitle = "Autopia 9"
        autopia9.theQuestion = "According to the sign on the side of the road on Autopia, you are driving on Disneyland Route ____."
        autopia9.correctAnswer = "55"
        autopia9.keyboardType = false
        autopia9.resultImage = greyMouse
        autopia9.answerBool = false
        autopia9.questionInt = 159
        autopia9.land = tomorrowland
        
        let autopia10 = Questions(entity: questionDescription!, insertInto: context)
        autopia10.questionTitle = "Autopia 10"
        autopia10.theQuestion = "The Speed limit on Autopia is _.5 miles per hour."
        autopia10.correctAnswer = "6.5"
        autopia10.keyboardType = false
        autopia10.resultImage = greyMouse
        autopia10.answerBool = false
        autopia10.questionInt = 160
        autopia10.land = tomorrowland
        
        let autopia11 = Questions(entity: questionDescription!, insertInto: context)
        autopia11.questionTitle = "Autopia 11"
        autopia11.theQuestion = "When driving on Autopia you will see a sign that reads \"Birdbath _____________\" (one word)"
        autopia11.correctAnswer = "carwash"
        autopia11.keyboardType = true
        autopia11.resultImage = greyMouse
        autopia11.answerBool = false
        autopia11.questionInt = 161
        autopia11.land = tomorrowland
        
        let autopia12 = Questions(entity: questionDescription!, insertInto: context)
        autopia12.questionTitle = "Autopia 12"
        autopia12.theQuestion = "One Fantasyland friend has a statue replica of his car in the Autopia Car Park. Who owns car is the statue replicated after?"
        autopia12.correctAnswer = "Mr. Toad"
        autopia12.keyboardType = true
        autopia12.resultImage = greyMouse
        autopia12.answerBool = false
        autopia12.questionInt = 162
        autopia12.land = tomorrowland

        let autopia13 = Questions(entity: questionDescription!, insertInto: context)
        autopia13.questionTitle = "Autopia 13"
        autopia13.theQuestion = "What mountain do you drive past while on Autopia? (Two Words)"
        autopia13.correctAnswer = "Matterhorn Mountain"
        autopia13.keyboardType = true
        autopia13.resultImage = greyMouse
        autopia13.answerBool = false
        autopia13.questionInt = 163
        autopia13.land = tomorrowland
        
        let autopia14 = Questions(entity: questionDescription!, insertInto: context)
        autopia14.questionTitle = "Autopia 14"
        autopia14.theQuestion = "At the end of Autopia when you are sitting in Autopia traffic what under sea attraction is on your right? (Four Words)"
        autopia14.correctAnswer = "Finding Nemo Submarine Voyage"
        autopia14.keyboardType = true
        autopia14.resultImage = greyMouse
        autopia14.answerBool = false
        autopia14.questionInt = 164
        autopia14.land = tomorrowland
        
        //Space Mountain (201-250)
        let smTL1 = Questions(entity: questionDescription!, insertInto: context)
        smTL1.questionTitle = "Space Mountain 1"
        smTL1.theQuestion = "At the sign at the entrance to Space Mountain, what is between the Wait time and Return time signs? (1 word)"
        smTL1.correctAnswer = "clock"
        smTL1.keyboardType = true
        smTL1.resultImage = greyMouse
        smTL1.answerBool = false
        smTL1.questionInt = 201
        smTL1.land = tomorrowland
        
        let smTL2 = Questions(entity: questionDescription!, insertInto: context)
        smTL2.questionTitle = "Space Mountain 2"
        smTL2.theQuestion = "When given the safety spiel for Space Mountain you are told that \"Space Mountain is a roller coaster type ride in the dark, with sharp turns, sudden drops and _______\"."
        smTL2.correctAnswer = "stops"
        smTL2.keyboardType = true
        smTL2.resultImage = greyMouse
        smTL2.answerBool = false
        smTL2.questionInt = 202
        smTL2.land = tomorrowland
        
        let smTL3 = Questions(entity: questionDescription!, insertInto: context)
        smTL3.questionTitle = "Space Mountain 3"
        smTL3.theQuestion = "Just before you enter the area where you board the space ships on Space Mountain you walk through a corridor of airlocks. How many airlocks are there in this corridor?"
        smTL3.correctAnswer = "6"
        smTL3.keyboardType = false
        smTL3.resultImage = greyMouse
        smTL3.answerBool = false
        smTL3.questionInt = 203
        smTL3.land = tomorrowland
        
        let smTL4 = Questions(entity: questionDescription!, insertInto: context)
        smTL4.questionTitle = "Space Mountain 4"
        smTL4.theQuestion = "As you walk through the corridors leading to where you load your space ship you will see, written on the wall, that Space Mountain is Space Station number __."
        smTL4.correctAnswer = "77"
        smTL4.keyboardType = false
        smTL4.resultImage = greyMouse
        smTL4.answerBool = false
        smTL4.questionInt = 204
        smTL4.land = tomorrowland
        
        let smTL5 = Questions(entity: questionDescription!, insertInto: context)
        smTL5.questionTitle = "Space Mountain 5"
        smTL5.theQuestion = "There is a large spaceship secured to the ceiling above where you board your space ship on Space Mountain. How many thrusters are on the back of the ship?"
        smTL5.correctAnswer = "4"
        smTL5.keyboardType = false
        smTL5.resultImage = greyMouse
        smTL5.answerBool = false
        smTL5.questionInt = 205
        smTL5.land = tomorrowland

        let smTL6 = Questions(entity: questionDescription!, insertInto: context)
        smTL6.questionTitle = "Space Mountain 6"
        smTL6.theQuestion = "When loading Space Mountain, how many rows of seats are there?"
        smTL6.correctAnswer = "6"
        smTL6.keyboardType = false
        smTL6.resultImage = greyMouse
        smTL6.answerBool = false
        smTL6.questionInt = 206
        smTL6.land = tomorrowland
        
        let smTL7 = Questions(entity: questionDescription!, insertInto: context)
        smTL7.questionTitle = "Space Mountain 7"
        smTL7.theQuestion = "How many people can you fit per ride vehicle on Space Mountain?"
        smTL7.correctAnswer = "12"
        smTL7.keyboardType = false
        smTL7.resultImage = greyMouse
        smTL7.answerBool = false
        smTL7.questionInt = 207
        smTL7.land = tomorrowland
        
        let smTL8 = Questions(entity: questionDescription!, insertInto: context)
        smTL8.questionTitle = "Space Mountain 8"
        smTL8.theQuestion = "When riding Space Mountain you hear, \"You are cleared for ______________\""
        smTL8.correctAnswer = "Launch"
        smTL8.keyboardType = true
        smTL8.resultImage = greyMouse
        smTL8.answerBool = false
        smTL8.questionInt = 208
        smTL8.land = tomorrowland
        
        //Star Tours (251-300)
        let starTours1 = Questions(entity: questionDescription!, insertInto: context)
        starTours1.questionTitle = "Star Tours 1"
        starTours1.theQuestion = "The sign as you enter the queue to Star Tours reads \"Star Tours the ______________________\" (2 words)"
        starTours1.correctAnswer = "Adventures Continue"
        starTours1.keyboardType = true
        starTours1.resultImage = greyMouse
        starTours1.answerBool = false
        starTours1.questionInt = 251
        starTours1.land = tomorrowland
        
        let starTours2 = Questions(entity: questionDescription!, insertInto: context)
        starTours2.questionTitle = "Star Tours 2"
        starTours2.theQuestion = "What model number is the Star Speeder that C3PO and R2D2 are fixing in the queue?"
        starTours2.correctAnswer = "1000"
        starTours2.keyboardType = false
        starTours2.resultImage = greyMouse
        starTours2.answerBool = false
        starTours2.questionInt = 252
        starTours2.land = tomorrowland
        
        let starTours3 = Questions(entity: questionDescription!, insertInto: context)
        starTours3.questionTitle = "Star Tours 3"
        starTours3.theQuestion = "In the queue for Star Tours C3PO and R2D2 are fixing a red Star Speeder. The side of the Star Speeder pays homage to the old Star Tours by displaying the old flight number to Endor on its side. What was the flight number?"
        starTours3.correctAnswer = "1401"
        starTours3.keyboardType = false
        starTours3.resultImage = greyMouse
        starTours3.answerBool = false
        starTours3.questionInt = 253
        starTours3.land = tomorrowland

        let starTours4 = Questions(entity: questionDescription!, insertInto: context)
        starTours4.questionTitle = "Star Tours 4"
        starTours4.theQuestion = "A sign in the queue tells you \"_____ _____ required\"."
        starTours4.correctAnswer = "Flight Glasses"
        starTours4.keyboardType = true
        starTours4.resultImage = greyMouse
        starTours4.answerBool = false
        starTours4.questionInt = 254
        starTours4.land = tomorrowland
        
        let starTours5 = Questions(entity: questionDescription!, insertInto: context)
        starTours5.questionTitle = "Star Tours 5"
        starTours5.theQuestion = "In the Star Tours queue you will witness two security droids performing bag checks and screening. What is the name of the droid performing screening?"
        starTours5.correctAnswer = "G2-4T"
        starTours5.keyboardType = true
        starTours5.resultImage = greyMouse
        starTours5.answerBool = false
        starTours5.questionInt = 255
        starTours5.land = tomorrowland
        
        let starTours6 = Questions(entity: questionDescription!, insertInto: context)
        starTours6.questionTitle = "Star Tours 6"
        starTours6.theQuestion = "How many loading gates are in the concourse on Star Tours?"
        starTours6.correctAnswer = "4"
        starTours6.keyboardType = false
        starTours6.resultImage = greyMouse
        starTours6.answerBool = false
        starTours6.questionInt = 256
        starTours6.land = tomorrowland
        
        let starTours7 = Questions(entity: questionDescription!, insertInto: context)
        starTours7.questionTitle = "Star Tours 7"
        starTours7.theQuestion = "When riding Star Tours be careful.  You might be discovered as the ______________ and have your photo pop up on the screen. (2 words)"
        starTours7.correctAnswer = "Rebel Spy"
        starTours7.keyboardType = true
        starTours7.resultImage = greyMouse
        starTours7.answerBool = false
        starTours7.questionInt = 257
        starTours7.land = tomorrowland
        
        //Monorail (301-350)
        let monorail1 = Questions(entity: questionDescription!, insertInto: context)
        monorail1.questionTitle = "Monorail 1"
        monorail1.theQuestion = "How many stations does the Disneyland Monorail stop at?"
        monorail1.correctAnswer = "2"
        monorail1.keyboardType = false
        monorail1.resultImage = greyMouse
        monorail1.answerBool = false
        monorail1.questionInt = 301
        monorail1.land = tomorrowland
        
        let monorail2 = Questions(entity: questionDescription!, insertInto: context)
        monorail2.questionTitle = "Monorail 2"
        monorail2.theQuestion = "The trip from Tomorrowland Monorail Station to the Down Town Disney Monorail Station is _.5 miles according to the narration while riding the Monorail?"
        monorail2.correctAnswer = "2"
        monorail2.keyboardType = false
        monorail2.resultImage = greyMouse
        monorail2.answerBool = false
        monorail2.questionInt = 302
        monorail2.land = tomorrowland
        
        let monorail3 = Questions(entity: questionDescription!, insertInto: context)
        monorail3.questionTitle = "Monorail 3"
        monorail3.theQuestion = "According to the Narrator, what year was the Monorail introduced into the park?"
        monorail3.correctAnswer = "1959"
        monorail3.keyboardType = false
        monorail3.resultImage = greyMouse
        monorail3.answerBool = false
        monorail3.questionInt = 303
        monorail3.land = tomorrowland
        
        let monorail4 = Questions(entity: questionDescription!, insertInto: context)
        monorail4.questionTitle = "Monorail 4"
        monorail4.theQuestion = "According to the Narrator, Grizzly Peak is the /“_____ of Wonders/“."
        monorail4.correctAnswer = "Scenic"
        monorail4.keyboardType = true
        monorail4.resultImage = greyMouse
        monorail4.answerBool = false
        monorail4.questionInt = 304
        monorail4.land = tomorrowland
        
        //Food (351-400)
        
        let food1 = Questions(entity: questionDescription!, insertInto: context)
        food1.questionTitle = "Food 1"
        food1.theQuestion = "What is the name of the pizza restaurant in Tomorrowland?"
        food1.correctAnswer = "Redd Rockett's Pizza Port"
        food1.keyboardType = true
        food1.resultImage = greyMouse
        food1.answerBool = false
        food1.questionInt = 352
        food1.land = tomorrowland
        
        let food2 = Questions(entity: questionDescription!, insertInto: context)
        food2.questionTitle = "Food 2"
        food2.theQuestion = "Pizza Port has Pizza, _____, and Salad."
        food2.correctAnswer = "Pasta"
        food2.keyboardType = true
        food2.resultImage = greyMouse
        food2.answerBool = false
        food2.questionInt = 353
        food2.land = tomorrowland
        
        //Moonliner (401-450)
        
        let moonLiner1 = Questions(entity: questionDescription!, insertInto: context)
        moonLiner1.questionTitle = "Moonliner 1"
        moonLiner1.theQuestion = "On the Moonliner Rocket and under its name is written what three words?"
        moonLiner1.correctAnswer = "Spirit of Refreshment"
        moonLiner1.keyboardType  = true
        moonLiner1.resultImage = greyMouse
        moonLiner1.answerBool = false
        moonLiner1.questionInt = 401
        moonLiner1.land = tomorrowland
        
        let moonLiner2 = Questions(entity: questionDescription!, insertInto: context)
        moonLiner2.questionTitle = "Moonliner 2"
        moonLiner2.theQuestion = "The Moonliner Rocket Rocket is iconic because it pays tribute to what former Tomorrowland attraction?"
        moonLiner2.correctAnswer = "Rocket to the Moon"
        moonLiner2.keyboardType = true
        moonLiner2.resultImage = greyMouse
        moonLiner2.answerBool = false
        moonLiner2.questionInt = 402
        moonLiner2.land = tomorrowland
        
        //People Mover (451-500)
        
        let forgottenTrack = Questions(entity: questionDescription!, insertInto: context)
        forgottenTrack.questionTitle = "Forgotten Track"
        forgottenTrack.theQuestion = "What abandoned attraction’s track can you see running down the middle of Tomorrowland and by the Monorail Station? (The Original Attraction, Two Words)"
        forgottenTrack.correctAnswer = "People Mover"
        forgottenTrack.keyboardType = true
        forgottenTrack.resultImage = greyMouse
        forgottenTrack.answerBool = false
        forgottenTrack.questionInt = 451
        forgottenTrack.land = tomorrowland

        //Stores (501-550)
        
        let starTrader = Questions(entity: questionDescription!, insertInto: context)
        starTrader.questionTitle = "Star Trader"
        starTrader.theQuestion = "How many neon Mickeys are above the entrance to the Star Trader?"
        starTrader.correctAnswer = "9"
        starTrader.keyboardType = false
        starTrader.resultImage = greyMouse
        starTrader.answerBool = false
        starTrader.questionInt = 501
        starTrader.land = tomorrowland
        
        //Misc Tomorrowland (551-600)
        
        let games = Questions(entity: questionDescription!, insertInto: context)
        games.questionTitle = "Games"
        games.theQuestion = "What is the name of the video arcade in Tomorrowland?"
        games.correctAnswer = "Starcade"
        games.keyboardType = true
        games.resultImage = greyMouse
        games.answerBool = false
        games.questionInt = 551
        games.land = tomorrowland
        
        let stage = Questions(entity: questionDescription!, insertInto: context)
        stage.questionTitle = "Tomorrowland's Stage"
        stage.theQuestion = "What is the name of the restaurant and stage in Tomorrowland? (2 words)"
        stage.correctAnswer = "Tomorrowland Terrace"
        stage.keyboardType = true
        stage.resultImage = greyMouse
        stage.answerBool = false
        stage.questionInt = 552
        stage.land = tomorrowland
        
        let rocket = Questions(entity: questionDescription!, insertInto: context)
        rocket.questionTitle = "Rocket"
        rocket.theQuestion = "At Redd Rockett's Pizza Port there is a rocket outside.  What is written in bold on the rocket?"
        rocket.correctAnswer = "Moonliner"
        rocket.keyboardType = true
        rocket.resultImage = greyMouse
        rocket.answerBool = false
        rocket.questionInt = 553
        rocket.land = tomorrowland
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
// Frontierland!!!
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let frontierLand = Land(entity: landDescription!, insertInto: context)
        
        frontierLand.landName = "Frontierland"
        frontierLand.artWorkForLand = "Thunder Mountain.jpg"

        
        //Shooting Exposition (1-50)
        
        let shootingExposition1 = Questions(entity: questionDescription!, insertInto: context)
        shootingExposition1.questionTitle = "Shooting Exposition 1"
        shootingExposition1.theQuestion = "At the Shooting Exposition you will notice many headstones. One of which says Nancy Dan, a ___________ man. (Two Words)"
        shootingExposition1.correctAnswer = "truly devoted"
        shootingExposition1.keyboardType = true
        shootingExposition1.resultImage = greyMouse
        shootingExposition1.answerBool = false
        shootingExposition1.questionInt = 1
        shootingExposition1.land = frontierLand
        
        let shootingExposition2 = Questions(entity: questionDescription!, insertInto: context)
        shootingExposition2.questionTitle = "Shooting Exposition 2"
        shootingExposition2.theQuestion = "The sign for the Shooting Exposition has how many bullet holes in it?"
        shootingExposition2.correctAnswer = "21"
        shootingExposition2.keyboardType = false
        shootingExposition2.resultImage = greyMouse
        shootingExposition2.answerBool = false
        shootingExposition2.questionInt = 2
        shootingExposition2.land = frontierLand
        
        let shootingExposition3 = Questions(entity: questionDescription!, insertInto: context)
        shootingExposition3.questionTitle = "Shooting Exposition 3"
        shootingExposition3.theQuestion = "On the cliff on the left of the Shooting Exposition how many tarantula spiders are there?"
        shootingExposition3.correctAnswer = "3"
        shootingExposition3.keyboardType = false
        shootingExposition3.resultImage = greyMouse
        shootingExposition3.answerBool = false
        shootingExposition3.questionInt = 3
        shootingExposition3.land = frontierLand
        
        let shootingExposition4 = Questions(entity: questionDescription!, insertInto: context)
        shootingExposition4.questionTitle = "Shooting Exposition 4"
        shootingExposition4.theQuestion = "How many vultures do you see in the Shooting Exposition?"
        shootingExposition4.correctAnswer = "3"
        shootingExposition4.keyboardType = false
        shootingExposition4.resultImage = greyMouse
        shootingExposition4.answerBool = false
        shootingExposition4.questionInt = 4
        shootingExposition4.land = frontierLand
        
        let shootingExposition5 = Questions(entity: questionDescription!, insertInto: context)
        shootingExposition5.questionTitle = "Shooting Exposition 5"
        shootingExposition5.theQuestion = "How many crows do you see in the Shooting Exposition?"
        shootingExposition5.correctAnswer = "3"
        shootingExposition5.keyboardType = false
        shootingExposition5.resultImage = greyMouse
        shootingExposition5.answerBool = false
        shootingExposition5.questionInt = 5
        shootingExposition5.land = frontierLand
        
        let shootingExposition6 = Questions(entity: questionDescription!, insertInto: context)
        shootingExposition6.questionTitle = "Shooting Exposition 6"
        shootingExposition6.theQuestion = "How many cents does it cost to play at the Shooting Exposition?"
        shootingExposition6.correctAnswer = "50"
        shootingExposition6.keyboardType = false
        shootingExposition6.resultImage = greyMouse
        shootingExposition6.answerBool = false
        shootingExposition6.questionInt = 6
        shootingExposition6.land = frontierLand
        
        let shootingExposition7 = Questions(entity: questionDescription!, insertInto: context)
        shootingExposition7.questionTitle = "Shooting Exposition 7"
        shootingExposition7.theQuestion = "How many guns are at the Shooting Exposition?"
        shootingExposition7.correctAnswer = "18"
        shootingExposition7.keyboardType = false
        shootingExposition7.resultImage = greyMouse
        shootingExposition7.answerBool = false
        shootingExposition7.questionInt = 7
        shootingExposition7.land = frontierLand
        
        //Golden Horseshoe (51-100)
        let goldenHorseshoe1 = Questions(entity: questionDescription!, insertInto: context)
        goldenHorseshoe1.questionTitle = "Golden Horseshoe 1"
        goldenHorseshoe1.theQuestion = "Outside of the Golden Horseshoe Saloon is posted the names classic shows once performed in the Saloon and the Rules of the Saloon. According to the sign there is no Spitting, Gunfighting, Cussing, Gambling or ______ allowed."
        goldenHorseshoe1.correctAnswer = "Animals"
        goldenHorseshoe1.keyboardType = true
        goldenHorseshoe1.resultImage = greyMouse
        goldenHorseshoe1.answerBool = false
        goldenHorseshoe1.questionInt = 51
        goldenHorseshoe1.land = frontierLand
        
        let goldenHorseshoe2 = Questions(entity: questionDescription!, insertInto: context)
        goldenHorseshoe2.questionTitle = "Golden Horseshoe 2"
        goldenHorseshoe2.theQuestion = "According to the sign above the Golden Horseshoe Saloon, what year did it open?"
        goldenHorseshoe2.correctAnswer = "1871"
        goldenHorseshoe2.keyboardType = false
        goldenHorseshoe2.resultImage = greyMouse
        goldenHorseshoe2.answerBool = false
        goldenHorseshoe2.questionInt = 52
        goldenHorseshoe2.land = frontierLand

        let goldenHorseshoe3 = Questions(entity: questionDescription!, insertInto: context)
        goldenHorseshoe3.questionTitle = "Golden Horseshoe 3"
        goldenHorseshoe3.theQuestion = "Right above the stage in the Golden Horseshoe Saloon is a golden horseshoe adorned with diamonds. What color are they?"
        goldenHorseshoe3.correctAnswer = "red"
        goldenHorseshoe3.keyboardType = true
        goldenHorseshoe3.resultImage = greyMouse
        goldenHorseshoe3.answerBool = false
        goldenHorseshoe3.questionInt = 53
        goldenHorseshoe3.land = frontierLand
        
        let goldenHorseshoe4 = Questions(entity: questionDescription!, insertInto: context)
        goldenHorseshoe4.questionTitle = "Golden Horseshoe 4"
        goldenHorseshoe4.theQuestion = "How many pair of mounted bull horns adorn the Golden Horseshoe Saloon?"
        goldenHorseshoe4.correctAnswer = "13"
        goldenHorseshoe4.keyboardType = false
        goldenHorseshoe4.resultImage = greyMouse
        goldenHorseshoe4.answerBool = false
        goldenHorseshoe4.questionInt = 54
        goldenHorseshoe4.land = frontierLand
        
        let goldenHorseshoe5 = Questions(entity: questionDescription!, insertInto: context)
        goldenHorseshoe5.questionTitle = "Golden Horseshoe 5"
        goldenHorseshoe5.theQuestion = "How many diamonds are on the Golden Horseshoe that hangs above the stage?"
        goldenHorseshoe5.correctAnswer = "14"
        goldenHorseshoe5.keyboardType = false
        goldenHorseshoe5.resultImage = greyMouse
        goldenHorseshoe5.answerBool = false
        goldenHorseshoe5.questionInt = 55
        goldenHorseshoe5.land = frontierLand
        
        let goldenHorseshoe6 = Questions(entity: questionDescription!, insertInto: context)
        goldenHorseshoe6.questionTitle = "Golden Horseshoe 6"
        goldenHorseshoe6.theQuestion = "How many lights are on the stage floor in the Golden Horseshoe?"
        goldenHorseshoe6.correctAnswer = "10"
        goldenHorseshoe6.keyboardType = false
        goldenHorseshoe6.resultImage = greyMouse
        goldenHorseshoe6.answerBool = false
        goldenHorseshoe6.questionInt = 56
        goldenHorseshoe6.land = frontierLand
        
        let goldenHorseshoe7 = Questions(entity: questionDescription!, insertInto: context)
        goldenHorseshoe7.questionTitle = "Golden Horseshoe 7"
        goldenHorseshoe7.theQuestion = "Each of the chandeliers in the Golden Horseshoe contains how many oil lamps?"
        goldenHorseshoe7.correctAnswer = "6"
        goldenHorseshoe7.keyboardType = false
        goldenHorseshoe7.resultImage = greyMouse
        goldenHorseshoe7.answerBool = false
        goldenHorseshoe7.questionInt = 57
        goldenHorseshoe7.land = frontierLand
        
        //Mark Twain Riverboat (101-150)
        let markTwain1 = Questions(entity: questionDescription!, insertInto: context)
        markTwain1.questionTitle = "Mark Twain Riverboat 1"
        markTwain1.theQuestion = "The Mark Twain steamboat has two smoke stacks that are held together near the top of each by a bar with a golden symbol in the middle. What is this symbol?"
        markTwain1.correctAnswer = "star"
        markTwain1.keyboardType = true
        markTwain1.resultImage = greyMouse
        markTwain1.answerBool = false
        markTwain1.questionInt = 101
        markTwain1.land = frontierLand

        let markTwain2 = Questions(entity: questionDescription!, insertInto: context)
        markTwain2.questionTitle = "Mark Twain Riverboat 2"
        markTwain2.theQuestion = "While listening to the narration onboard the Mark Twain river boat you will hear what the narrator describes as the two sweetest words a river man can hear. What are they?"
        markTwain2.correctAnswer = "Mark Twain"
        markTwain2.keyboardType = true
        markTwain2.resultImage = greyMouse
        markTwain2.answerBool = false
        markTwain2.questionInt = 102
        markTwain2.land = frontierLand
        
        let markTwain3 = Questions(entity: questionDescription!, insertInto: context)
        markTwain3.questionTitle = "Mark Twain Riverboat 3"
        markTwain3.theQuestion = "How many passenger decks does the Mark Twain Riverboat have?"
        markTwain3.correctAnswer = "3"
        markTwain3.keyboardType = false
        markTwain3.resultImage = greyMouse
        markTwain3.answerBool = false
        markTwain3.questionInt = 103
        markTwain3.land = frontierLand
        
        let markTwain4 = Questions(entity: questionDescription!, insertInto: context)
        markTwain4.questionTitle = "Mark Twain Riverboat 4"
        markTwain4.theQuestion = "On the dock in Frontierland you will notice a crate for /“Becket & Paige Mercantile LTD/“. What year was this company established?"
        markTwain4.correctAnswer = "1883"
        markTwain4.keyboardType = false
        markTwain4.resultImage = greyMouse
        markTwain4.answerBool = false
        markTwain4.questionInt = 104
        markTwain4.land = frontierLand
        
        let markTwain5 = Questions(entity: questionDescription!, insertInto: context)
        markTwain5.questionTitle = "Mark Twain Riverboat 5"
        markTwain5.theQuestion = "How many cylinders push the paddles on the Mark Twain?"
        markTwain5.correctAnswer = "2"
        markTwain5.keyboardType = false
        markTwain5.resultImage = greyMouse
        markTwain5.answerBool = false
        markTwain5.questionInt = 105
        markTwain5.land = frontierLand
        
        let markTwain6 = Questions(entity: questionDescription!, insertInto: context)
        markTwain6.questionTitle = "Mark Twain Riverboat 6"
        markTwain6.theQuestion = "What color is the bell that is right infront of the Pilot House?"
        markTwain6.correctAnswer = "gold"
        markTwain6.keyboardType = true
        markTwain6.resultImage = greyMouse
        markTwain6.answerBool = false
        markTwain6.questionInt = 106
        markTwain6.land = frontierLand
        
        let markTwain7 = Questions(entity: questionDescription!, insertInto: context)
        markTwain7.questionTitle = "Mark Twain Riverboat 7"
        markTwain7.theQuestion = "How many red fire axes are onboard the Mark Twain?"
        markTwain7.correctAnswer = "6"
        markTwain7.keyboardType = false
        markTwain7.resultImage = greyMouse
        markTwain7.answerBool = false
        markTwain7.questionInt = 107
        markTwain7.land = frontierLand
        
        //The Sailing Ship Columbia (151-200)
        let sailingShip1 = Questions(entity: questionDescription!, insertInto: context)
        sailingShip1.questionTitle = "The Sailing Ship Columbia 1"
        sailingShip1.theQuestion = "The Sailing Ship Columbia flys an outdated version of the American Flag. How many stars are on this flag?"
        sailingShip1.correctAnswer = "13"
        sailingShip1.keyboardType = false
        sailingShip1.resultImage = greyMouse
        sailingShip1.answerBool = false
        sailingShip1.questionInt = 151
        sailingShip1.land = frontierLand

        let sailingShip2 = Questions(entity: questionDescription!, insertInto: context)
        sailingShip2.questionTitle = "The Sailing Ship Columbia 2"
        sailingShip2.theQuestion = "Look in the queue for the Sailing Ship Columbia for a sign that tells about the ship. What year did it make its Maiden Voyage?"
        sailingShip2.correctAnswer = "1787"
        sailingShip2.keyboardType = false
        sailingShip2.resultImage = greyMouse
        sailingShip2.answerBool = false
        sailingShip2.questionInt = 152
        sailingShip2.land = frontierLand
        
        let sailingShip3 = Questions(entity: questionDescription!, insertInto: context)
        sailingShip3.questionTitle = "The Sailing Ship Columbia 3"
        sailingShip3.theQuestion = "Looking at the sign in the queue for the Columbia, how many cannons does the ship have?"
        sailingShip3.correctAnswer = "10"
        sailingShip3.keyboardType = false
        sailingShip3.resultImage = greyMouse
        sailingShip3.answerBool = false
        sailingShip3.questionInt = 153
        sailingShip3.land = frontierLand
        
        let sailingShip4 = Questions(entity: questionDescription!, insertInto: context)
        sailingShip4.questionTitle = "The Sailing Ship Columbia 4"
        sailingShip4.theQuestion = "The total length of the Columbia is __ feet 6 inches."
        sailingShip4.correctAnswer = "83"
        sailingShip4.keyboardType = false
        sailingShip4.resultImage = greyMouse
        sailingShip4.answerBool = false
        sailingShip4.questionInt = 154
        sailingShip4.land = frontierLand
        
        //Frontierland Port (201-250)
        let frontierlandPort1 = Questions(entity: questionDescription!, insertInto: context)
        frontierlandPort1.questionTitle = "Frontierland Port 1"
        frontierlandPort1.theQuestion = "How many ships sail out of Frontierland's port?"
        frontierlandPort1.correctAnswer = "2"
        frontierlandPort1.keyboardType = false
        frontierlandPort1.resultImage = greyMouse
        frontierlandPort1.answerBool = false
        frontierlandPort1.questionInt = 201
        frontierlandPort1.land = frontierLand
        
        let frontierlandPort2 = Questions(entity: questionDescription!, insertInto: context)
        frontierlandPort2.questionTitle = "Frontierland Port 2"
        frontierlandPort2.theQuestion = "To get to the dock of the Mark Twain or the Columbia you must go through one of how many turnstiles?"
        frontierlandPort2.correctAnswer = "2"
        frontierlandPort2.keyboardType = false
        frontierlandPort2.resultImage = greyMouse
        frontierlandPort2.answerBool = false
        frontierlandPort2.questionInt = 202
        frontierlandPort2.land = frontierLand
        
        //Thunder Mountain (251-300)
        let thunderMountain1 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain1.questionTitle = "Thunder Mountain 1"
        thunderMountain1.theQuestion = "Thunder Mountain has 6 different trains. One of which is named \"I.B. ______\"."
        thunderMountain1.correctAnswer = "Hearty"
        thunderMountain1.keyboardType = true
        thunderMountain1.resultImage = greyMouse
        thunderMountain1.answerBool = false
        thunderMountain1.questionInt = 251
        thunderMountain1.land = frontierLand

        let thunderMountain2 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain2.questionTitle = "Thunder Mountain 2"
        thunderMountain2.theQuestion = "What is the name of the cute little town that is visible from the queue of Thunder Mountain?"
        thunderMountain2.correctAnswer = "Rainbow Ridge"
        thunderMountain2.keyboardType = true
        thunderMountain2.resultImage = greyMouse
        thunderMountain2.answerBool = false
        thunderMountain2.questionInt = 252
        thunderMountain2.land = frontierLand
        
        let thunderMountain3 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain3.questionTitle = "Thunder Mountain 3"
        thunderMountain3.theQuestion = "There is a large boulder hanging over the queue that is held up by how many support beams?"
        thunderMountain3.correctAnswer = "2"
        thunderMountain3.keyboardType = false
        thunderMountain3.resultImage = greyMouse
        thunderMountain3.answerBool = false
        thunderMountain3.questionInt = 253
        thunderMountain3.land = frontierLand
        
        let thunderMountain4 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain4.questionTitle = "Thunder Mountain 4"
        thunderMountain4.theQuestion = "While in the queue of Thunder Mountain you will notice an old steam engine with crates on it. What is this engine's number?"
        thunderMountain4.correctAnswer = "11"
        thunderMountain4.keyboardType = false
        thunderMountain4.resultImage = greyMouse
        thunderMountain4.answerBool = false
        thunderMountain4.questionInt = 254
        thunderMountain4.land = frontierLand
        
        let thunderMountain5 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain5.questionTitle = "Thunder Mountain 5"
        thunderMountain5.theQuestion = "On the old steam engine in the queue for Big Thunder Mountain there are a few pressure gauges. The gauge nearest the front of the locomotive reads approximately what pressure?"
        thunderMountain5.correctAnswer = "175"
        thunderMountain5.keyboardType = false
        thunderMountain5.resultImage = greyMouse
        thunderMountain5.answerBool = false
        thunderMountain5.questionInt = 255
        thunderMountain5.land = frontierLand
        
        let thunderMountain6 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain6.questionTitle = "Thunder Mountain 6"
        thunderMountain6.theQuestion = "What is the name of the dance hall in Rainbow Ridge? (Two Words)"
        thunderMountain6.correctAnswer = "Gold Nugget"
        thunderMountain6.keyboardType = true
        thunderMountain6.resultImage = greyMouse
        thunderMountain6.answerBool = false
        thunderMountain6.questionInt = 256
        thunderMountain6.land = frontierLand
        
        let thunderMountain7 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain7.questionTitle = "Thunder Mountain 7"
        thunderMountain7.theQuestion = "Under the General Mercantile sign in Rainbow Ridge it says \"Plain and Fancy ______ _______."
        thunderMountain7.correctAnswer = "Dry Goods"
        thunderMountain7.keyboardType = true
        thunderMountain7.resultImage = greyMouse
        thunderMountain7.answerBool = false
        thunderMountain7.questionInt = 257
        thunderMountain7.land = frontierLand
        
        let thunderMountain8 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain8.questionTitle = "Thunder Mountain 8"
        thunderMountain8.theQuestion = "Rainbow Ridge has a building that houses an \"Essay Office\". What year was this office established?"
        thunderMountain8.correctAnswer = "1809"
        thunderMountain8.keyboardType = false
        thunderMountain8.resultImage = greyMouse
        thunderMountain8.answerBool = false
        thunderMountain8.questionInt = 258
        thunderMountain8.land = frontierLand
        
        let thunderMountain9 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain9.questionTitle = "Thunder Mountain 9"
        thunderMountain9.theQuestion = "There is an Epitaph in Rainbow Ridge. What is its full name?"
        thunderMountain9.correctAnswer = "Big Thunder Epitaph"
        thunderMountain9.keyboardType = true
        thunderMountain9.resultImage = greyMouse
        thunderMountain9.answerBool = false
        thunderMountain9.questionInt = 259
        thunderMountain9.land = frontierLand
        
        let thunderMountain10 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain10.questionTitle = "Thunder Mountain 10"
        thunderMountain10.theQuestion = "Near the verticle mine shaft and in a few other places in the queue you will see a box labeled \"Jumbo Blasting Powder\" how many pounds does the box say that it weighs?"
        thunderMountain10.correctAnswer = "50"
        thunderMountain10.keyboardType = false
        thunderMountain10.resultImage = greyMouse
        thunderMountain10.answerBool = false
        thunderMountain10.questionInt = 260
        thunderMountain10.land = frontierLand
        
        let thunderMountain11 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain11.questionTitle = "Thunder Mountain 11"
        thunderMountain11.theQuestion = "The verticle mine shaft in the queue for Thunder Mountain has four levels listed on the side of it. What level is crossed off?"
        thunderMountain11.correctAnswer = "13"
        thunderMountain11.keyboardType = false
        thunderMountain11.resultImage = greyMouse
        thunderMountain11.answerBool = false
        thunderMountain11.questionInt = 261
        thunderMountain11.land = frontierLand
        
        let thunderMountain12 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain12.questionTitle = "Thunder Mountain 12"
        thunderMountain12.theQuestion = "In the queue of Thunder Mountain there is a sign pointing to different locations. How many miles away is \"Never mind\"?"
        thunderMountain12.correctAnswer = "79"
        thunderMountain12.keyboardType = false
        thunderMountain12.resultImage = greyMouse
        thunderMountain12.answerBool = false
        thunderMountain12.questionInt = 262
        thunderMountain12.land = frontierLand
        
        let thunderMountain13 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain13.questionTitle = "Thunder Mountain 13"
        thunderMountain13.theQuestion = "While standing in the queue of Thunder Mountain you will notice a dinosaur skeleton protruding from the rocks. How many large rib bones are protruding from the skeleton?"
        thunderMountain13.correctAnswer = "7"
        thunderMountain13.keyboardType = false
        thunderMountain13.resultImage = greyMouse
        thunderMountain13.answerBool = false
        thunderMountain13.questionInt = 263
        thunderMountain13.land = frontierLand
        
        let thunderMountain14 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain14.questionTitle = "Thunder Mountain 14"
        thunderMountain14.theQuestion = "How many dinosaur eggs are sitting near the tail of the dinosaur skeleton?"
        thunderMountain14.correctAnswer = "3"
        thunderMountain14.keyboardType = false
        thunderMountain14.resultImage = greyMouse
        thunderMountain14.answerBool = false
        thunderMountain14.questionInt = 264
        thunderMountain14.land = frontierLand
        
        let thunderMountain15 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain15.questionTitle = "Thunder Mountain 15"
        thunderMountain15.theQuestion = "How many mine cars are there per train on Thunder Mountain?"
        thunderMountain15.correctAnswer = "5"
        thunderMountain15.keyboardType = false
        thunderMountain15.resultImage = greyMouse
        thunderMountain15.answerBool = false
        thunderMountain15.questionInt = 265
        thunderMountain15.land = frontierLand

        let thunderMountain16 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain16.questionTitle = "Thunder Mountain 16"
        thunderMountain16.theQuestion = "How many rows of seats are there in one mine car?"
        thunderMountain16.correctAnswer = "3"
        thunderMountain16.keyboardType = false
        thunderMountain16.resultImage = greyMouse
        thunderMountain16.answerBool = false
        thunderMountain16.questionInt = 266
        thunderMountain16.land = frontierLand
        
        let thunderMountain17 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain17.questionTitle = "Thunder Mountain 17"
        thunderMountain17.theQuestion = "There are different colored lanterns in the mine to signal you of different dangers. A red latern tells you to \"Danger! ______ ______! Keep Out!\"."
        thunderMountain17.correctAnswer = "Blasting Zone"
        thunderMountain17.keyboardType = true
        thunderMountain17.resultImage = greyMouse
        thunderMountain17.answerBool = false
        thunderMountain17.questionInt = 267
        thunderMountain17.land = frontierLand
        
        let thunderMountain18 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain18.questionTitle = "Thunder Mountain 18"
        thunderMountain18.theQuestion = "What is the name of Engine 1 on Thunder Mountain?"
        thunderMountain18.correctAnswer = "I. B. Hearty"
        thunderMountain18.keyboardType = true
        thunderMountain18.resultImage = greyMouse
        thunderMountain18.answerBool = false
        thunderMountain18.questionInt = 268
        thunderMountain18.land = frontierLand
        
        let thunderMountain19 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain19.questionTitle = "Thunder Mountain 19"
        thunderMountain19.theQuestion = "At the end of Thunder Mountain you pass in front of the small town of Rainbow Ridge. What is the name of the saloon in Rainbow Ridge? (3 Words)"
        thunderMountain19.correctAnswer = "Big Thunder Saloon"
        thunderMountain19.keyboardType = true
        thunderMountain19.resultImage = greyMouse
        thunderMountain19.answerBool = false
        thunderMountain19.questionInt = 269
        thunderMountain19.land = frontierLand
        
        let thunderMountain20 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain20.questionTitle = "Thunder Mountain 20"
        thunderMountain20.theQuestion = "Thunder Mountain is known as \"the _______ ride in the wilderness\" according to the safety spiel heard just before boarding."
        thunderMountain20.correctAnswer = "Wildest"
        thunderMountain20.keyboardType = true
        thunderMountain20.resultImage = greyMouse
        thunderMountain20.answerBool = false
        thunderMountain20.questionInt = 270
        thunderMountain20.land = frontierLand
        
        let thunderMountain21 = Questions(entity: questionDescription!, insertInto: context)
        thunderMountain21.questionTitle = "Thunder Mountain 21"
        thunderMountain21.theQuestion = "At the beginning of Thunder Mountain you pass through a dark loud cave. What species of animal calls that cave home?"
        thunderMountain21.correctAnswer = "bats"
        thunderMountain21.keyboardType = true
        thunderMountain21.resultImage = greyMouse
        thunderMountain21.answerBool = false
        thunderMountain21.questionInt = 271
        thunderMountain21.land = frontierLand
        
        
        //Frontierland Stores (301-350)
        let flStores1 = Questions(entity: questionDescription!, insertInto: context)
        flStores1.questionTitle = "Frontierland Stores 1"
        flStores1.theQuestion = "Under what store's sign in Frontierland is there a statue of a Chief Indian?(exactly as written)"
        flStores1.correctAnswer = "Westward Ho Trading Co."
        flStores1.keyboardType = true
        flStores1.resultImage = greyMouse
        flStores1.answerBool = false
        flStores1.questionInt = 301
        flStores1.land = frontierLand
        
        let flStores2 = Questions(entity: questionDescription!, insertInto: context)
        flStores2.questionTitle = "Frontierland Stores 2"
        flStores2.theQuestion = "As you enter Frontierland you will see the Pioneer Mercantile Store. What year is written under it?"
        flStores2.correctAnswer = "1807"
        flStores2.keyboardType = false
        flStores2.resultImage = greyMouse
        flStores2.answerBool = false
        flStores2.questionInt = 302
        flStores2.land = frontierLand
        
        let flStores3 = Questions(entity: questionDescription!, insertInto: context)
        flStores3.questionTitle = "Frontierland Stores 3"
        flStores3.theQuestion = "What is the name of the hat supply company posted on the window of /“Crockett and Russel’s/“ store in Frontierland? (Spell as depicted)"
        flStores3.correctAnswer = "Coonskin Cap Supply Co."
        flStores3.keyboardType = true
        flStores3.resultImage = greyMouse
        flStores3.answerBool = false
        flStores3.questionInt = 303
        flStores3.land = frontierLand
        
        let flStores4 = Questions(entity: questionDescription!, insertInto: context)
        flStores4.questionTitle = "Frontierland Stores 4"
        flStores4.theQuestion = "Is \"Westward Ho Trading Co.\" to the right or the left of the Shooting Exposition?"
        flStores4.correctAnswer = "right"
        flStores4.keyboardType = true
        flStores4.resultImage = greyMouse
        flStores4.answerBool = false
        flStores4.questionInt = 304
        flStores4.land = frontierLand

        let flStores5 = Questions(entity: questionDescription!, insertInto: context)
        flStores5.questionTitle = "Frontierland Stores 5"
        flStores5.theQuestion = "Bonanza Outfitters sells Denims, Children’s wear, Shirts, ______, and Novelty wear"
        flStores5.correctAnswer = "Woolens"
        flStores5.keyboardType = true
        flStores5.resultImage = greyMouse
        flStores5.answerBool = false
        flStores5.questionInt = 305
        flStores5.land = frontierLand

        
        //Petrified Tree (351-400)
        let petrifiedTree1 = Questions(entity: questionDescription!, insertInto: context)
        petrifiedTree1.questionTitle = "Petrified Tree 1"
        petrifiedTree1.theQuestion = "The plaque on the petrified tree states that this section of the petrified tree weighs \"____\" tons."
        petrifiedTree1.correctAnswer = "5"
        petrifiedTree1.keyboardType = false
        petrifiedTree1.resultImage = greyMouse
        petrifiedTree1.answerBool = false
        petrifiedTree1.questionInt = 351
        petrifiedTree1.land = frontierLand
        
        let petrifiedTree2 = Questions(entity: questionDescription!, insertInto: context)
        petrifiedTree2.questionTitle = "Petrified Tree 2"
        petrifiedTree2.theQuestion = "The Petrified Tree given to Mrs. Walt Disney in September 1957 is from what forrest in Colorado? (Three Words)"
        petrifiedTree2.correctAnswer = "Pike Petrified Forest"
        petrifiedTree2.keyboardType = true
        petrifiedTree2.resultImage = greyMouse
        petrifiedTree2.answerBool = false
        petrifiedTree2.questionInt = 352
        petrifiedTree2.land = frontierLand
        
        
        //Misc Frontierland (401-450)
        let saloon = Questions(entity: questionDescription!, insertInto: context)
        saloon.questionTitle = "Saloon"
        saloon.theQuestion = "What is the name of the saloon in Frontierland (3 Words)"
        saloon.correctAnswer = "The Golden Horseshoe"
        saloon.keyboardType = true
        saloon.resultImage = greyMouse
        saloon.answerBool = false
        saloon.questionInt = 401
        saloon.land = frontierLand
        
        let theDonatedFlag = Questions(entity: questionDescription!, insertInto: context)
        theDonatedFlag.questionTitle = "The Donated Flag"
        theDonatedFlag.theQuestion = "Directly inside the gates of Frontierland is an American Flag that was donated to park in July of 1955. Who donated this flag?"
        theDonatedFlag.correctAnswer = "The American Human Association"
        theDonatedFlag.keyboardType = true
        theDonatedFlag.resultImage = greyMouse
        theDonatedFlag.answerBool = false
        theDonatedFlag.questionInt = 402
        theDonatedFlag.land = frontierLand
        
        let frontierlandFood = Questions(entity: questionDescription!, insertInto: context)
        frontierlandFood.questionTitle = "Frontierland Food"
        frontierlandFood.theQuestion = "There is a Mexican style restaurant in Frontierland. What is its name?"
        frontierlandFood.correctAnswer = "Rancho Del Zocalo"
        frontierlandFood.keyboardType = true
        frontierlandFood.resultImage = greyMouse
        frontierlandFood.answerBool = false
        frontierlandFood.questionInt = 403
        frontierlandFood.land = frontierLand
        
        let wildestTrash = Questions(entity: questionDescription!, insertInto: context)
        wildestTrash.questionTitle = "Wildest Trash in the Wilderness"
        wildestTrash.theQuestion = "Look at the trash cans in Frontierland. What material does the side of the trash can look like it is made out of?"
        wildestTrash.correctAnswer = "Wood"
        wildestTrash.keyboardType = true
        wildestTrash.resultImage = greyMouse
        wildestTrash.answerBool = false
        wildestTrash.questionInt = 404
        wildestTrash.land = frontierLand
        
        let frontierlandStreets = Questions(entity: questionDescription!, insertInto: context)
        frontierlandStreets.questionTitle = "Frontierland Streets"
        frontierlandStreets.theQuestion = "Between Frontierland and New Orleans Square there is a sign for a firework company named \"Laod Bhang and Co.\". What year was this company established?"
        frontierlandStreets.correctAnswer = "1845"
        frontierlandStreets.keyboardType = false
        frontierlandStreets.resultImage = greyMouse
        frontierlandStreets.answerBool = false
        frontierlandStreets.questionInt = 405
        frontierlandStreets.land = frontierLand
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//  Toon Town
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let toonTown = Land(entity: landDescription!, insertInto: context)
        
        toonTown.landName = "Toon Town"
        toonTown.artWorkForLand = "ToonTownCityHall.jpg"

        //Roger Rabbits cartoon Spin (1-50)
        
        let rogerRabbit1 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit1.questionTitle = "Roger Rabbit 1"
        rogerRabbit1.theQuestion = "What is the color of the building you enter for Roger Rabbit's Cartoon Spin?"
        rogerRabbit1.correctAnswer = "Red"
        rogerRabbit1.keyboardType = true
        rogerRabbit1.resultImage = greyMouse
        rogerRabbit1.answerBool = false
        rogerRabbit1.questionInt = 1
        rogerRabbit1.land = toonTown
        
        let rogerRabbit2 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit2.questionTitle = "Roger Rabbit 2"
        rogerRabbit2.theQuestion = "Behind the fastpass distribution for Roger Rabbit is a door for a company that went out of buisness. What is the fourth injury down that they say they cover?"
        rogerRabbit2.correctAnswer = "tnt disguised as cigars"
        rogerRabbit2.keyboardType = true
        rogerRabbit2.resultImage = greyMouse
        rogerRabbit2.answerBool = false
        rogerRabbit2.questionInt = 2
        rogerRabbit2.land = toonTown
        
        let rogerRabbit3 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit3.questionTitle = "Roger Rabbit 3"
        rogerRabbit3.theQuestion = "Right as you enter the building for Roger Rabbit's Cartoon Spin you will see a One Way sign. How many ways does it point?"
        rogerRabbit3.correctAnswer = "2"
        rogerRabbit3.keyboardType = false
        rogerRabbit3.resultImage = greyMouse
        rogerRabbit3.answerBool = false
        rogerRabbit3.questionInt = 3
        rogerRabbit3.land = toonTown
        
        let rogerRabbit4 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit4.questionTitle = "Roger Rabbit 4"
        rogerRabbit4.theQuestion = "Look for a fan on a desk near where you board your cab. How many blades does the fan have on it?"
        rogerRabbit4.correctAnswer = "4"
        rogerRabbit4.keyboardType = false
        rogerRabbit4.resultImage = greyMouse
        rogerRabbit4.answerBool = false
        rogerRabbit4.questionInt = 4
        rogerRabbit4.land = toonTown
        
        let rogerRabbit5 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit5.questionTitle = "Roger Rabbit 5"
        rogerRabbit5.theQuestion = "The filing cabinet near the desk near where you board the cabs has three drawers. The top drawer hold files that are A-_."
        rogerRabbit5.correctAnswer = "L"
        rogerRabbit5.keyboardType = true
        rogerRabbit5.resultImage = greyMouse
        rogerRabbit5.answerBool = false
        rogerRabbit5.questionInt = 5
        rogerRabbit5.land = toonTown
        
        let rogerRabbit6 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit6.questionTitle = "Roger Rabbit 6"
        rogerRabbit6.theQuestion = "In the queue of Roger Rabbit's Cartoon Spin you will see a figure walk back and forth behind a window. Who is this figure?"
        rogerRabbit6.correctAnswer = "Jessica Rabbit"
        rogerRabbit6.keyboardType = true
        rogerRabbit6.resultImage = greyMouse
        rogerRabbit6.answerBool = false
        rogerRabbit6.questionInt = 6
        rogerRabbit6.land = toonTown
        
        let rogerRabbit7 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit7.questionTitle = "Roger Rabbit 7"
        rogerRabbit7.theQuestion = "What is the name on the license plate of all of the cabs?"
        rogerRabbit7.correctAnswer = "Lenny"
        rogerRabbit7.keyboardType = true
        rogerRabbit7.resultImage = greyMouse
        rogerRabbit7.answerBool = false
        rogerRabbit7.questionInt = 7
        rogerRabbit7.land = toonTown
        
        let rogerRabbit8 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit8.questionTitle = "Roger Rabbit 8"
        rogerRabbit8.theQuestion = "What is the speed limit posted as you enter the queue for Roger Rabbit?"
        rogerRabbit8.correctAnswer = "40"
        rogerRabbit8.keyboardType = false
        rogerRabbit8.resultImage = greyMouse
        rogerRabbit8.answerBool = false
        rogerRabbit8.questionInt = 8
        rogerRabbit8.land = toonTown
        
        let rogerRabbit9 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit9.questionTitle = "Roger Rabbit 9"
        rogerRabbit9.theQuestion = "According to a reminder in the queue of Roger Rabbit's Cartoon Spin you are supposed to \"Get Hip- Don't Get _____ ____\"."
        rogerRabbit9.correctAnswer = "the dip"
        rogerRabbit9.keyboardType = true
        rogerRabbit9.resultImage = greyMouse
        rogerRabbit9.answerBool = false
        rogerRabbit9.questionInt = 9
        rogerRabbit9.land = toonTown
        
        let rogerRabbit10 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit10.questionTitle = "Roger Rabbit 10"
        rogerRabbit10.theQuestion = "How are you supposed to handle \"The Dip\"? (3 words)"
        rogerRabbit10.correctAnswer = "With Extreme Caution"
        rogerRabbit10.keyboardType = true
        rogerRabbit10.resultImage = greyMouse
        rogerRabbit10.answerBool = false
        rogerRabbit10.questionInt = 10
        rogerRabbit10.land = toonTown
        
        let rogerRabbit11 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit11.questionTitle = "Roger Rabbit 11"
        rogerRabbit11.theQuestion = "One sign you see will tell you to \"Toon up with ______ for miles of smiles\"."
        rogerRabbit11.correctAnswer = "Toonzoil"
        rogerRabbit11.keyboardType = true
        rogerRabbit11.resultImage = greyMouse
        rogerRabbit11.answerBool = false
        rogerRabbit11.questionInt = 11
        rogerRabbit11.land = toonTown
        
        let rogerRabbit12 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit12.questionTitle = "Roger Rabbit 12"
        rogerRabbit12.theQuestion = "How many darts are in the dartboard that is visible right as you board the cabs?"
        rogerRabbit12.correctAnswer = "2"
        rogerRabbit12.keyboardType = false
        rogerRabbit12.resultImage = greyMouse
        rogerRabbit12.answerBool = false
        rogerRabbit12.questionInt = 12
        rogerRabbit12.land = toonTown
        
        let rogerRabbit13 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit13.questionTitle = "Roger Rabbit 13"
        rogerRabbit13.theQuestion = "In the attraction look for a store selling apples. What type of apples are they selling?"
        rogerRabbit13.correctAnswer = "wishing apples"
        rogerRabbit13.keyboardType = true
        rogerRabbit13.resultImage = greyMouse
        rogerRabbit13.answerBool = false
        rogerRabbit13.questionInt = 13
        rogerRabbit13.land = toonTown
        
        let rogerRabbit14 = Questions(entity: questionDescription!, insertInto: context)
        rogerRabbit14.questionTitle = "Roger Rabbit 14"
        rogerRabbit14.theQuestion = "What is the name of the China shop you crash through while on Roger Rabbit?"
        rogerRabbit14.correctAnswer = "Bullina"
        rogerRabbit14.keyboardType = true
        rogerRabbit14.resultImage = greyMouse
        rogerRabbit14.answerBool = false
        rogerRabbit14.questionInt = 14
        rogerRabbit14.land = toonTown
        
        //Mickeys House (51-100)
        
        let mickeysHouse1 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse1.questionTitle = "Mickey's House 1"
        mickeysHouse1.theQuestion = "Right inside the door to Mickey's house is a table with some of Mickey's mail on it. The bottom letter is from the office of who?"
        mickeysHouse1.correctAnswer = "The President"
        mickeysHouse1.keyboardType = true
        mickeysHouse1.resultImage = greyMouse
        mickeysHouse1.answerBool = false
        mickeysHouse1.questionInt = 51
        mickeysHouse1.land = toonTown
        
        let mickeysHouse2 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse2.questionTitle = "Mickey's House 2"
        mickeysHouse2.theQuestion = "What company makes the doggi door that Pluto uses to go upstairs in Mickey's house?"
        mickeysHouse2.correctAnswer = "Ace Doggi Door"
        mickeysHouse2.keyboardType = true
        mickeysHouse2.resultImage = greyMouse
        mickeysHouse2.answerBool = false
        mickeysHouse2.questionInt = 52
        mickeysHouse2.land = toonTown
        
        let mickeysHouse3 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse3.questionTitle = "Mickey's House 3"
        mickeysHouse3.theQuestion = "Mickey has a suitcase sticking out of his closet under his stair case. There are stickers from Paris and _____"
        mickeysHouse3.correctAnswer = "Japan"
        mickeysHouse3.keyboardType = true
        mickeysHouse3.resultImage = greyMouse
        mickeysHouse3.answerBool = false
        mickeysHouse3.questionInt = 53
        mickeysHouse3.land = toonTown
        
        let mickeysHouse4 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse4.questionTitle = "Mickey's House 4"
        mickeysHouse4.theQuestion = "In Mickey's living room is a cabinet with a baseball in it from the Toon Town little league. Who is it written that the baseball is to?"
        mickeysHouse4.correctAnswer = "Coach Mickey"
        mickeysHouse4.keyboardType = true
        mickeysHouse4.resultImage = greyMouse
        mickeysHouse4.answerBool = false
        mickeysHouse4.questionInt = 54
        mickeysHouse4.land = toonTown
        
        let mickeysHouse5 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse5.questionTitle = "Mickey's House 5"
        mickeysHouse5.theQuestion = "In a cabinet in Mickey's living room there is a book entitled _____ __ _____."
        mickeysHouse5.correctAnswer = "Mouse of Cards"
        mickeysHouse5.keyboardType = true
        mickeysHouse5.resultImage = greyMouse
        mickeysHouse5.answerBool = false
        mickeysHouse5.questionInt = 55
        mickeysHouse5.land = toonTown
        
        let mickeysHouse6 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse6.questionTitle = "Mickey's House 6"
        mickeysHouse6.theQuestion = "Mickey has a Steamboat in a bottle in his living room. What is the name of this boat?"
        mickeysHouse6.correctAnswer = "Steamboat Willie"
        mickeysHouse6.keyboardType = true
        mickeysHouse6.resultImage = greyMouse
        mickeysHouse6.answerBool = false
        mickeysHouse6.questionInt = 56
        mickeysHouse6.land = toonTown
        
        let mickeysHouse7 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse7.questionTitle = "Mickey's House 7"
        mickeysHouse7.theQuestion = "Mickey has 4 books on the mantel above his fireplace in his living room. What is the name of the green book on the right?"
        mickeysHouse7.correctAnswer = "The Wonder Ears"
        mickeysHouse7.keyboardType = true
        mickeysHouse7.resultImage = greyMouse
        mickeysHouse7.answerBool = false
        mickeysHouse7.questionInt = 57
        mickeysHouse7.land = toonTown
        
        let mickeysHouse8 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse8.questionTitle = "Mickey's House 8"
        mickeysHouse8.theQuestion = "Near Mickey's telephone is his membership card to the Mickey Mouse Club. What is his membership number?"
        mickeysHouse8.correctAnswer = "000001"
        mickeysHouse8.keyboardType = false
        mickeysHouse8.resultImage = greyMouse
        mickeysHouse8.answerBool = false
        mickeysHouse8.questionInt = 58
        mickeysHouse8.land = toonTown
        
        let mickeysHouse9 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse9.questionTitle = "Mickey's House 9"
        mickeysHouse9.theQuestion = "On the cork board near Mickey's phone is a letter from Minnie reminding him of their dinner date on what night?"
        mickeysHouse9.correctAnswer = "Sunday"
        mickeysHouse9.keyboardType = true
        mickeysHouse9.resultImage = greyMouse
        mickeysHouse9.answerBool = false
        mickeysHouse9.questionInt = 59
        mickeysHouse9.land = toonTown
        
        let mickeysHouse10 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse10.questionTitle = "Mickey's House 10"
        mickeysHouse10.theQuestion = "According to the note from Dr. Drillum on Mickey's cork board it't time for his annual cleaning! The phone number to Dr. Drillum's office is 4-____"
        mickeysHouse10.correctAnswer = "7883"
        mickeysHouse10.keyboardType = false
        mickeysHouse10.resultImage = greyMouse
        mickeysHouse10.answerBool = false
        mickeysHouse10.questionInt = 60
        mickeysHouse10.land = toonTown
        
        let mickeysHouse11 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse11.questionTitle = "Mickey's House 11"
        mickeysHouse11.theQuestion = "Goofy left Mickey a note saying he would be running the projector in Mickey's Movie Barn with who?"
        mickeysHouse11.correctAnswer = "Donald"
        mickeysHouse11.keyboardType = true
        mickeysHouse11.resultImage = greyMouse
        mickeysHouse11.answerBool = false
        mickeysHouse11.questionInt = 61
        mickeysHouse11.land = toonTown
        
        let mickeysHouse12 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse12.questionTitle = "Mickey's House 12"
        mickeysHouse12.theQuestion = "Inside of Mickey Mouse's house look for Mickey's Passport. What is his passport number?"
        mickeysHouse12.correctAnswer = "033110756"
        mickeysHouse12.keyboardType = false
        mickeysHouse12.resultImage = greyMouse
        mickeysHouse12.answerBool = false
        mickeysHouse12.questionInt = 62
        mickeysHouse12.land = toonTown
        
        let mickeysHouse13 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse13.questionTitle = "Mickey's House 13"
        mickeysHouse13.theQuestion = "There is a note on the cork board from the Brave Little Tailor Shop of Toontown that tells Mickey to pick up how many pairs of red shorts on Thursday?"
        mickeysHouse13.correctAnswer = "24"
        mickeysHouse13.keyboardType = false
        mickeysHouse13.resultImage = greyMouse
        mickeysHouse13.answerBool = false
        mickeysHouse13.questionInt = 63
        mickeysHouse13.land = toonTown
        
        let mickeysHouse14 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse14.questionTitle = "Mickey's House 14"
        mickeysHouse14.theQuestion = "Mickey's phone number is written near the yellow telephone in his living room. What are the last four digits of his phone number?"
        mickeysHouse14.correctAnswer = "5677"
        mickeysHouse14.keyboardType = false
        mickeysHouse14.resultImage = greyMouse
        mickeysHouse14.answerBool = false
        mickeysHouse14.questionInt = 64
        mickeysHouse14.land = toonTown
        
        let mickeysHouse15 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse15.questionTitle = "Mickey's House 15"
        mickeysHouse15.theQuestion = "Mickey has a self playing piano in his living room. What is the name of the company that manufactured the piano?"
        mickeysHouse15.correctAnswer = "Mouse Way"
        mickeysHouse15.keyboardType = true
        mickeysHouse15.resultImage = greyMouse
        mickeysHouse15.answerBool = false
        mickeysHouse15.questionInt = 65
        mickeysHouse15.land = toonTown
        
        let mickeysHouse16 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse16.questionTitle = "Mickey's House 16"
        mickeysHouse16.theQuestion = "The notes on the sheet music that is being played on Mickey's piano are in the shape of what mouse's head?"
        mickeysHouse16.correctAnswer = "Mickey"
        mickeysHouse16.keyboardType = true
        mickeysHouse16.resultImage = greyMouse
        mickeysHouse16.answerBool = false
        mickeysHouse16.questionInt = 66
        mickeysHouse16.land = toonTown
        
        let mickeysHouse17 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse17.questionTitle = "Mickey's House 17"
        mickeysHouse17.theQuestion = "In Mickey's Television room is a dart board. How many darts have hit the dartboard?"
        mickeysHouse17.correctAnswer = "0"
        mickeysHouse17.keyboardType = false
        mickeysHouse17.resultImage = greyMouse
        mickeysHouse17.answerBool = false
        mickeysHouse17.questionInt = 67
        mickeysHouse17.land = toonTown
        
        let mickeysHouse18 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse18.questionTitle = "Mickey's House 18"
        mickeysHouse18.theQuestion = "How many darts have missed the dartboard?"
        mickeysHouse18.correctAnswer = "8"
        mickeysHouse18.keyboardType = false
        mickeysHouse18.resultImage = greyMouse
        mickeysHouse18.answerBool = false
        mickeysHouse18.questionInt = 68
        mickeysHouse18.land = toonTown
        
        let mickeysHouse19 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse19.questionTitle = "Mickey's House 19"
        mickeysHouse19.theQuestion = "Right before you enter Mickey's garden you will see his overalls hanging on a nail. What company makes his overalls?"
        mickeysHouse19.correctAnswer = "Mousekosh"
        mickeysHouse19.keyboardType = true
        mickeysHouse19.resultImage = greyMouse
        mickeysHouse19.answerBool = false
        mickeysHouse19.questionInt = 69
        mickeysHouse19.land = toonTown
        
        let mickeysHouse20 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse20.questionTitle = "Mickey's House 20"
        mickeysHouse20.theQuestion = "How many yellow trashcans does Mickey have in his garage?"
        mickeysHouse20.correctAnswer = "3"
        mickeysHouse20.keyboardType = false
        mickeysHouse20.resultImage = greyMouse
        mickeysHouse20.answerBool = false
        mickeysHouse20.questionInt = 70
        mickeysHouse20.land = toonTown
        
        let mickeysHouse21 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse21.questionTitle = "Mickey's House 21"
        mickeysHouse21.theQuestion = "How many cans of paint are in Mickey's garage?"
        mickeysHouse21.correctAnswer = "11"
        mickeysHouse21.keyboardType = false
        mickeysHouse21.resultImage = greyMouse
        mickeysHouse21.answerBool = false
        mickeysHouse21.questionInt = 71
        mickeysHouse21.land = toonTown
        
        let mickeysHouse22 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse22.questionTitle = "Mickey's House 22"
        mickeysHouse22.theQuestion = "Along with the cans of paint cans in Mickey's garage he also has some paint brushes. How many paint brushes are there?"
        mickeysHouse22.correctAnswer = "5"
        mickeysHouse22.keyboardType = false
        mickeysHouse22.resultImage = greyMouse
        mickeysHouse22.answerBool = false
        mickeysHouse22.questionInt = 72
        mickeysHouse22.land = toonTown
        
        let mickeysHouse23 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse23.questionTitle = "Mickey's House 23"
        mickeysHouse23.theQuestion = "Mickey has decided to park his car outside of his house. What color is his car?"
        mickeysHouse23.correctAnswer = "red"
        mickeysHouse23.keyboardType = true
        mickeysHouse23.resultImage = greyMouse
        mickeysHouse23.answerBool = false
        mickeysHouse23.questionInt = 73
        mickeysHouse23.land = toonTown
        
        let mickeysHouse24 = Questions(entity: questionDescription!, insertInto: context)
        mickeysHouse24.questionTitle = "Mickey's House 24"
        mickeysHouse24.theQuestion = "What is the license plate number of Mickey's car?"
        mickeysHouse24.correctAnswer = "Mickey 1"
        mickeysHouse24.keyboardType = true
        mickeysHouse24.resultImage = greyMouse
        mickeysHouse24.answerBool = false
        mickeysHouse24.questionInt = 74
        mickeysHouse24.land = toonTown
        
        //Goofys House (101-150)
        let goofysHouse1 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse1.questionTitle = "Goofy's House 1"
        goofysHouse1.theQuestion = "What is the main color of Goofy's House?"
        goofysHouse1.correctAnswer = "blue"
        goofysHouse1.keyboardType = true
        goofysHouse1.resultImage = greyMouse
        goofysHouse1.answerBool = false
        goofysHouse1.questionInt = 101
        goofysHouse1.land = toonTown
        
        let goofysHouse2 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse2.questionTitle = "Goofy's House 2"
        goofysHouse2.theQuestion = "In Goofy's House is a piece of sheet music called \"Silly Scales in the Key of ______\"."
        goofysHouse2.correctAnswer = "G"
        goofysHouse2.keyboardType = true
        goofysHouse2.resultImage = greyMouse
        goofysHouse2.answerBool = false
        goofysHouse2.questionInt = 102
        goofysHouse2.land = toonTown
        
        let goofysHouse3 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse3.questionTitle = "Goofy's House 3"
        goofysHouse3.theQuestion = "How many pieces of mail does Goofy have in the mailbox out in front of his house?"
        goofysHouse3.correctAnswer = "3"
        goofysHouse3.keyboardType = false
        goofysHouse3.resultImage = greyMouse
        goofysHouse3.answerBool = false
        goofysHouse3.questionInt = 103
        goofysHouse3.land = toonTown
        
        let goofysHouse4 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse4.questionTitle = "Goofy's House 4"
        goofysHouse4.theQuestion = "What is the color of Goofy's Jalopy outside of his house?"
        goofysHouse4.correctAnswer = "green"
        goofysHouse4.keyboardType = true
        goofysHouse4.resultImage = greyMouse
        goofysHouse4.answerBool = false
        goofysHouse4.questionInt = 104
        goofysHouse4.land = toonTown
        
        let goofysHouse5 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse5.questionTitle = "Goofy's House 5"
        goofysHouse5.theQuestion = "What color of bird is sitting on top of the scarecrow at Goofy's House?"
        goofysHouse5.correctAnswer = "black"
        goofysHouse5.keyboardType = true
        goofysHouse5.resultImage = greyMouse
        goofysHouse5.answerBool = false
        goofysHouse5.questionInt = 105
        goofysHouse5.land = toonTown
        
        let goofysHouse6 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse6.questionTitle = "Goofy's House 6"
        goofysHouse6.theQuestion = "How many pictures are in Goofy's House?"
        goofysHouse6.correctAnswer = "9"
        goofysHouse6.keyboardType = false
        goofysHouse6.resultImage = greyMouse
        goofysHouse6.answerBool = false
        goofysHouse6.questionInt = 106
        goofysHouse6.land = toonTown
        
        let goofysHouse7 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse7.questionTitle = "Goofy's House 7"
        goofysHouse7.theQuestion = "Goofy has a large ____ gun above his piano."
        goofysHouse7.correctAnswer = "cork"
        goofysHouse7.keyboardType = true
        goofysHouse7.resultImage = greyMouse
        goofysHouse7.answerBool = false
        goofysHouse7.questionInt = 107
        goofysHouse7.land = toonTown
        
        let goofysHouse8 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse8.questionTitle = "Goofy's House 8"
        goofysHouse8.theQuestion = "Goofy has a kite in his house. What color is it?"
        goofysHouse8.correctAnswer = "orange"
        goofysHouse8.keyboardType = true
        goofysHouse8.resultImage = greyMouse
        goofysHouse8.answerBool = false
        goofysHouse8.questionInt = 108
        goofysHouse8.land = toonTown
        
        let goofysHouse9 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse9.questionTitle = "Goofy's House 9"
        goofysHouse9.theQuestion = "What color is the sofa in Goofy's House?"
        goofysHouse9.correctAnswer = "blue"
        goofysHouse9.keyboardType = true
        goofysHouse9.resultImage = greyMouse
        goofysHouse9.answerBool = false
        goofysHouse9.questionInt = 109
        goofysHouse9.land = toonTown
        
        let goofysHouse10 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse10.questionTitle = "Goofy's House 10"
        goofysHouse10.theQuestion = "There is a shark mounted on Goofy's wall with a pair of Goofy's underwear in its mouth. What pattern are his underwear?"
        goofysHouse10.correctAnswer = "polka dot"
        goofysHouse10.keyboardType = true
        goofysHouse10.resultImage = greyMouse
        goofysHouse10.answerBool = false
        goofysHouse10.questionInt = 110
        goofysHouse10.land = toonTown
        
        let goofysHouse11 = Questions(entity: questionDescription!, insertInto: context)
        goofysHouse11.questionTitle = "Goofy's House 11"
        goofysHouse11.theQuestion = "How many letters are in the mailbox outside of Goofy's House?"
        goofysHouse11.correctAnswer = "3"
        goofysHouse11.keyboardType = false
        goofysHouse11.resultImage = greyMouse
        goofysHouse11.answerBool = false
        goofysHouse11.questionInt = 111
        goofysHouse11.land = toonTown
        
        //Minnies House (151-200)
        let minniesHouse1 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse1.questionTitle = "Minnie's House 1"
        minniesHouse1.theQuestion = "On one of the arm chairs in Minnie's house there is a magazine with the title \"Jessica's __________\"."
        minniesHouse1.correctAnswer = "Secret"
        minniesHouse1.keyboardType = true
        minniesHouse1.resultImage = greyMouse
        minniesHouse1.answerBool = false
        minniesHouse1.questionInt = 151
        minniesHouse1.land = toonTown
        
        let minniesHouse2 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse2.questionTitle = "Minnie's House 2"
        minniesHouse2.theQuestion = "Minnie Mouse has a rotary telephone in her house. How many holes are on the rotary part of the phone?"
        minniesHouse2.correctAnswer = "10"
        minniesHouse2.keyboardType = false
        minniesHouse2.resultImage = greyMouse
        minniesHouse2.answerBool = false
        minniesHouse2.questionInt = 152
        minniesHouse2.land = toonTown
        
        let minniesHouse3 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse3.questionTitle = "Minnie's House 3"
        minniesHouse3.theQuestion = "What is the color of the radio in Minnie's living room?"
        minniesHouse3.correctAnswer = "purple"
        minniesHouse3.keyboardType = true
        minniesHouse3.resultImage = greyMouse
        minniesHouse3.answerBool = false
        minniesHouse3.questionInt = 153
        minniesHouse3.land = toonTown
        
        let minniesHouse4 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse4.questionTitle = "Minnie's House 4"
        minniesHouse4.theQuestion = "How many books does Minnie have on a shelf in her living room?"
        minniesHouse4.correctAnswer = "7"
        minniesHouse4.keyboardType = false
        minniesHouse4.resultImage = greyMouse
        minniesHouse4.answerBool = false
        minniesHouse4.questionInt = 154
        minniesHouse4.land = toonTown

        let minniesHouse5 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse5.questionTitle = "Minnie's House 5"
        minniesHouse5.theQuestion = "What is the title of the thickest book on Minnie's book shelf?"
        minniesHouse5.correctAnswer = "Cheese and Remembrance"
        minniesHouse5.keyboardType = true
        minniesHouse5.resultImage = greyMouse
        minniesHouse5.answerBool = false
        minniesHouse5.questionInt = 155
        minniesHouse5.land = toonTown
        
        let minniesHouse6 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse6.questionTitle = "Minnie's House 6"
        minniesHouse6.theQuestion = "How many candles are on the candle stick above Minnie's fireplace?"
        minniesHouse6.correctAnswer = "2"
        minniesHouse6.keyboardType = false
        minniesHouse6.resultImage = greyMouse
        minniesHouse6.answerBool = false
        minniesHouse6.questionInt = 156
        minniesHouse6.land = toonTown
        
        let minniesHouse7 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse7.questionTitle = "Minnie's House 7"
        minniesHouse7.theQuestion = "In Minnie's makesup room there are some roses on an end table. How many roses are there?"
        minniesHouse7.correctAnswer = "3"
        minniesHouse7.keyboardType = false
        minniesHouse7.resultImage = greyMouse
        minniesHouse7.questionInt = 157
        minniesHouse7.answerBool = false
        minniesHouse7.land = toonTown
        
        let minniesHouse8 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse8.questionTitle = "Minnie's House 8"
        minniesHouse8.theQuestion = "What company made the fridge in Minnie's kitchen?"
        minniesHouse8.correctAnswer = "Cheesemore"
        minniesHouse8.keyboardType = true
        minniesHouse8.resultImage = greyMouse
        minniesHouse8.answerBool = false
        minniesHouse8.questionInt = 158
        minniesHouse8.land = toonTown
        
        let minniesHouse9 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse9.questionTitle = "Minnie's House 9"
        minniesHouse9.theQuestion = "Minnie has a shopping list on the outside of her fridge. How many items are on her list?"
        minniesHouse9.correctAnswer = "23"
        minniesHouse9.keyboardType = false
        minniesHouse9.resultImage = greyMouse
        minniesHouse9.answerBool = false
        minniesHouse9.questionInt = 159
        minniesHouse9.land = toonTown
        
        let minniesHouse10 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse10.questionTitle = "Minnie's House 10"
        minniesHouse10.theQuestion = "Who wrote the message that is attached to Minnie's fridge?"
        minniesHouse10.correctAnswer = "Mickey"
        minniesHouse10.keyboardType = true
        minniesHouse10.resultImage = greyMouse
        minniesHouse10.answerBool = false
        minniesHouse10.questionInt = 160
        minniesHouse10.land = toonTown
        
        let minniesHouse11 = Questions(entity: questionDescription!, insertInto: context)
        minniesHouse11.questionTitle = "Minnie's House 11"
        minniesHouse11.theQuestion = "The weather vane on Minnie's house has a arrow going through a what?"
        minniesHouse11.correctAnswer = "heart"
        minniesHouse11.keyboardType = true
        minniesHouse11.resultImage = greyMouse
        minniesHouse11.answerBool = false
        minniesHouse11.questionInt = 161
        minniesHouse11.land = toonTown
        
        //Donalds Boat (201-250)
        let donaldsBoat1 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat1.questionTitle = "Donald's Boat 1"
        donaldsBoat1.theQuestion = "The name of Donald's boat is the \"S.S. ____ _____\"."
        donaldsBoat1.correctAnswer = "Miss Daisy"
        donaldsBoat1.keyboardType = true
        donaldsBoat1.resultImage = greyMouse
        donaldsBoat1.answerBool = false
        donaldsBoat1.questionInt = 201
        donaldsBoat1.land = toonTown
        
        let donaldsBoat2 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat2.questionTitle = "Donald's Boat 2"
        donaldsBoat2.theQuestion = "Who is carved out of wood on the front of Donald's Boat?"
        donaldsBoat2.correctAnswer = "Daisy"
        donaldsBoat2.keyboardType = true
        donaldsBoat2.resultImage = greyMouse
        donaldsBoat2.answerBool = false
        donaldsBoat2.questionInt = 202
        donaldsBoat2.land = toonTown
        
        let donaldsBoat3 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat3.questionTitle = "Donald's Boat 3"
        donaldsBoat3.theQuestion = "What color is the mailbox by the entrance to Donald's Boat?"
        donaldsBoat3.correctAnswer = "yellow"
        donaldsBoat3.keyboardType = true
        donaldsBoat3.resultImage = greyMouse
        donaldsBoat3.answerBool = false
        donaldsBoat3.questionInt = 203
        donaldsBoat3.land = toonTown
        
        let donaldsBoat4 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat4.questionTitle = "Donald's Boat 4"
        donaldsBoat4.theQuestion = "Hanging on the walls near Donald's Hammock on his boat are how many pictures?"
        donaldsBoat4.correctAnswer = "5"
        donaldsBoat4.keyboardType = false
        donaldsBoat4.resultImage = greyMouse
        donaldsBoat4.answerBool = false
        donaldsBoat4.questionInt = 204
        donaldsBoat4.land = toonTown
        
        let donaldsBoat5 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat5.questionTitle = "Donald's Boat 5"
        donaldsBoat5.theQuestion = "What color is Donald's rain hat above his Hammock?"
        donaldsBoat5.correctAnswer = "yellow"
        donaldsBoat5.keyboardType = true
        donaldsBoat5.resultImage = greyMouse
        donaldsBoat5.answerBool = false
        donaldsBoat5.questionInt = 205
        donaldsBoat5.land = toonTown
        
        let donaldsBoat6 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat6.questionTitle = "Donald's Boat 6"
        donaldsBoat6.theQuestion = "What lake is Donald's boat docked in?"
        donaldsBoat6.correctAnswer = "Toon Lake"
        donaldsBoat6.keyboardType = true
        donaldsBoat6.resultImage = greyMouse
        donaldsBoat6.answerBool = false
        donaldsBoat6.questionInt = 206
        donaldsBoat6.land = toonTown
        
        let donaldsBoat7 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat7.questionTitle = "Donald's Boat 7"
        donaldsBoat7.theQuestion = "What is the color of the rudder on Donald's boat?"
        donaldsBoat7.correctAnswer = "blue"
        donaldsBoat7.keyboardType = true
        donaldsBoat7.resultImage = greyMouse
        donaldsBoat7.answerBool = false
        donaldsBoat7.questionInt = 207
        donaldsBoat7.land = toonTown
        
        let donaldsBoat8 = Questions(entity: questionDescription!, insertInto: context)
        donaldsBoat8.questionTitle = "Donald's Boat 8"
        donaldsBoat8.theQuestion = "How many hats does Donald have hanging on a rope above his boat?"
        donaldsBoat8.correctAnswer = "1"
        donaldsBoat8.keyboardType = false
        donaldsBoat8.resultImage = greyMouse
        donaldsBoat8.answerBool = false
        donaldsBoat8.questionInt = 208
        donaldsBoat8.land = toonTown
        
        // Chip and Dale's Treehouse (251-300)
        
        let chipAndDalesTreehouse1 = Questions(entity: questionDescription!, insertInto: context)
        chipAndDalesTreehouse1.questionTitle = "Chip and Dale's Treehouse 1"
        chipAndDalesTreehouse1.theQuestion = "When Toontown first opened there was a _____ that would take you from the top of Chip and Dale's Treehouse to a ball pit."
        chipAndDalesTreehouse1.correctAnswer = "slide"
        chipAndDalesTreehouse1.keyboardType = true
        chipAndDalesTreehouse1.resultImage = greyMouse
        chipAndDalesTreehouse1.answerBool = false
        chipAndDalesTreehouse1.questionInt = 251
        chipAndDalesTreehouse1.land = toonTown
        
        //Gadgets Go Coaster (301-350)
        
        let gadgetsGoCoaster1 = Questions(entity: questionDescription!, insertInto: context)
        gadgetsGoCoaster1.questionTitle = "Gadget's Go Coaster 1"
        gadgetsGoCoaster1.theQuestion = "How many inches tall do you have to be to ride Gadget's Go Coaster?"
        gadgetsGoCoaster1.correctAnswer = "35"
        gadgetsGoCoaster1.keyboardType = false
        gadgetsGoCoaster1.resultImage = greyMouse
        gadgetsGoCoaster1.answerBool = false
        gadgetsGoCoaster1.questionInt = 301
        gadgetsGoCoaster1.land = toonTown
        
        let gadgetsGoCoaster2 = Questions(entity: questionDescription!, insertInto: context)
        gadgetsGoCoaster2.questionTitle = "Gadget's Go Coaster 2"
        gadgetsGoCoaster2.theQuestion = "What color is the Gadget Go Coaster Track?"
        gadgetsGoCoaster2.correctAnswer = "red"
        gadgetsGoCoaster2.keyboardType = true
        gadgetsGoCoaster2.resultImage = greyMouse
        gadgetsGoCoaster2.answerBool = false
        gadgetsGoCoaster2.questionInt = 302
        gadgetsGoCoaster2.land = toonTown
        
        let gadgetsGoCoaster3 = Questions(entity: questionDescription!, insertInto: context)
        gadgetsGoCoaster3.questionTitle = "Gadget's Go Coaster 3"
        gadgetsGoCoaster3.theQuestion = "What color are the rocks in the queue?"
        gadgetsGoCoaster3.correctAnswer = "blue"
        gadgetsGoCoaster3.keyboardType = true
        gadgetsGoCoaster3.resultImage = greyMouse
        gadgetsGoCoaster3.answerBool = false
        gadgetsGoCoaster3.questionInt = 303
        gadgetsGoCoaster3.land = toonTown
        
        let gadgetsGoCoaster4 = Questions(entity: questionDescription!, insertInto: context)
        gadgetsGoCoaster4.questionTitle = "Gadget's Go Coaster 4"
        gadgetsGoCoaster4.theQuestion = "There are four animals standing on rocks near the coaster track. Sometimes they are spitting water. What type of animal are they? (Plural)"
        gadgetsGoCoaster4.correctAnswer = "Frogs"
        gadgetsGoCoaster4.keyboardType = true
        gadgetsGoCoaster4.resultImage = greyMouse
        gadgetsGoCoaster4.answerBool = false
        gadgetsGoCoaster4.questionInt = 304
        gadgetsGoCoaster4.land = toonTown
        
        let gadgetsGoCoaster5 = Questions(entity: questionDescription!, insertInto: context)
        gadgetsGoCoaster5.questionTitle = "Gadget's Go Coaster 5"
        gadgetsGoCoaster5.theQuestion = "The cars for Gadget's Go Coaster look like they are made out of what?"
        gadgetsGoCoaster5.correctAnswer = "Acorns"
        gadgetsGoCoaster5.keyboardType = true
        gadgetsGoCoaster5.resultImage = greyMouse
        gadgetsGoCoaster5.answerBool = false
        gadgetsGoCoaster5.questionInt = 305
        gadgetsGoCoaster5.land = toonTown
        
        let gadgetsGoCoaster6 = Questions(entity: questionDescription!, insertInto: context)
        gadgetsGoCoaster6.questionTitle = "Gadget's Go Coaster 6"
        gadgetsGoCoaster6.theQuestion = "What are the gates you stand behind while waiting to board the coaster made out of?"
        gadgetsGoCoaster6.correctAnswer = "Dominos"
        gadgetsGoCoaster6.keyboardType = true
        gadgetsGoCoaster6.resultImage = greyMouse
        gadgetsGoCoaster6.answerBool = false
        gadgetsGoCoaster6.questionInt = 306
        gadgetsGoCoaster6.land = toonTown
        
        //Toon Town Food (351-400)
        let toonTownFood1 = Questions(entity: questionDescription!, insertInto: context)
        toonTownFood1.questionTitle = "Toon Town Food 1"
        toonTownFood1.theQuestion = "What is the name of Pluto's Restaurant in Toon Town? (3 Words)"
        toonTownFood1.correctAnswer = "Pluto's Dog House"
        toonTownFood1.keyboardType = true
        toonTownFood1.resultImage = greyMouse
        toonTownFood1.answerBool = false
        toonTownFood1.questionInt = 351
        toonTownFood1.land = toonTown
        
        let toonTownFood2 = Questions(entity: questionDescription!, insertInto: context)
        toonTownFood2.questionTitle = "Toon Town Food 2"
        toonTownFood2.theQuestion = "What is the name of Daisy's Restaurant located in Toon Town?"
        toonTownFood2.correctAnswer = "Daisy's Diner"
        toonTownFood2.keyboardType = true
        toonTownFood2.resultImage = greyMouse
        toonTownFood2.answerBool = false
        toonTownFood2.questionInt = 352
        toonTownFood2.land = toonTown
        
        //Five and Dime (401-450)
        let fiveAndDime = Questions(entity: questionDescription!, insertInto: context)
        fiveAndDime.questionTitle = "Five and Dime"
        fiveAndDime.theQuestion = "What is the color of the Five and Dime building?"
        fiveAndDime.correctAnswer = "yellow"
        fiveAndDime.keyboardType = true
        fiveAndDime.resultImage = greyMouse
        fiveAndDime.answerBool = false
        fiveAndDime.questionInt = 401
        fiveAndDime.land = toonTown
        
        //Post Office (451-500)
        let postOffice1 = Questions(entity: questionDescription!, insertInto: context)
        postOffice1.questionTitle = "Post Office"
        postOffice1.theQuestion = "Who does the mailbox belong to that is upside down in the Toon Town Post office?"
        postOffice1.correctAnswer = "Goofy"
        postOffice1.keyboardType = true
        postOffice1.resultImage = greyMouse
        postOffice1.answerBool = false
        postOffice1.questionInt = 451
        postOffice1.land = toonTown
        
        //The Jolley Trolley (501-600)
        let jollyTrolley1 = Questions(entity: questionDescription!, insertInto: context)
        jollyTrolley1.questionTitle = "Jolly Trolley 1"
        jollyTrolley1.theQuestion = "What is the main color of the Jolly Trolley parked at the Trolley stop?"
        jollyTrolley1.correctAnswer = "red"
        jollyTrolley1.keyboardType = true
        jollyTrolley1.resultImage = greyMouse
        jollyTrolley1.answerBool = false
        jollyTrolley1.questionInt = 501
        jollyTrolley1.land = toonTown
        
        let jollyTrolley2 = Questions(entity: questionDescription!, insertInto: context)
        jollyTrolley2.questionTitle = "Jolly Trolley 2"
        jollyTrolley2.theQuestion = "What is the color of the Round House for the Jolly Trolley located next Roger Rabbit's Cartoon Spin?"
        jollyTrolley2.correctAnswer = "blue"
        jollyTrolley2.keyboardType = true
        jollyTrolley2.resultImage = greyMouse
        jollyTrolley2.answerBool = false
        jollyTrolley2.questionInt = 502
        jollyTrolley2.land = toonTown
        
        let jollyTrolley3 = Questions(entity: questionDescription!, insertInto: context)
        jollyTrolley3.questionTitle = "Jolly Trolley 3"
        jollyTrolley3.theQuestion = "How many Jolly Trolley cars can you see at the Trolley Station?"
        jollyTrolley3.correctAnswer = "1"
        jollyTrolley3.keyboardType = false
        jollyTrolley3.resultImage = greyMouse
        jollyTrolley3.answerBool = false
        jollyTrolley3.questionInt = 503
        jollyTrolley3.land = toonTown
        
        //Gag Factory (601-650)
        
        let gagFactory1 = Questions(entity: questionDescription!, insertInto: context)
        gagFactory1.questionTitle = "Gag Factory 1"
        gagFactory1.theQuestion = "Inside the Gag Factory is a machine that is producing Gags for the Toons. This machine is called the \"Gag-O-_____\"."
        gagFactory1.correctAnswer = "Matic"
        gagFactory1.keyboardType = true
        gagFactory1.resultImage = greyMouse
        gagFactory1.answerBool = false
        gagFactory1.questionInt = 601
        gagFactory1.land = toonTown
        
        let gagFactory2 = Questions(entity: questionDescription!, insertInto: context)
        gagFactory2.questionTitle = "Gag Factory 2"
        gagFactory2.theQuestion = "According to a sign painted on one of the walls in the Gag Factory \"Hilarity is just ______ ___ ______\""
        gagFactory2.correctAnswer = "around the corner"
        gagFactory2.keyboardType = true
        gagFactory2.resultImage = greyMouse
        gagFactory2.answerBool = false
        gagFactory2.questionInt = 602
        gagFactory2.land = toonTown
        
        let gagFactory3 = Questions(entity: questionDescription!, insertInto: context)
        gagFactory3.questionTitle = "Gag Factory 3"
        gagFactory3.theQuestion = "Just to the side of the Hilarity sign is written what?"
        gagFactory3.correctAnswer = "Carpe Gagum"
        gagFactory3.keyboardType = true
        gagFactory3.resultImage = greyMouse
        gagFactory3.answerBool = false
        gagFactory3.questionInt = 603
        gagFactory3.land = toonTown
        
        let gagFactory4 = Questions(entity: questionDescription!, insertInto: context)
        gagFactory4.questionTitle = "Gag Factory 4"
        gagFactory4.theQuestion = "What is the name of the machine that embroiders your name on Mickey ears in the Gag Factory?"
        gagFactory4.correctAnswer = "Stitch-O-Matic"
        gagFactory4.keyboardType = true
        gagFactory4.resultImage = greyMouse
        gagFactory4.answerBool = false
        gagFactory4.questionInt = 604
        gagFactory4.land = toonTown
        
        let gagFactory5 = Questions(entity: questionDescription!, insertInto: context)
        gagFactory5.questionTitle = "Gag Factory 5"
        gagFactory5.theQuestion = "Up on a shelf in the Gag Factory is a green box with bullet holes. What does the label on the box say is inside?"
        gagFactory5.correctAnswer = "Riddles"
        gagFactory5.keyboardType = true
        gagFactory5.resultImage = greyMouse
        gagFactory5.answerBool = false
        gagFactory5.questionInt = 605
        gagFactory5.land = toonTown
        
        // Laugh-O-Gram Films inc. (651-700)
        
        let laughOGramFilms1 = Questions(entity: questionDescription!, insertInto: context)
        laughOGramFilms1.questionTitle = "Laugh-O-Gram Films inc. 1"
        laughOGramFilms1.theQuestion = "What is the slogan of Laugh-O-Gram Films inc.? Located above the Toon Town Court House."
        laughOGramFilms1.correctAnswer = "A Reel of Fun"
        laughOGramFilms1.keyboardType = true
        laughOGramFilms1.resultImage = greyMouse
        laughOGramFilms1.answerBool = false
        laughOGramFilms1.questionInt = 651
        laughOGramFilms1.land = toonTown
        
        let laughOGramFilms2 = Questions(entity: questionDescription!, insertInto: context)
        laughOGramFilms2.questionTitle = "Laugh-O-Gram Films inc. 2"
        laughOGramFilms2.theQuestion = "Who is the Directing Animator of Laugh-O-Gram Films inc.? Located above the Toon Town Court House."
        laughOGramFilms2.correctAnswer = "W. E. Disney"
        laughOGramFilms2.keyboardType = true
        laughOGramFilms2.resultImage = greyMouse
        laughOGramFilms2.answerBool = false
        laughOGramFilms2.questionInt = 652
        laughOGramFilms2.land = toonTown
        
        // Toon Town Bank (701-750)
        
        let toonTownBank1 = Questions(entity: questionDescription!, insertInto: context)
        toonTownBank1.questionTitle = "Toon Town Bank 1"
        toonTownBank1.theQuestion = "One of the Three Little Pigs own the Toon Town Bank. According to the sign above the bank, which Pig owns it? (As written)"
        toonTownBank1.correctAnswer = "3rd little piggy"
        toonTownBank1.keyboardType = true
        toonTownBank1.resultImage = greyMouse
        toonTownBank1.answerBool = false
        toonTownBank1.questionInt = 701
        toonTownBank1.land = toonTown

        let toonTownBank2 = Questions(entity: questionDescription!, insertInto: context)
        toonTownBank2.questionTitle = "Toon Town Bank 2"
        toonTownBank2.theQuestion = "There is a hammer by the door to the Toon Town Bank that says \"In Case of Emergency _____ ___\"."
        toonTownBank2.correctAnswer = "break the pig"
        toonTownBank2.keyboardType = true
        toonTownBank2.resultImage = greyMouse
        toonTownBank2.answerBool = false
        toonTownBank2.questionInt = 702
        toonTownBank2.land = toonTown
        
        // Toon Town Gas Station (751-800)
        
        let toonTownGasStation1 = Questions(entity: questionDescription!, insertInto: context)
        toonTownGasStation1.questionTitle = "Toon Town Gas Station 1"
        toonTownGasStation1.theQuestion = "Who owns the Gas Station in Toon Town?"
        toonTownGasStation1.correctAnswer = "Goofy"
        toonTownGasStation1.keyboardType = true
        toonTownGasStation1.resultImage = greyMouse
        toonTownGasStation1.answerBool = false
        toonTownGasStation1.questionInt = 751
        toonTownGasStation1.land = toonTown
        
        let toonTownGasStation2 = Questions(entity: questionDescription!, insertInto: context)
        toonTownGasStation2.questionTitle = "Toon Town Gas Station 2"
        toonTownGasStation2.theQuestion = "What is free at the Gas Station?"
        toonTownGasStation2.correctAnswer = "Air"
        toonTownGasStation2.keyboardType = true
        toonTownGasStation2.resultImage = greyMouse
        toonTownGasStation2.answerBool = false
        toonTownGasStation2.questionInt = 752
        toonTownGasStation2.land = toonTown
        
        let toonTownGasStation3 = Questions(entity: questionDescription!, insertInto: context)
        toonTownGasStation3.questionTitle = "Toon Town Gas Station 3"
        toonTownGasStation3.theQuestion = "What are you supposed to do for service at the Gas Station?"
        toonTownGasStation3.correctAnswer = "Honk"
        toonTownGasStation3.keyboardType = true
        toonTownGasStation3.resultImage = greyMouse
        toonTownGasStation3.answerBool = false
        toonTownGasStation3.questionInt = 753
        toonTownGasStation3.land = toonTown
        
        let toonTownGasStation4 = Questions(entity: questionDescription!, insertInto: context)
        toonTownGasStation4.questionTitle = "Toon Town Gas Station 4"
        toonTownGasStation4.theQuestion = "According to a sign on a lamp post near the Gas Station, what type of turn in OK? "
        toonTownGasStation4.correctAnswer = "wrong turn"
        toonTownGasStation4.keyboardType = true
        toonTownGasStation4.resultImage = greyMouse
        toonTownGasStation4.answerBool = false
        toonTownGasStation4.questionInt = 754
        toonTownGasStation4.land = toonTown
        
        //Misc Toon Town (801-)
        
        let toonTownGym = Questions(entity: questionDescription!, insertInto: context)
        toonTownGym.questionTitle = "Toon Town Gym"
        toonTownGym.theQuestion = "Who owns the Gym in Toon Town?"
        toonTownGym.correctAnswer = "Horace Horsecollar"
        toonTownGym.keyboardType = true
        toonTownGym.resultImage = greyMouse
        toonTownGym.answerBool = false
        toonTownGym.questionInt = 801
        toonTownGym.land = toonTown
        
        let toonTownDepartment = Questions(entity: questionDescription!, insertInto: context)
        toonTownDepartment.questionTitle = "Toon Town Department"
        toonTownDepartment.theQuestion = "In between the Toon Town Gas Station and Daisy's Diner is the Department of ___ & Paint."
        toonTownDepartment.correctAnswer = "Ink"
        toonTownDepartment.keyboardType = true
        toonTownDepartment.resultImage = greyMouse
        toonTownDepartment.answerBool = false
        toonTownDepartment.questionInt = 802
        toonTownDepartment.land = toonTown
        
        let toonTownFireDepartment = Questions(entity: questionDescription!, insertInto: context)
        toonTownFireDepartment.questionTitle = "Toon Town Fire Department"
        toonTownFireDepartment.theQuestion = "What is the Toontown Fire Station Number?"
        toonTownFireDepartment.correctAnswer = "101"
        toonTownFireDepartment.keyboardType = false
        toonTownFireDepartment.resultImage = greyMouse
        toonTownFireDepartment.answerBool = false
        toonTownFireDepartment.questionInt = 803
        toonTownFireDepartment.land = toonTown
        
        let huffinandPuffin = Questions(entity: questionDescription!, insertInto: context)
        huffinandPuffin.questionTitle = "Huffin & Puffin"
        huffinandPuffin.theQuestion = "According to the sign over the Camera Shop, when was Huffin & Puffin Wrecking Co. established?"
        huffinandPuffin.correctAnswer = "1939"
        huffinandPuffin.keyboardType = false
        huffinandPuffin.resultImage = greyMouse
        huffinandPuffin.answerBool = false
        huffinandPuffin.questionInt = 804
        huffinandPuffin.land = toonTown
        
        let drWho = Questions(entity: questionDescription!, insertInto: context)
        drWho.questionTitle = "Dr. Who?"
        drWho.theQuestion = "What is the name of the Dr. who owns the buisness right above the Dog Pound?"
        drWho.correctAnswer = "Dr. Drillum"
        drWho.keyboardType = true
        drWho.resultImage = greyMouse
        drWho.answerBool = false
        drWho.questionInt = 805
        drWho.land = toonTown
        
        let goofyWater = Questions(entity: questionDescription!, insertInto: context)
        goofyWater.questionTitle = "Goofy Water"
        goofyWater.theQuestion = "How many different flavors of /“Goofy Water/“ can you get in Toon Town?"
        goofyWater.correctAnswer = "11"
        goofyWater.keyboardType = false
        goofyWater.resultImage = greyMouse
        goofyWater.answerBool = false
        goofyWater.questionInt = 806
        goofyWater.land = toonTown
        
        let clockTower = Questions(entity: questionDescription!, insertInto: context)
        clockTower.questionTitle = "Toon Town Clock Tower"
        clockTower.theQuestion = "How many whistles are on the main clock tower in Toon Town?"
        clockTower.correctAnswer = "2"
        clockTower.keyboardType = false
        clockTower.resultImage = greyMouse
        clockTower.answerBool = false
        clockTower.questionInt = 807
        clockTower.land = toonTown
        
        let dar = Questions(entity: questionDescription!, insertInto: context)
        dar.questionTitle = "DAR"
        dar.theQuestion = "The sign that hangs over the entrance to Toon Town displays a sign for the organization \"DAR\". What does \"DAR\" stand for? (5 Words)"
        dar.correctAnswer = "daughters of the animated reel"
        dar.keyboardType = true
        dar.resultImage = greyMouse
        dar.answerBool = false
        dar.questionInt = 808
        dar.land = toonTown
        
        let sealOfTT = Questions(entity: questionDescription!, insertInto: context)
        sealOfTT.questionTitle = "Seal of Toon Town"
        sealOfTT.theQuestion = "What year does the official seal of Toon Town say that Toon Town was established?"
        sealOfTT.correctAnswer = "1928"
        sealOfTT.keyboardType = false
        sealOfTT.resultImage = greyMouse
        sealOfTT.answerBool = false
        sealOfTT.questionInt = 809
        sealOfTT.land = toonTown
        
        let postIt = Questions(entity: questionDescription!, insertInto: context)
        postIt.questionTitle = "Post It"
        postIt.theQuestion = "How many post office boxes are in Toon Town's post office?"
        postIt.correctAnswer = "6"
        postIt.keyboardType = false
        postIt.resultImage = greyMouse
        postIt.answerBool = false
        postIt.questionInt = 810
        postIt.land = toonTown
        
        let orderoftheMouse = Questions(entity: questionDescription!, insertInto: context)
        orderoftheMouse.questionTitle = "Order of the Mouse"
        orderoftheMouse.theQuestion = "Looking at the sign over the entrance to Toon Town you will see some of the organizations that exist in Toon Town. One is \"Benevolent & ____ Order of Mouse\"."
        orderoftheMouse.correctAnswer = "protective"
        orderoftheMouse.keyboardType = true
        orderoftheMouse.resultImage = greyMouse
        orderoftheMouse.answerBool = false
        orderoftheMouse.questionInt = 811
        orderoftheMouse.land = toonTown
        
        let manHole = Questions(entity: questionDescription!, insertInto: context)
        manHole.questionTitle = "Man Hole"
        manHole.theQuestion = "What two words are inscribed on the manhole covers in Toon Town?"
        manHole.correctAnswer = "toon hole"
        manHole.keyboardType = true
        manHole.resultImage = greyMouse
        manHole.answerBool = false
        manHole.questionInt = 812
        manHole.land = toonTown
        
        let symphonyFountain = Questions(entity: questionDescription!, insertInto: context)
        symphonyFountain.questionTitle = "Symphony Fountain"
        symphonyFountain.theQuestion = "How many different instruments are featured in the fountain outside of Mickey's House?"
        symphonyFountain.correctAnswer = "4"
        symphonyFountain.keyboardType = false
        symphonyFountain.resultImage = greyMouse
        symphonyFountain.answerBool = false
        symphonyFountain.questionInt = 813
        symphonyFountain.land = toonTown
        
        
        do {
            try context.save()
        } catch {
            
        }
    }




