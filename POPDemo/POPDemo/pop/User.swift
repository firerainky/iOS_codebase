//
//  User.swift
//  POPDemo
//
//  Created by Zheng Kanyan on 2021/3/9.
//

import Foundation

protocol Parsable {
    static func parse(data: Data) -> Self?
}

struct ManyUser: Parsable {
    var users = [User]()
    typealias T = Self
    
    static func parse(data: Data) -> ManyUser? {
        ManyUser(data: data)
    }
    
    struct User {
        var userID: String
        var type: String
        var deleted: Bool
        
        init?(_ dict: [String: Any]) {
            guard let userID = dict["_id"] as? String else {
                return nil
            }
            guard let type = dict["type"] as? String else {
                return nil
            }
            guard let deleted = dict["deleted"] as? Bool else {
                return nil
            }
            self.userID = userID
            self.type = type
            self.deleted = deleted
        }
    }
    
    init?(data: Data) {
        guard let jsonUsers = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
            return nil
        }
        
        for jsonUser in jsonUsers {
            if let user = User(jsonUser) {
                users.append(user)
            }
        }
    }
}
