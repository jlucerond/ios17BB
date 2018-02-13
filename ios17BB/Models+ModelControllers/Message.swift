//
//  Message.swift
//  ios17BB
//
//  Created by Joe Lucero on 2/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import CloudKit

struct Message {
   let text: String
   let date: Date
   let cloudKitID: CKRecordID?
   
   // member-wise initializer
   init(text: String) {
      self.text = text
      self.date = Date()
      self.cloudKitID = nil
   }
   
   // computed 'asCKRecord' property
   var asCKRecord: CKRecord {
      let record: CKRecord
      if cloudKitID == nil {
         record = CKRecord(recordType: CKKeys.messageType)
      } else {
         record = CKRecord(recordType: CKKeys.messageType, recordID: cloudKitID!)
      }
      
      // option 1
      record.setObject(text as CKRecordValue, forKey: CKKeys.text)
      // option 2
      record[CKKeys.date] = date as CKRecordValue
      
      return record
   }
   
   // failable initializer from a dictionary/ckrecord
   init?(record: CKRecord) {
      guard let text = record.object(forKey: CKKeys.text) as? String,
         let date = record.object(forKey: CKKeys.date) as? Date else { return nil }
      
      self.text = text
      self.date = date
      self.cloudKitID = record.recordID
   }
}














