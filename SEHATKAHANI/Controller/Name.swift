//
//  Name.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 26/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class Name: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView1: UICollectionView!

//    @IBOutlet weak var searchTextField: TextFieldView!
    
    let drbynameList = FindDrByName()
    var drbyNamesearch: DBName?
    
    let getData = FindDrBySpeciality()
//    var listOfDr : DrSpeciality?
    
    let app = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView1.layoutIfNeeded()
        collectionView1.reloadData()
        self.navigationController?.navigationBar.topItem?.title = "Name"
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        specialites()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drbyNamesearch?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NameCell
//                cell.layer.cornerRadius = cell.frame.height / 1.9
//                cell.layer.borderWidth = 0.5
//                cell.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
        cell.drImage.frame.size.width = cell.drImage.frame.height
        let center = cell.drImage.center
        cell.drImage.frame = CGRect(x: 0, y: 0, width: cell.frame.height - 15, height: cell.frame.height - 15)
        cell.drImage.center = center
        cell.viewHolder.layer.cornerRadius = cell.viewHolder.frame.height / 2
        cell.layer.cornerRadius = cell.frame.height / 2
        //        cell.viewHolder.layer.cornerRadius = cell.viewHolder.frame.height / 2
        cell.drImage.layer.cornerRadius = cell.drImage.frame.height / 2
        
        cell.drName.text = (drbyNamesearch?.result[indexPath.item].UserId.name.first)!+" "+(drbyNamesearch?.result[indexPath.item].UserId.name.last)!
        cell.drSpeciality.text = drbyNamesearch?.result[indexPath.item].speciality
        if let monthExp = drbyNamesearch?.result[indexPath.item].experiencemonths , let yearExp = drbyNamesearch?.result[indexPath.item].experience {
          cell.drExperience.text = "\(yearExp) Year \(monthExp) Months"
        } else {
           cell.drExperience.text = "No Experience"
        }
        cell.available.text = drbyNamesearch?.result[indexPath.item].UserId.isOnline

        if drbyNamesearch?.result[indexPath.item].UserId.isOnline == "Offline" {
            cell.availableDot.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else {
            cell.availableDot.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
        if let url = drbyNamesearch?.result[indexPath.item].UserId.photo.url {
            print(url)
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in

                                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }

        cell.viewProfile = {() -> Void in
            self.viewprofileview()
        }
        cell.onlineViewProfile = {() -> Void in
            self.viewprofileview()
        }

    cell.selectedDict = drbyNamesearch?.result[indexPath.item];
        return cell
    }
    func viewprofileview() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewdoctorProfile")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
//        let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 0, height: cell.frame.height / 2))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        cell.layer.mask = mask
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = drbyNamesearch?.result[indexPath.item].UserId._id {
            APIManager.sharedInstance.key = id
        }
        
        app.specialist = drbyNamesearch?.result[indexPath.item]
     
        self.collectionView1.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width - 25, height: 88)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SpecialityHeaderView
            
            reusableview.frame = CGRect(x: 12.5, y: 15, width: self.view.frame.width - 25, height: self.view.frame.height / 13)
            reusableview.searchTextfield.cornerRad()
            reusableview.searchTextfield.padding(value: 14)
            reusableview.searchTextfield.rightPad(value: 10)
//            reusableview.nameHandler = {()-> Void in
//                self.doctorsList(name: reusableview.searchTextfield.text!)
//            }
            //do other header related calls or settups
            return reusableview
            
            
        default:  fatalError("Unexpected element kind")
        }
    }
    
    
    
    @IBAction func searchDrByName(_ sender: Any) {
//
    }
    
//    func doctorsList(name: String) {
//        drbynameList.getDrbyname(url: "/api/MobileApp/findDoctor/find_by_name", parameterDictionary: ["name" : "\(name)"]) { (drbynamelist1) in
//            DispatchQueue.main.async {
//                self.drbyNamesearch = drbynamelist1
//                self.collectionView1.reloadData()
//            }
//            print(drbynamelist1)
//        }
//    }

    func specialites() {

        let jsonUrlString = APIManager.sharedInstance.baseUrl+"/api/MobileApp/findDoctor/" + "find_by_speciality_all"

        APIManager.GET(url: jsonUrlString, parameters: ["name" : "" as AnyObject]) { (response, json) in


            if let resposneStr = response {

                debugPrint(resposneStr)

            }else {
//                #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)


                do {
                    let courses = try JSONDecoder().decode(DBName.self, from: (json?.rawData())!)
                    self.drbyNamesearch = courses
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                    return
                }
                DispatchQueue.main.async {
                    self.collectionView1.reloadData()
                }


            }




        }



//        getData.getAllDoctor(url: "/api/MobileApp/findDoctor/find_by_symptoms") { (alldata) in
//            self.drbyNamesearch = alldata
//            DispatchQueue.main.async {
//                self.collectionView1.reloadData()
//            }
//        }
    }
    
}




























