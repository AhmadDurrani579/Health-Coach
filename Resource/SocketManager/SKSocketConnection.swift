//
//  SKSocketConnection.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//  test 

import UIKit
import SocketIO

class SKSocketConnection: NSObject {
    
    public let socket = SocketManager(socketURL: URL(string: ROOT_URLFORSOCKET)!, config: [.log(true), .compress])
    static let socketSharedConnection = SKSocketConnection()
  
    var sockets :SocketIOClient!
    var name: String?
    var resetAck: SocketAckEmitter?

    override init() {
        super.init()
        sockets = socket.defaultSocket

    }
    func getSocketCurrentState (callback: @escaping (Bool , SocketIOStatus) -> Void ) {
        let socketConnectionStatus = self.socket.status
        switch socketConnectionStatus {
        case SocketIOStatus.connected:
            print("socket connected")
            callback(true , socketConnectionStatus)
            break;
        case SocketIOStatus.connecting:
            print("socket connecting")
            callback(false , socketConnectionStatus)
            break;
        case SocketIOStatus.disconnected:
            print("socket disconnected")
            callback(false , socketConnectionStatus)
            break;
        case SocketIOStatus.notConnected:
            print("socket not connected")
            callback(false , socketConnectionStatus)
            break;
        }
    }
    func connectSocket() -> Void {
//        guard userId.count > 0 else {
//            debugPrint("No user id ")
//            return;
//        }
//        guard sessionId.count > 0 else {
//             debugPrint("No Session id ")
//            return;
//        }
//        debugPrint(socket.socketURL.absoluteString)
      
        sockets.on(clientEvent: .connect) {data, ack in
//            self.sockets.emit("channel")

                print("socket connected")

        }
        sockets.onAny { (socketEvent) in
            
            if socketEvent.event == "new message" {
                let message = socketEvent.items![0]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "new Message"), object : message, userInfo : nil)

            }
            if socketEvent.event  == "initial messages" {
                    print("Hello")
                
            let message = socketEvent.items![0]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "messageReciver"), object : message, userInfo : nil)
            }

            if socketEvent.event == "typing" {
                let message = socketEvent.items![0]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "typingMessage"), object : message, userInfo : nil)

            }
           
            
        }
        
    
      //  socket.reconnects = false;
        socket.config = SocketIOClientConfiguration.init(arrayLiteral: .log(true), .forcePolling(false) , .forceWebsockets(false))
        socket.connect()
    }
    func disconnectSocketCurrentSession() -> Void  {
//        self.socket.removeAllHandlers()
        self.socket.disconnect();
    }
   
//    func  sendMessage(keyName : String , obj : MessageObject) -> Void {
//
//        sockets.emit("sendMessageEvent", obj.toJSON())
//    }

    func sendMessage(obj : [String : Any]) -> Void {
        self.getSocketCurrentState { (isConnected, status ) in
            if isConnected {
//               self.sockets.emit("users"  , "187" , "148")
                self.sockets.emit("new message" , obj)
            }else {
                print("Not connected")
            }
        }
    }
    
    func chatHistory(obj : [String : Any]) -> Void {
        self.getSocketCurrentState { (isConnected, status ) in
            if isConnected {
                self.sockets.emit("users"  , obj)
            }else {
                print("Not connected")
            }
        }
    }
    
    func userTyping(obj : [String : Any]) -> Void {
        self.getSocketCurrentState { (isConnected, status ) in
            if isConnected {
                self.sockets.emit("typing"  , obj)
            }else {
                print("Not connected")
            }
        }
    }
 

//    func  sendMessage(keyName : String , obj : MessageObject) -> Void {
//
//        sockets.emit("sendMessageEvent", obj.toJSON())
//    }
//
//    func emitSpecficData(keyName : String , arrayValue : Array<Any> ) -> Void  {
//        self.socket.emitAll(keyName, arrayValue)
//    }
    
//    func addSpecficObserver(observerKey : String , callback: @escaping (Any , SocketAckEmitter) -> Void) {
//        self.socket.on(observerKey, callback: { (data, ack) in
//            debugPrint("receive message is :  \(data)")
//            callback(data , ack)
//        })
//    }
    
    func removeListner(listenerName : String) -> Void {
        self.sockets.off(listenerName)
        
    }
//    func addActiveUsers (userId : String) -> Void {
//
//        guard userId.count > 0 else {
//            debugPrint("No user id ")
//            return;
//        }
//        self.sockets.emit("add activeusers", userId)
//    }
    
    
    
