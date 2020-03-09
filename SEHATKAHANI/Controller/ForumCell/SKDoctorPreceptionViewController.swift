//
//  SKDoctorPreceptionViewController.swift
//  test
//
//  Created by M Abubaker Majeed on 30/01/2018.
//  Copyright © 2018 M Abubaker Majeed. All rights reserved.
//

import UIKit

class SKDoctorPreceptionViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet var viewSummaryAndNotes: UIView!
    
    @IBOutlet var viewPrecetion: UIView!
    @IBOutlet var addView: UIView!
    @IBOutlet var addSummaryButton: UIButton!

    var  addNotesBool : Bool = false;
    var  addPrecriptionBool : Bool = false;
    var  addSummaryBool : Bool = false;
    var headerViewcell: SKPreceptionHeader? = nil;
    var tableViewA = [""]
    let preception: SKPrecriptionTabletsTableViewCell? = Bundle.main.loadNibNamed("SKPrecriptionTabletsTableViewCell",
                                                                                  owner: nil,
                                                                                  options: nil)?.first as? SKPrecriptionTabletsTableViewCell
    let addNotesView: SKAddNotesView? = Bundle.main.loadNibNamed("SKAddNotesView",
                                                                             owner: nil,
                                                                             options: nil)?.first as? SKAddNotesView


    

    @IBOutlet var tableView: UITableView!
    
    @IBAction func addNotesAction(_ sender: Any) {

       addNotesBool = true;
       addPrecriptionBool  = false;
       addSummaryBool = false;
       self.setViewcustom();
    }

    @IBAction func addPrecriptionAction(_ sender: Any) {

        addNotesBool = false;
        addPrecriptionBool  = true;
        addSummaryBool = false;

self.setViewcustom();
    }
    
    @IBAction func addSummaryAction(_ sender: Any) {


        addNotesBool = false;
        addPrecriptionBool  = false;
        addSummaryBool = true;
       self.setViewcustom();

    }
    @IBAction func backAction(_ sender: Any) {
        
    }
    @IBAction func AddSummaryAndNotesAction(_ sender: Any) {

        addNotesView?.frame = CGRect (x : 0 , y : self.view.frame.size.height , width : self.view.frame.size.width , height : self.view.frame.size.height)
        self.view.addSubview((addNotesView)!)


        UIView.animate(withDuration: 0.25) {

            self.addNotesView?.frame = CGRect (x : 0 , y : 0 , width : self.view.frame.size.width , height : self.view.frame.size.height)

        }



    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.register(UINib(nibName: "SKPrecriptionTabletsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        headerViewcell  = Bundle.main.loadNibNamed("SKPreceptionHeader",
        owner: nil,
        options: nil)?.first as? SKPreceptionHeader

        addNotesBool = true;
        addPrecriptionBool  = false;
        addSummaryBool = false;
        viewSummaryAndNotes.layer.cornerRadius = 10

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {

        self.setViewcustom();


    }

    func setViewcustom() -> Void {


        DispatchQueue.main.async {


            self.viewPrecetion.isHidden = true;
            self.addView.isHidden = true;

            if self.addNotesBool {
                self.addSummaryButton.titleLabel?.text = ""
                self.addSummaryButton.titleLabel?.text = "Add Notes"
                self.addView.isHidden = false;

            }else if self.addSummaryBool {

                self.addSummaryButton.titleLabel?.text = ""
                self.addSummaryButton.titleLabel?.text = "Add Summary"
                self.addView.isHidden = false;


            }else {
                self.viewPrecetion.isHidden = false;
            }

        }


    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        return tableView.dequeueReusableCell(withIdentifier: "xibheader")
//
//    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewA.count;
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell:SKPrecriptionTabletsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! SKPrecriptionTabletsTableViewCell!



        if indexPath.row == 0 {
            cell.bottonConstraint.constant = 0;
        }else{
            cell.topHeightContant.constant = 0;
        }

        cell.contentView.layoutIfNeeded()
        cell.contentView.setNeedsLayout()
        cell.layoutIfNeeded()
        cell.setNeedsLayout()

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
