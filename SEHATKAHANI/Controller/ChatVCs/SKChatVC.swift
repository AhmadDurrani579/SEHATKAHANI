
//
//  SKChatVC.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Kingfisher

class SKChatVC: JSQMessagesViewController {
    let ap = UIApplication.shared.delegate as! AppDelegate
    var checkMessage  : MOMessage?

    
    private var messages: [JSQMessage] = []
    private var photoMessageMap = [String: JSQPhotoMediaItem]()
    private var localTyping = false
    
    var channel: Channel? {
        didSet {
            title = channel?.name
        }
    }
    
     let countDown = UILabel()
    weak var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status: Bool = false

    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = APIManager.sharedInstance.getLoggedInUser()?.id
        self.senderDisplayName = APIManager.sharedInstance.getLoggedInUser()?.name!["first"] as! String
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bgImage")!)
        
//        let cust : UIView = UIView.init(frame: CGRect (x : 0 , y : 0 , width : 100 , height : 100))
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "pre"), for: .normal)
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.inputView?.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(SKChatVC.precription), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            btn1.isHidden = false
        }else {
            btn1.isHidden = true
        }
        
        SKSocketConnection.socketSharedConnection.prescriptionON(userType: SKUserType.patient, callbackValue: {(value) in
            if value {
                btn1.isHidden = false
            }
        })


//        let rightArrow : UIView = UIView.init(frame: CGRect (x : 0 , y : 0 , width : 100 , height : 100))
        let leftbtn = UIButton(type: .custom)
        leftbtn.setImage(UIImage(named: "arrow"), for: .normal)
        leftbtn.imageView?.contentMode = .scaleAspectFit
        leftbtn.inputView?.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        leftbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftbtn.addTarget(self, action: #selector(SKChatVC.sesssionDestroy), for: .touchUpInside)
        let leftITem = UIBarButtonItem(customView: leftbtn)
        self.navigationItem.setLeftBarButtonItems([leftITem], animated: true)
//        self.navigationItem.setLeftBarButton([leftITem], animated: true)

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        customNavigationView()
        start()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didMessageDisplay(_:)), name: NSNotification.Name(rawValue: "recivedChatMessage"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.videoCallAction(_:)), name: NSNotification.Name(rawValue: "videoCall"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.videoCallOpponent(_:)), name: NSNotification.Name(rawValue: "videoCallAccept"), object: nil)
        
        ap.isScreenVisibleOrNot = true
        

        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    //    NotificationCenter.default.addObserver(self, selector: #selector(self.didMessageDisplay(_:)), name: NSNotification.Name(rawValue: "recivedChatMessage"), object: nil)

  
        
    }
    
    func customNavigationView()  {
        
        let customNavView = UIViewX()
        let imageView  = UIImageView()
        let nameLbl = UILabel()
       
        
        
        customNavView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        customNavView.backgroundColor = UIColor.clear
        if let name = ap.specialist?.UserId.name.first, let namel = ap.specialist?.UserId.name.last {
            nameLbl.text = name+" "+namel
        }
        
        countDown.text = "08:33:00"
        nameLbl.sizeToFit()
        countDown.sizeToFit()
        
    
        navigationItem.titleView = customNavView
        customNavView.addSubview(imageView)
        customNavView.addSubview(nameLbl)
        customNavView.addSubview(countDown)
        
        imageView.frame = CGRect(x: 10, y: 1, width: 40, height: 40)
        nameLbl.frame.origin.x = imageView.frame.width + 20
        nameLbl.frame.origin.y = 5
        
        countDown.frame.origin.x = imageView.frame.width + 20
        countDown.frame.origin.y = 20
        
        nameLbl.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        countDown.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        
        nameLbl.font = UIFont(name: "Lato-Regular", size: 12)
        countDown.font = UIFont(name: "Lato-Regular", size: 12)
        nameLbl.sizeToFit()
        countDown.sizeToFit()
        
        imageView.image = #imageLiteral(resourceName: "doctorimage")
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.cornerRadius1()
        imageView.clipsToBounds = true
        
    
        
        if let url = ap.specialist?.UserId.photo.url {
            print(url)
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            imageView.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        

    }
    
    func start() {
        
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    func updateCounter() {
        
        // Calculate total time since timer started in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime
        
//        let hour = UInt8(time / 24.0)
//        time -= (TimeInterval(hour) * 60)
//
        // Calculate minutes
        let minutes = UInt8(time / 60.0)
        debugPrint(minutes)
        time -= (TimeInterval(minutes) * 60)
        debugPrint(time)
        // Calculate seconds
        let seconds = UInt8(time)
        time -= TimeInterval(seconds)
        
        // Calculate milliseconds
//        let milliseconds = UInt8(time * 100)
        
        // Format time vars with leading zero
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
//        let strMilliseconds = String(format: "%02d", milliseconds)
        
        // Add time vars to relevant labels
//       print(strMinutes, " - ", strSeconds)
        countDown.text = "00:\(strMinutes):\(strSeconds)"
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    
    
    
    
    
    func sesssionDestroy() {
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            
            let uiAlert = UIAlertController(title: "Confirmation", message: "Are you sure do you want to cancel the session" , preferredStyle: UIAlertControllerStyle.alert)
                
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        let result = formatter.string(from: date)


                        SKSocketConnection.socketSharedConnection.endSessionOfDoctor(patientId: self.ap.doctorConsultPatiendID! , consultantId:self.ap.consultationIdOfDoctor! , date: result)
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    
                    //                        SKSocketConnection.socketSharedConnection.consultPatient(patientID: self.ap.doctorConsultPatiendID! , doctorID: APIManager.sharedInstance.getId(), consultationID: self.ap.consultationIdOfDoctor!, message: "Request Accepted")
                    
                    
                }))
                
                uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                    print("Click of cancel button")
                    
                }))
                
                self.present(uiAlert, animated: true, completion: nil)
        
        
        } else {
            let uiAlert = UIAlertController(title: "Confirmation", message: "Please wait for Doctor Write prescription or End Session" , preferredStyle: UIAlertControllerStyle.alert)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
            }))
            
            
            self.present(uiAlert, animated: true, completion: nil)

        }

        
        