//    func addActiveusersBusy (userId : String) -> Void {
//        //
//        guard userId.count > 0 else {
//            debugPrint("No user id ")
//            return;
//        }
//        self.sockets.emit("add activeusers busy", userId)
//    }
//    func consultationCalling (patientid : String , doctorid : String , consultationid : String , userName : String , userType : SKUserType) -> Void {
//
//        guard patientid.count > 0 else {
//            debugPrint("No user id ")
//            return;
//        }
//        if userType == SKUserType.doctor{
//            socket.on("consultation", callback: { (data, ack) in
//
//            })
//        }
//        else if userType == SKUserType.patient {
//           self.socket.emit("consultation", doctorid , patientid , consultationid , userName + " has request for consultation")
//
//        }
//    }
//
//    func prescriptionON (userType : SKUserType, callbackValue: @escaping (Bool) ->Void) -> Void {
//
//        if userType == SKUserType.patient{
//            socket.on("prescription", callback: { (data, ack) in
//                callbackValue(true)
//            })
//        }
//    }
    
     // MARK: - Doctor Side
//    func consultPatient(patientID : String , doctorID : String ,consultationID : String , message : String ) -> Void {
//        self.getSocketCurrentState { (isConnected, status ) in
//            if isConnected {
//                self.socket.emit("consult patient", patientID,doctorID , consultationID , message)
//            }else {
//                print("Not connected")
//            }
//        }
//    }
//
//    func missedConsultation(doctorID : String ,consultationID : String) -> Void {
//        self.getSocketCurrentState { (isConnected, status ) in
//            if isConnected {
//                self.socket.emit("wait_over",doctorID , consultationID)
//                self.socket.emit("missed_instant_consultation", consultationID)
//            }else {
//                print("Not connected")
//            }
//        }
//    }
//


//    func reject_instant_consultation(patientID : String , message : String ) -> Void {
//        self.socket.emit("reject_instant_consultation", patientID , message)
//    }
//    func senderMessage(obj : Any ) -> Void {
////        self.sockets.emit("sendMessageEvent", obj)
//        self.sockets.emit("sendMessageEvent", with: [obj])
//    }
//    func receiveChatMessage(userId : String , callback: @escaping (Any , SocketAckEmitter) ->Void){
//        self.socket.on("chat message", callback: { (data, ack) in
//            debugPrint("receive message is :  \(data)")
//            callback(data , ack)
//        })
//    }
//
//    func rejectConsultationListner(callback: @escaping (Any , SocketAckEmitter) ->Void){
//        self.socket.on("reject_instant_consultation", callback: { (data, ack) in
//            debugPrint("receive message is :  \(data)")
//            callback(data , ack)
//        })
//    }
//
//    func missedConsultationListner(doctorID : String ,consultationID : String ,callback: @escaping (Any , SocketAckEmitter) ->Void){
//        self.socket.on("wait_over", callback: { (data, ack) in
//            debugPrint("receive message is :  \(data)")
//            callback(data , ack)
//        })
//    }
    
    func showOnlineLive(callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.sockets.on("show online", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
    func showOfflineLive(callback: @escaping (Any , SocketAckEmitter) ->Void){
        self.sockets.on("disconnect-socket", callback: { (data, ack) in
            debugPrint("receive message is :  \(data)")
            callback(data , ack)
        })
    }
    
//    func rejectCall(callback: @escaping (Any , SocketAckEmitter) ->Void){
//        self.sockets.on("reject_call_mobile", callback: { (data, ack) in
//            debugPrint("receive message is :  \(data)")
//            callback(data , ack)
//        })
//    }
    
    // MARK: - Calling
//    func startCallingFrom(userID : String , callType : SKCallType , userType : SKUserType , userName : String , randomString : String) -> Void {
//        self.socket.emit("call_mobile", userID , callType.getCallTypeStr() , userType.getCallTypeStr() , userName , randomString)
//    }
//    func rejectCallingFrom(userID : String ) -> Void  {
//        self.socket.emit("reject_call_mobile", userID)
//    }
//
//    func endSessionOfDoctor(patientId : String , consultantId : String , date : String) {
//        self.socket.emit("end_session_mobile", patientId , consultantId , date)
//    }
//    func prescriptionFromDoctor(patientID : String , isOnOrOff : String) -> Void  {
//        self.socket.emit("prescription", patientID , isOnOrOff)
//    }
//
//    func acceptCallingFrom(userID : String) -> Void  {
//        self.socket.emit("accept_call_mobile", userID)
//    }
////    func hangUpCallingFrom(userID : String  , doctorId : String) -> Void  {
////        self.socket.emit("accept_call_mobile", userID , doctorId)
////    }
//    func hangUpCalling(userID : String  , doctorId : String) -> Void  {
//        self.socket.emit("hang_up", userID , doctorId)
//    }
}
