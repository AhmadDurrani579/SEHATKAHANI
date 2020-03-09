//
//  Favourites.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 26/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class Favourites: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedIndexPath: IndexPath?
    var cellStatus:NSMutableDictionary = NSMutableDictionary()
    let app = UIApplication.shared.delegate as! AppDelegate
    
    let favourtesDr = FindDrByName()
    var favourtesDrList: DrByName?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        gettingfavourtesDr()

    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Favourites"
        self.navigationController?.isNavigationBarHidden = false
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourtesDrList?.result.count ?? 0
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
        

        cell.drName.text = (favourtesDrList?.result[indexPath.item].name.first)!+" "+(favourtesDrList?.result[indexPath.item].name.last)!
        cell.drSpeciality.text = favourtesDrList?.result[indexPath.item].doctor.speciality
        cell.drExperience.text = (favourtesDrList?.result[indexPath.item].doctor.experience)!+" Year"
        cell.available.text = favourtesDrList?.result[indexPath.item].isOnline
        
        if favourtesDrList?.result[indexPath.item].isOnline == "Offline" {
            cell.availableDot.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else {
            cell.availableDot.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
        if let url = favourtesDrList?.result[indexPath.item].photo.url {
            print(url)
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        
        cell.viewProfileOffline = {() -> Void in
            self.viewprofileview()
            
        }
        cell.viewProfile = {() -> Void in
            self.viewprofileview()
            
        }
        
        
//        cell.isSelected = (cellStatus[indexPath.row] as? Bool) ?? false

        
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
//        app.specialist = favourtesDrList?.result[indexPath.item]
        if let id = favourtesDrList?.result[indexPath.item]._id {
            APIManager.sharedInstance.key = id
        }
//
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
            
            //do other header related calls or settups
            return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
    
    
    func gettingfavourtesDr() {
        favourtesDr.getDrbyname(url: "/api/MobileApp/findDoctor/find_by_favourite", parameterDictionary: ["id" : APIManager.sharedInstance.getLoggedInUser()!.id!]) { (response) in
            DispatchQueue.main.async {
                self.favourtesDrList = response
                self.collectionView.reloadData()
            }
//            print(response)
        }
    }
}