//        let uiAlert = UIAlertController(title: "Consultation Request", message: ap.messageOfConsult , preferredStyle: UIAlertControllerStyle.alert)
//
//        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//
//
//            SKSocketConnection.socketSharedConnection.consultPatient(patientID: self.ap.doctorConsultPatiendID! , doctorID: APIManager.sharedInstance.getId(), consultationID: self.ap.consultationIdOfDoctor!, message: "Request Accepted")
//
//            self.ap.isConsultantDoctor = true
//            let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKChatVC") as? SKChatVC
//            self.navigationController?.pushViewController(newViewController!, animated: true)
//
//        }))
//
//        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
//            print("Click of cancel button")
//        }))
//
//        self.present(uiAlert, animated: true, completion: nil)
//        SKSocketConnection.socketSharedConnection
        
        
    }
    func precription() {
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "consultationNewPatientAndDoctor", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar") as UIViewController
//        navigationController?.pushViewController(newViewController, animated: true)
//
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            let storyBoard: UIStoryboard = UIStoryboard(name: "consultationNewPatientAndDoctor", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKDoctorPreceptionViewController") as UIViewController
            navigationController?.pushViewController(newViewController, animated: true)

        } else {
        
            let storyBoard: UIStoryboard = UIStoryboard(name: "consultationNewPatientAndDoctor", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKPatientSummaryViewController") as! SKPatientSummaryViewController
            navigationController?.pushViewController(newViewController, animated: true)

        }

    
    }
    
    func videoCallOpponent(_ notification: NSNotification) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKVideoChatVC") as? SKVideoChatVC
        newViewController?.checkIsVideoFromMine = true
        
        navigationController?.pushViewController(newViewController!, animated: true)

        
    }

    @IBAction func btnVideo(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DemoChatVC") as? DemoChatVC
        navigationController?.pushViewController(newViewController!, animated: true)
    }

    func videoCallAction(_ notification: NSNotification) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKVideoChatVC") as? SKVideoChatVC
        navigationController?.pushViewController(newViewController!, animated: true)

