//
//  CloudKitManager.swift
//  ios17BB
//
//  Created by Joe Lucero on 2/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
   let publicDB = CKContainer.default().publicCloudDatabase
   
   func save(message: Message, completion: @escaping ((CKRecord?, Error?) -> Void)) {
      publicDB.save(message.asCKRecord, completionHandler: completion)
   }
   
   func load(completion: @escaping (([CKRecord]?, Error?) -> Void)){
      let predicate = NSPredicate(value: true)
      let query = CKQuery(recordType: CKKeys.messageType, predicate: predicate)
      publicDB.perform(query, inZoneWith: nil, completionHandler: completion)
   }
}
