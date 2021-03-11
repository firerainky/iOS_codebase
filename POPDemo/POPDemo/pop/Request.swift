//
//  Request.swift
//  POPDemo
//
//  Created by Zheng Kanyan on 2021/3/9.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

// Request 只作为定义入口和输出而存在
protocol Request {
    var path: String { get }
    
    var method: HTTPMethod { get }
    var parameter: [String : Any] { get }
    
    associatedtype Response: Parsable
}

protocol Client {
    func send<T: Request>(_ r: T, handler: ((T.Response?) -> Void)?)
    
    var host: String { get }
}

struct URLSessionClient: Client {
    let host = "https://cat-fact.herokuapp.com";
    
    func send<T>(_ r: T, handler: ((T.Response?) -> Void)?) where T : Request {
        guard let url = URL(string: host + r.path) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                if let handler = handler {
                    handler(T.Response.parse(data: data))
                }
            }
        }.resume()
    }
}


struct UserURLRequest: Request {
    var name = "facts"
    
    var path: String {
        return "/\(name)"
    }
    var method: HTTPMethod {
        return .GET
    }
    let parameter: [String : Any] = [:]
    
    typealias Response = ManyUser
    
    init() { }
}