//        let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DemoChatVC") as? DemoChatVC
//        navigationController?.pushViewController(newViewController!, animated: true)


    }

    func didMessageDisplay(_ notification: NSNotification) {
        let message = notification.object

        messages.append(message as! JSQMessage)
        collectionView.reloadData()

        
        //        checkMessage = notification.object as? MOMessage
//        messages.append((checkMessage?.message)!)
//        let receivedString = dict.value(forKey: "message")
        
//        var mesg : String?
//        mesg = checkMessage?.message
//            dict["message"] as? String
//        messages.append((checkMessage?.message as? JSQMessage)!)
//        msg        messages.append(checkMessage)
//        messages.append(checkMessage?.message as! JSQMessage)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell

        let message = messages[indexPath.item]

        if message.senderId == senderId { // 1
            cell.textView?.textColor = UIColor.white // 2
        } else {
            cell.textView?.textColor = UIColor.white // 3
        }

        return cell
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView?, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString? {
        let message = messages[indexPath.item]
        switch message.senderId {
        case senderId:
            return nil
        default:
            guard let senderDisplayName = message.senderDisplayName else {
                assertionFailure()
                return nil
            }
            return NSAttributedString(string: senderDisplayName)
        }
    }

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {

          if button.tag == 124 {

            debugPrint("calling cammera")

        }else if button.tag == 123 {

                debugPrint("calling attachemtn")

        }else {


//            let message : JSQMessage = JSQMessage.init(senderId: senderId!, displayName: senderDisplayName!, text: text!)
//            self.messages.append(message);
//            let message1 : JSQMessage = JSQMessage.init(senderId: "asdasd", displayName: senderDisplayName!, text: text!)
//            self.messages.append(message1);
//            func chatMessage(docorid : String , patientID : String ,senderID : String , message : String , consultationid : String ) -> Void {
            
            if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
                
                if ap.isConsultantDoctor == true {
                    SKSocketConnection.socketSharedConnection.chatMessage(docorid:APIManager.sharedInstance.getId()   , patientID: ap.doctorConsultPatiendID! , senderID:APIManager.sharedInstance.getId()  , message: text , consultationid: ap.consultationIdOfDoctor!)

                } else {
                    SKSocketConnection.socketSharedConnection.chatMessage(docorid:APIManager.sharedInstance.getId()   , patientID:  ap.doctoID!, senderID:APIManager.sharedInstance.getId()  , message: text , consultationid: ap.consultId!)

                }
            }else {
                SKSocketConnection.socketSharedConnection.chatMessage(docorid: ap.doctoID!  , patientID: APIManager.sharedInstance.getId(), senderID:APIManager.sharedInstance.getId()  , message: text , consultationid: ap.consultId!)
            }


            let message : JSQMessage = JSQMessage.init(senderId: senderId!, displayName: senderDisplayName!, text: text!)
            self.messages.append(message);

            
            JSQSystemSoundPlayer.jsq_playMessageSentSound()
            finishSendingMessage()


        }











       // isTyping = false
    }

    func sendPhotoMessage() -> String? {

        return ""
    }

    func setImageURL(_ url: String, forPhotoMessageWithKey key: String) {
//        let itemRef = messageRef.child(key)
//        itemRef.updateChildValues(["photoURL": url])
    }

    // MARK: UI and User Interaction

    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }

    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }

    override func didPressAccessoryButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }

        present(picker, animated: true, completion:nil)
    }

    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }

    private func addPhotoMessage(withId id: String, key: String, mediaItem: JSQPhotoMediaItem) {
        if let message = JSQMessage(senderId: id, displayName: "", media: mediaItem) {
            messages.append(message)

            if (mediaItem.image == nil) {
                photoMessageMap[key] = mediaItem
            }

            collectionView.reloadData()
        }
    }

    // MARK: UITextViewDelegate methods

    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
//        isTyping = textView.text != ""
    }

}

// MARK: Image Picker Delegate
extension SKChatVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

}


