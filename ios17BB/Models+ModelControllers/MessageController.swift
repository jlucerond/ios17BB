//
//  MessageController.swift
//  ios17BB
//
//  Created by Joe Lucero on 2/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation

class MessageController {
   static let shared = MessageController()
   let ckManager = CloudKitManager()
   var messages: [Message] = [] {
      didSet {
         NotificationCenter.default.post(name: JLNotifications.messagesUpdated, object: nil)
      }
   }
   
   // create a new message
   func saveNewMessageWith(text: String) {
      // create a message
      let newMessage = Message(text: text)
      // send it over to ckManager to deal with cloudkit saving
      ckManager.save(message: newMessage) { (_, error) in
         if let error = error {
            print("Error Saving: \(error.localizedDescription)")
         } else {
            self.messages.insert(newMessage, at: 0)
         }
      }
   }
   
   // load messages
   func loadMessages() {
      ckManager.load { (records, error) in
         if let error = error {
            print("Error Loading: \(error.localizedDescription)")
            return
         }
         
         guard let records = records else { return }
         var messagesFromCK: [Message] = []
         
         for record in records {
            guard let newMessage = Message(record: record) else { continue }
            messagesFromCK.append(newMessage)
         }
         
         self.messages = messagesFromCK
      }
   }
   
   
   private init() {
      
   }
}


