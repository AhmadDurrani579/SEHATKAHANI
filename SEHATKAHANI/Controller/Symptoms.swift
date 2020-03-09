//
//  Symptoms.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 26/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class Symptoms: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    var name: String!
    @IBOutlet weak var collectionView: UICollectionView!

    let getData = FindDrBySpeciality()
    var listOfDr : DrSpeciality?
    
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
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
         specialites()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Symptoms"
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfDr?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SymptomsCell
  
        if let speciality = listOfDr?.result[indexPath.item].speciality {
            cell.titleLabel.text = speciality
        }
        cell.viewHolder.layer.cornerRadius = cell.viewHolder.frame.height / 2
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true);
        if let speciality = listOfDr?.result[indexPath.item].speciality {
             name = speciality
        }
       self.performSegue(withIdentifier: "symFav", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //symFav
        if segue.destination is FindDoctorBySpeciality
        {
            let vc = segue.destination as? FindDoctorBySpeciality
            vc?.name = self.name
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.view.frame.width - 25, height: 55)
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
    
    func specialites() {
        getData.getDrbySpeciality(url: "/api/MobileApp/findDoctor/find_by_symptoms") { (data) in
            self.listOfDr = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    

}














