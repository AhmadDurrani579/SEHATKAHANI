//
//  SKSocketConnection.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//  test 

import UIKit
import SocketIO
import JSQMessagesViewController
class SKSocketConnection: NSObject {
    
    public let socket = SocketIOClient(socketURL: URL.init(string: APIManager.sharedInstance.baseUrl)!)
    static let socketSharedConnection = SKSocketConnection()
    override init() {
        super.init()

    }
    func getSocketCurrentState (callback: @escaping (Bool , SocketIOClientStatus) -> Void ) {
        let socketConnectionStatus = self.socket.status
        switch socketConnectionStatus {
        case SocketIOClientStatus.connected:
            print("socket connected")
            callback(true , socketConnectionStatus)
            break;
        case SocketIOClientStatus.connecting:
            print("socket connecting")
            callback(false , socketConnectionStatus)
            break;
        case SocketIOClientStatus.disconnected:
            print("socket disconnected")
            callback(false , socketConnectionStatus)
            break;
        case SocketIOClientStatus.notConnected:
            print("socket not connected")
            callback(false , socketConnectionStatus)
            break;
        }
    }
    func connectSocket(userId : String , sessionId : String ) -> Void {
        guard userId.count > 0 else {
            debugPrint("No user id ")
            return;
        }
        guard sessionId.count > 0 else {
             debugPrint("No Session id ")
            return;
        }
        debugPrint(socket.socketURL.absoluteString)
        socket.on(clientEvent: .connect) {data, ack in
                print("socket connected")
             self.socket.emit("add user", sessionId)
             self.socket.emit("add session mobile", userId, sessionId)
            self.socket.emit("show online", userId)
            self.socket.emit("add activeusers", userId)

        }
        socket.onAny { (socketEvent) in
            debugPrint(socketEvent.event)

            // Receive  all absorver in their
            
            if socketEvent.event == "end_session_mobile" {
                if let vc = UIApplication.topViewController(){
                    vc.navigationController?.popToRootViewController(animated: true)
                }
            }
            
            else if socketEvent.event == "consult patient" {
                let ap = UIApplication.shared.delegate as! AppDelegate

                ap.consultId = (socketEvent.items![0] as! String)
                ap.doctoID = (socketEvent.items![2] as! String)

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checkInvitation"), object:nil, userInfo:nil)

                
            } else if socketEvent.event == "chat message" {

                if( socketEvent.items![1] as? String == APIManager.sharedInstance.getLoggedInUser()?.id){

                }else{

                    let message1 : JSQMessage = JSQMessage.init(senderId:socketEvent.items![1] as! String   , displayName:" ", text:socketEvent.items![0] as! String)

                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "recivedChatMessage"), object:message1, userInfo:nil)

                }
            } else if socketEvent.event == "hang_up" {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hangUp"), object:nil, userInfo:nil)

                print("Hello AHng Up")
            }
            else if socketEvent.event == "consultation" {
             
//                var consultationIdOfDoctor : String?
//                var doctorConsultPatiendID : String?
//                var messageOfConsult : String?
                let ap = UIApplication.shared.delegate as! AppDelegate
                
                ap.consultationIdOfDoctor = (socketEvent.items![0] as! String)
                ap.messageOfConsult = (socketEvent.items![1] as! String)
                ap.doctorConsultPatiendID = (socketEvent.items![2] as! String)

                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Consultation_Doctor"), object:socketEvent.items, userInfo:nil)

                   print("Doctor Consultation")
            }
            
            
            else if socketEvent.event == "call_mobile" {
                let ap = UIApplication.shared.delegate as! AppDelegate
                
                if ap.isScreenVisibleOrNot == true {
                    ap.videoVallType = socketEvent.items?[0] as? String
                    ap.nameOfCaller = socketEvent.items?[1] as? String
                    ap.joinRoomId = socketEvent.items?[2] as? String

                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videoCallAccept"), object:socketEvent.items, userInfo:nil)
                    
                }
                
//                    print("Patient Call")
            }
            debugPrint(socketEvent.description)
        }
        
    
      //  socket.reconnects = false;
        socket.config = SocketIOClientConfiguration.init(arrayLiteral: .log(true), .forcePolling(false) , .forceWebsockets(false))
        socket.connect()
    }
    func disconnectSocketCurrentSession() -> Void  {
        self.socket.removeAllHandlers()
        self.socket.disconnect();
    }
    func emitSpecficData(keyName : String , arrayValue : Array<Any> ) -> Void  {
        self.socket.emit(keyName, arrayValue)
    }
    func addSpecficObserver(observerKey : String , callback: @escaping (Any , SocketAckEmitter) -> Void) {
        self.socket.on(observerKey, callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    func removeListner(listenerName : String) -> Void {
        self.socket.off(listenerName)
    }
    func addActiveUsers (userId : String) -> Void {

        guard userId.count > 0 else {
            debugPrint("No user id ")
            return;
        }
        self.socket.emit("add activeusers", userId)
    }
    
    
    
    func addActiveusersBusy (userId : String) -> Void {
        //
        guard userId.count > 0 else {
            debugPrint("No user id ")
            return;
        }
        self.socket.emit("add activeusers busy", userId)
    }
    func consultationCalling (patientid : String , doctorid : String , consultationid : String , userName : String , userType : SKUserType) -> Void {

        guard patientid.count > 0 else {
            debugPrint("No user id ")
            return;
        }
        if userType == SKUserType.doctor{
            socket.on("consultation", callback: { (data, ack) in

            })
        }
        else if userType == SKUserType.patient {
           self.socket.emit("consultation", doctorid , patientid , consultationid , userName + " has request for consultation")

        }
    }
    
    func prescriptionON (userType : SKUserType, callbackValue: @escaping (Bool) ->Void) -> Void {
       
        if userType == SKUserType.patient{
            socket.on("prescription", callback: { (data, ack) in
                callbackValue(true)
            })
        }
    }
    
     // MARK: - Doctor Side
    func consultPatient(patientID : String , doctorID : String ,consultationID : String , message : String ) -> Void {
        self.getSocketCurrentState { (isConnected, status ) in
            if isConnected {
                self.socket.emit("consult patient", patientID,doctorID , consultationID , message)
            }else {
                print("Not connected")
            }
        }
    }
    
    func missedConsultation(doctorID : String ,consultationID : String) -> Void {
        self.getSocketCurrentState { (isConnected, status ) in
            if isConnected {
                self.socket.emit("wait_over",doctorID , consultationID)
                self.socket.emit("missed_instant_consultation", consultationID)
            }else {
                print("Not connected")
            }
        }
    }
    


    func reject_instant_consultation(patientID : String , message : String ) -> Void {
        self.socket.emit("reject_instant_consultation", patientID , message)
    }
    func chatMessage(docorid : String , patientID : String ,senderID : String , message : String , consultationid : String ) -> Void {
        self.socket.emit("chat message", docorid ,  patientID ,senderID,  message , consultationid)
    }
    func receiveChatMessage(userId : String , callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.socket.on("chat message", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
    func rejectConsultationListner(callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.socket.on("reject_instant_consultation", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
    func missedConsultationListner(doctorID : String ,consultationID : String ,callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.socket.on("wait_over", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
    func showOnlineLive(callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.socket.on("show online", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
    func showOfflineLive(callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.socket.on("disconnect-socket", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
    func rejectCall(callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.socket.on("reject_call_mobile", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
    // MARK: - Calling
    func startCallingFrom(userID : String , callType : SKCallType , userType : SKUserType , userName : String , randomString : String) -> Void {
        self.socket.emit("call_mobile", userID , callType.getCallTypeStr() , userType.getCallTypeStr() , userName , randomString)
    }
    func rejectCallingFrom(userID : String ) -> Void  {
        self.socket.emit("reject_call_mobile", userID)
    }
    
    func endSessionOfDoctor(patientId : String , consultantId : String , date : String) {
        self.socket.emit("end_session_mobile", patientId , consultantId , date)
    }
    func prescriptionFromDoctor(patientID : String , isOnOrOff : String) -> Void  {
        self.socket.emit("prescription", patientID , isOnOrOff)
    }

    func acceptCallingFrom(userID : String) -> Void  {
        self.socket.emit("accept_call_mobile", userID)
    }
//    func hangUpCallingFrom(userID : String  , doctorId : String) -> Void  {
//        self.socket.emit("accept_call_mobile", userID , doctorId)
//    }
    func hangUpCalling(userID : String  , doctorId : String) -> Void  {
        self.socket.emit("hang_up", userID , doctorId)
    }
}
