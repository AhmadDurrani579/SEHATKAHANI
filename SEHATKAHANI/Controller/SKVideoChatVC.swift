//
//  SKVideoChatVC.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKVideoChatVC: UIViewController , ARDAppClientDelegate, RTCEAGLVideoViewDelegate {

    @IBOutlet weak var remoteView: RTCEAGLVideoView!
    @IBOutlet weak var localView: RTCEAGLVideoView!
    @IBOutlet weak var audioButton:UIButton?
    @IBOutlet weak var videoButton:UIButton?
    @IBOutlet weak var hangupButton:UIButton?
    var checkIsVideoFromMine :Bool = false
    var  roomUrl:NSString?;
    var  roomName: String!
    var  client: ARDAppClient?
    var  localVideoTrack: RTCVideoTrack?
    var  remoteVideoTrack: RTCVideoTrack?
    var  localVideoSize:CGSize?;
    var  remoteVideoSize:CGSize?;
    var  isZoom:Bool = false; //used for double tap remote view
    let ap = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        connectToChatRoom()
        NotificationCenter.default.addObserver(self, selector: #selector(self.callHangUp(_:)), name: NSNotification.Name(rawValue: "hangUp"), object: nil)
        
        ap.isScreenVisibleOrNot == true


        SKSocketConnection.socketSharedConnection.rejectCall { (_, _) in
            self.disconnect()
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func callHangUp(_ notification: NSNotification) {
        disconnect()
        
        _ = self.navigationController?.popViewController(animated: true)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disconnect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endButton(_ sender: UIButton) {
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            SKSocketConnection.socketSharedConnection.hangUpCalling(userID: APIManager.sharedInstance.getId() , doctorId: ap.doctorConsultPatiendID!)
        } else {
            SKSocketConnection.socketSharedConnection.hangUpCalling(userID: APIManager.sharedInstance.getId() , doctorId: ap.doctoID!)

        }
        disconnect()
        
//        _ = self.navigationController?.popToRootViewController(animated: true)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //    MARK: RTCEAGLVideoViewDelegate
    func appClient(_ client: ARDAppClient!, didChange state: ARDAppClientState) {
        switch state{
        case ARDAppClientState.connected:
            print("Client Connected")
            break
        case ARDAppClientState.connecting:
            print("Client Connecting")
            break
        case ARDAppClientState.disconnected:
            print("Client Disconnected")
            remoteDisconnected()
        }
    }

    
    func appClient(_ client: ARDAppClient!, didReceiveLocalVideoTrack localVideoTrack: RTCVideoTrack!) {
        self.localVideoTrack = localVideoTrack
        self.localVideoTrack?.add(localView)
    }
    
    func appClient(_ client: ARDAppClient!, didReceiveRemoteVideoTrack remoteVideoTrack: RTCVideoTrack!) {
        self.remoteVideoTrack = remoteVideoTrack
        self.remoteVideoTrack?.add(remoteView)
    }
    
    func appClient(_ client: ARDAppClient!, didError error: Error!) {
        //        Handle the error
        showAlertWithMessage(error.localizedDescription)
        disconnect()
    }
    
    //    MARK: RTCEAGLVideoViewDelegate
    
    func videoView(_ videoView: RTCEAGLVideoView!, didChangeVideoSize size: CGSize) {
        //        Resize localView or remoteView based on the size returned
    }
    
    //    MARK: Private
    
    func initialize(){
        disconnect()
        //        Initializes the ARDAppClient with the delegate assignment
        client = ARDAppClient.init(delegate: self)
        
        //        RTCEAGLVideoViewDelegate provides notifications on video frame dimensions
        remoteView.delegate = self
        localView.delegate = self
    }
    
    func connectToChatRoom(){
//        client?.serverHostUrl = "https://apprtc.appspot.com"
        
        let randomeValue = APIManager.sharedInstance.randomString(length: 8)
    
        if  self.checkIsVideoFromMine == true  {
            

            if ap.isScreenVisibleOrNot == true {
                
                let uiAlert = UIAlertController(title: "Video Calling", message: ap.messageOfConsult , preferredStyle: UIAlertControllerStyle.alert)
                
                uiAlert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { action in
                    DispatchQueue.main.async {
                        self.client?.serverHostUrl = "https://stage.sehatkahani.com"
                        self.client?.connectToRoom(withId: self.ap.joinRoomId , options: nil)
                        
                        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
                            SKSocketConnection.socketSharedConnection.acceptCallingFrom(userID: self.ap.doctorConsultPatiendID!)

                        } else {
                            SKSocketConnection.socketSharedConnection.acceptCallingFrom(userID: self.ap.doctoID!)

                        }

                    }
                   
                }))
                
                uiAlert.addAction(UIAlertAction(title: "Reject", style: .cancel, handler: { action in
//                    SKSocketConnection.socketSharedConnection.rejectCallingFrom(userID: self.ap.doctoID!)
                    
                    
                    if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
//                        SKSocketConnection.socketSharedConnection.acceptCallingFrom(userID: self.ap.doctorConsultPatiendID!)
                          SKSocketConnection.socketSharedConnection.rejectCallingFrom(userID: self.ap.doctorConsultPatiendID!)
                        
                    } else {
//                        SKSocketConnection.socketSharedConnection.acceptCallingFrom(userID: self.ap.doctoID!)
                          SKSocketConnection.socketSharedConnection.rejectCallingFrom(userID: self.ap.doctoID!)
                        
                    }
                    
                    self.disconnect()
                    self.navigationController?.popViewController(animated: true)
                    
                }))
                
                self.present(uiAlert, animated: true, completion: nil)
                
                
            }
        } else {
            
            if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
                    
                    SKSocketConnection.socketSharedConnection.startCallingFrom(userID: ap.doctorConsultPatiendID! , callType: SKCallType.video, userType: SKUserType.doctor, userName:  APIManager.sharedInstance.getLoggedInUser()?.name!["first"] as! String, randomString: randomeValue)
                } else {
                    
                    SKSocketConnection.socketSharedConnection.startCallingFrom(userID: ap.doctoID! , callType: SKCallType.video, userType: SKUserType.patient, userName:  APIManager.sharedInstance.getLoggedInUser()?.name!["first"] as! String, randomString: randomeValue)
                    
                }
                client?.serverHostUrl = "https://stage.sehatkahani.com"
                
                client?.connectToRoom(withId: randomeValue, options: nil)
                
            }
            
        }
     

    
    
    
    func remoteDisconnected(){
        if(remoteVideoTrack != nil){
            remoteVideoTrack?.remove(remoteView)
        }
        remoteVideoTrack = nil
    }
    
    func disconnect(){
        if(client != nil){
            if(localVideoTrack != nil){
                localVideoTrack?.remove(localView)
            }
            if(remoteVideoTrack != nil){
                remoteVideoTrack?.remove(remoteView)
            }
            localVideoTrack = nil
            remoteVideoTrack = nil
            client?.disconnect()
        }
    }
    
    override var  shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.allButUpsideDown
    }
    
    func applicationWillResignActive(_ application:UIApplication){
        self.disconnect()
    }
    
    
    func orientationChanged(_ notification:Notification){
        if let _ = self.localVideoSize {
            self.videoView(self.localView!, didChangeVideoSize: self.localVideoSize!)
        }
        if let _ = self.remoteVideoSize {
            self.videoView(self.remoteView!, didChangeVideoSize: self.remoteVideoSize!)
        }
    }
    
    @IBAction func audioButtonPressed (_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        //        self.client?.toggleAudioMute()
        if sender.isSelected {
            self.client?.muteAudioIn()

        } else {
            self.client?.unmuteAudioIn()
        }
    }
    @IBAction func videoButtonPressed(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.client?.muteVideoIn()

        } else {
            self.client?.unmuteVideoIn()
        }
        //        self.client?.toggleVideoMute()
        
    }
    @IBAction func hangupButtonPressed(_ sender:UIButton){
        self.disconnect()
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func showAlertWithMessage(_ message: String){
        let alertView: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
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
