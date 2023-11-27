//
//  APIClient.swift
//  mile&task
//
//  Created by 中川 匠 on 2023/11/25.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    // MARK: Target
    case getTargets
    
    var baseURL: URL{
        return URL(string: APIConst.BASE_URL)!
    }
    
    var headers: HTTPHeaders {
        [
            //TODO: Tokenの実装
            //            "Authorization": "Bearer \(Keychain()[KeychainKey.API_TOKEN] ?? "")",
            "Accept": "application/json",
            "Os-Type": "ios",
            "App-Version": Router.appVersion()
        ]
    }
    
    var timeoutInterval: TimeInterval {3.0}
    
    var method: HTTPMethod {
        switch self {
        case .getTargets:
            return .get
        }
        
       
        
    }
    var path: String {
        switch self {
        case .getTargets:
            return APIConst.GET_TARGETS
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = try URLRequest(url: url,
                                     method: method,
                                     headers: headers)
        switch self {
        default:
            break
        }
        return request
    }
}

extension Router {
    
    static func request(_ router : Router) -> DataRequest{
        AF.request(router)
    }
    
    static func appVersion() -> String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            print("app versionの取得に失敗しました")
            return ""
        }
        return version
    }
    
    static func cancelAllRequest() {
        
        AF.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
    
}
