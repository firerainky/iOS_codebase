//
//  LocalFileClient.swift
//  POPDemoTests
//
//  Created by Zheng Kanyan on 2021/3/10.
//

import Foundation
@testable import POPDemo

struct LocalFileClient: Client {
    let host: String = ""
    let content = "[{\"_id\":\"jojo\",\"type\":\"cat\",\"deleted\":false}]"
    func send<T>(_ r: T, handler: ((T.Response?) -> Void)?) where T : Request {
        switch r.path {
                case "/facts":
                    if let handler = handler {
                        handler(T.Response.parse(data: content.data(using: .utf8)!))
                    }
//                    guard let fileURL = Bundle.main.url(forResource: "users:onevcat", withExtension: "") else {
//                        fatalError()
//                    }
//                    guard let data = try? Data(contentsOf: fileURL) else {
//                        fatalError()
//                    }
//                    if let handler = handler {
//                        handler(T.Response.parse(data: data))
//                    }
                default:
                    fatalError("Unknown path")
                }
    }
}
