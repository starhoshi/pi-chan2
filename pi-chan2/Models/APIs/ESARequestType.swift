//
//  ESARequestType.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper
import KeychainAccess

protocol ESARequestType: Request {

}

extension ESARequestType {
    var baseURL: URL {
        return Constants.Esa.Url.api
    }

    var headerFields: [String: String] {
        return ["Authorization": "Bearer " + (Keychain()[Keychain.tokenKey] ?? "")]
    }

    var teamPath: String {
        return "teams/\(Keychain()[Keychain.teamKey] ?? "")"
    }
}

extension ESARequestType where Response: Mappable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let json = object as? [String: Any] else {
            throw ResponseError.unexpectedObject(object)
        }
        guard let response: Response = Mapper<Response>().map(JSON: json) else {
            throw ResponseError.unexpectedObject(object)
        }
        log?.info("ObjectMapper response: \(response.toJSON())")
        return response
    }
}

extension ESARequestType {
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        log?.info("requestURL: \(urlRequest)")
        log?.info("requestHeader: \(urlRequest.allHTTPHeaderFields!)")
        log?.info("requestBody: \(String(data: urlRequest.httpBody ?? Data(), encoding: .utf8)?.debugDescription)")
        return urlRequest
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        log?.info("raw response header: \(urlResponse)")
        log?.info("raw response body: \(object)")
        switch urlResponse.statusCode {
        case 200..<300:
            return object

        case 401:
            throw Unauthorized()

        case 404:
            throw NotFound()

        default:
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
    }
}
