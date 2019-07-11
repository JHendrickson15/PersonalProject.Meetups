//
//  File.swift
//  PersonProject
//
//  Created by Jordan Hendrickson on 7/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    var username: String
    var password: String
    var appleUserReference: CKRecord.Reference
    var recordID: CKRecord.ID?
    
    static let recordKey = "User"
    
    static let appleUserReferenceKey = "appleUserReference"
    fileprivate static let passwordKey = "password"
    fileprivate static let usernameKey = "username"
    
    init(username: String, password: String, appleUserReference: CKRecord.Reference) {
        self.username = username
        self.password = password
        self.appleUserReference = appleUserReference
    }
    init?(ckRecord: CKRecord) {
        guard let username = ckRecord[User.usernameKey] as? String,
            let password = ckRecord[User.passwordKey] as? String,
        let appleUserReference = ckRecord[User.appleUserReferenceKey] as? CKRecord.Reference
            else {return nil}
        self.username = username
        self.password = password
        self.appleUserReference = appleUserReference
        self.recordID = ckRecord.recordID
    }
}
extension CKRecord {
    convenience init(user: User) {
        let recordID = user.recordID ?? CKRecord.ID(recordName: UUID().uuidString)
        
        self.init(recordType: User.recordKey, recordID: recordID)
        
        self.setValue(user.username, forKey: User.usernameKey)
        self.setValue(user.password, forKey: User.passwordKey)
        self.setValue(user.appleUserReference, forKey: User.appleUserReferenceKey)
    }
}
