//
//  FindDoctorBySpeciality.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 22/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class FindDoctorBySpeciality: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedIndexPath: IndexPath?
    var cellStatus:NSMutableDictionary = NSMutableDictionary()
    
    
    let favourtesDr = FindDrByName()
    var specialist: DBName?
    
    var name: String?
    var key: String!
    let app = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.backBarButtonItem =  UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        SKSocketConnection.socketSharedConnection.showOnlineLive { (data, sata) in
            let data = data as! [String]
            if let id = data.first {
                if self.specialist?.result != nil {
                    for i in 0..<(self.specialist?.result.count)! {
                        if self.specialist?.result[i].UserId._id == id {
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(item: i, section: 0)
                                self.specialist?.result[i].UserId.isOnline = "Online"
                                self.collectionView.reloadItems(at: [indexPath])
                            }
                          
                        }
                   
                    }
                }
             
            }
          
            
        }
        SKSocketConnection.socketSharedConnection.showOfflineLive { (data, sata) in
            let data = data as! [String]
            if let id = data.first {
                if self.specialist?.result != nil {
                    for i in 0..<(self.specialist?.result.count)! {
                        if self.specialist?.result[i].UserId._id == id {
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(item: i, section: 0)
                                self.specialist?.result[i].UserId.isOnline = "Offline"
                                self.collectionView.reloadItems(at: [indexPath])
                            }
                            
                        }
                        
                    }
                }
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if let name1 = name {
            print(name1)
            gettingfavourtesDr(sname: name1)
            self.navigationController?.navigationBar.topItem?.title = name1
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specialist?.result.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavouriteCell
        cell.drImage.frame.size.width = cell.drImage.frame.height
        let center = cell.drImage.center
        cell.drImage.frame = CGRect(x: 0, y: 0, width: cell.frame.height - 15, height: cell.frame.height - 15)
        cell.drImage.center = center
        cell.viewHolder.layer.cornerRadius = cell.viewHolder.frame.height / 2
        cell.layer.cornerRadius = cell.frame.height / 2
        //        cell.viewHolder.layer.cornerRadius = cell.viewHolder.frame.height / 2
        cell.drImage.layer.cornerRadius = cell.drImage.frame.height / 2
        
        
        cell.drName.text = (specialist?.result[indexPath.item].UserId.name.first)!+" "+(specialist?.result[indexPath.item].UserId.name.last)!
        cell.drSpeciality.text = specialist?.result[indexPath.item].speciality
//        cell.drExperience.text 1111123= (specialist?.result[indexPath.item].experience)!+" Year "+(specialist?.result[indexPath.item].experiencemonths)!+" Months"
        if let monthExp = specialist?.result[indexPath.item].experiencemonths , let yearExp = specialist?.result[indexPath.item].experience {
            cell.drExperience.text = "\(yearExp) Year \(monthExp) Months"
        } else {
            cell.drExperience.text = "No Experience"
        }
        
        cell.available.text = specialist?.result[indexPath.item].UserId.isOnline

        if specialist?.result[indexPath.item].UserId.isOnline == "Offline" {
            cell.availableDot.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else {
            cell.availableDot.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
        if let url = specialist?.result[indexPath.item].UserId.photo.url {
            print(url)
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in

                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        cell.selectedDict = self.specialist?.result[indexPath.row];
        cell.isSelected = (cellStatus[indexPath.row] as? Bool) ?? false
        cell.viewProfile = {() -> Void in
                 self.viewprofileview()
          
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let ConsultationVC = SKStoryBoard.CONSULTATION_SB.instantiateViewController(withIdentifier: "ConsultationVC") as? ConsultationVC
//        ConsultationVC?.commingData = self.specialist?.result[indexPath.row]
//
//            ConsultationVC.commingData = self.selectedDict

        app.specialist = specialist?.result[indexPath.item]
        if let id = specialist?.result[indexPath.item].UserId.key {

            APIManager.sharedInstance.key = id
        }
        
        
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    //
    //
    //        let cell = collectionView.cellForItem(at: indexPath)
    //        cell?.isSelected = false
    //        self.cellStatus[indexPath.row] = false
    //
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 25, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SpecialityHeaderView
            reusableview.frame = CGRect(x: 12.5, y: 15, width: self.view.frame.width - 25, height: self.view.frame.height / 13)
            reusableview.searchTextfield.cornerRad()
            reusableview.searchTextfield.padding(value: 14)
            reusableview.searchTextfield.rightPad(value: 10)
            reusableview.searchTextfield.delegate = self
            
            //do other header related calls or settups
            return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//       let result =  self.specialist?.result.filter({($0.UserId.name.first?.contains(textField.text))!})
//        print(textField.text)
//        print(result)
        return true
    }
    
    
    func viewprofileview() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewdoctorProfile")
        navigationController?.pushViewController(newViewController, animated: true)
    }
//
    func gettingfavourtesDr(sname: String) {
       APIManager.sharedInstance.showHud()
        favourtesDr.getDrbySpeciality(url: "/api/MobileApp/findDoctor/find_by_speciality", parameterDictionary: ["speciality" : "\(sname)"]) { (response) in
            APIManager.sharedInstance.hideHud()
            self.specialist = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

























