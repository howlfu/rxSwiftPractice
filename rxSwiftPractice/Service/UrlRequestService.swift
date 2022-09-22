//
//  UrlRequestService.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/21.
//

import Foundation
import RxSwift

class UrlRequestService: NSObject, URLSessionDelegate{
    func WeatherGetRet() -> Observable<WeatherModel>?{
        let urlStr = UrlRequest.weather
        let paras = [
//            "code": "7601921"
            "county": "新北市",
            "town": "樹林區"
        ]
        let getData: Observable<WeatherModel> = baseGetPattern(url: urlStr, paras: paras)
        return getData
    }
    
    private func baseGetPattern<T:Decodable>(url: String, paras: [String: String]) -> Observable<T>{
        return Observable.create{(observer) -> Disposable in
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
            var components = URLComponents(string: url)!
            components.queryItems = paras.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            let request = URLRequest(url: components.url!)
            
            let task = session.dataTask(with: request) {
                (data, response, error) in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let json = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(json)
                }catch {
                    print("JSON parse fail: \(error)")
                    observer.onError(error)
                    return
             
                }
                observer.onCompleted()
                
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.serverTrust == nil {
                completionHandler(.useCredential, nil)
            } else {
                let trust: SecTrust = challenge.protectionSpace.serverTrust!
                let credential = URLCredential(trust: trust)
                completionHandler(.useCredential, credential)
            }
        }
}

