//
//  SKFourmCat.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 31/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKFourmCat: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let getData = FindDrBySpeciality()
    var listOfDr : DrSpeciality?
    var name: String!
    let speci = [("Anesthesiologist","Anesthesiologist"),
                 ("Audiologist","Audiologist"),
                 ("allergyArtboard-37","Allergy Specialist"),
                 ("Chiropractor","Chiropractor"),
                 ("cosmetic","Cosmetic Surgeon"),
                 ("Dental","Dental"),
                 ("Dermatologist","Dermatologist"),
                 ("Diabetes","Diabetes Specialist"),
                 ("ENT","ENT Specialist"),
                 ("Gastroenterologist","Endocrinologist"),
                 ("Gastroenterologist","Gastroenterologist"),
                 ("Gynecologist","Gynecologist"),
                 ("General Surgeon","General Surgeon"),
                 ("General Physician","General Physician"),
                 ("Hematologist","Hematologist"),
                 ("hair","Hair Transplant Surgeon"),
                 ("Infertility","Infertility Specialist"),
                 ("Nutritionist","Nutritionist / Dietitian"),
                 ("Nephrologist","Nephrologist"),
                 ("Neuro Surgeon","Neuro Surgeon"),
                 ("Orthopedic","Orthopedic"),
                 ("Orthopedic","Orthopedic Surgeon"),
                 ("Oncologist","Oncologist / Cancer specialist"),
                 ("Ophthalmologist","Ophthalmologist / Eye Specialist"),
                 ("Plastic","Plastic Surgeon"),
                 ("Psychologist","Psychologist"),
                 ("Psychiatrist","Psychiatrist"),
                 ("PhysiotherapistArtboard-39","Physiotherapist"),
                 ("Pediatrician","Pediatrician / Child specialist"),
                 ("Pulmonologist","Pulmonologist / Lungs specialist"),
                 ("Radiologist","Radiologist"),
                 ("sonologistArtboard-13-copy","Sonologist"),
                 ("Urologist","Urologist"),
                 ("VascularArtboard-41","Vascular Surgeon"),
                 ("wellness","Wellness Coach")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // specialites() // test coment
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationItem.backBarButtonItem?.title = "Yhaoo"
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Forum"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return speci.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpecialityCell
        //        cell.layer.cornerRadius = cell.frame.height / 1.9
        //        cell.layer.borderWidth = 0.5
        //        cell.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
        cell.imageView.image = UIImage(named: speci[indexPath.item].0)
        cell.titleLabel.text = speci[indexPath.item].1
        cell.viewHolder.layer.cornerRadius = cell.viewHolder.frame.height / 2
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.name = speci[indexPath.item].1
        return true
    }
    @IBAction func dismissButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "forum")
        navigationController?.pushViewController(newViewController, animated: true)
        MYQuery = true
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SKForum
        {
            let vc = segue.destination as? SKForum
            vc?.name = self.name
        }
    }
    
}













