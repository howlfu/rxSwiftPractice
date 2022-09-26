//
//  SecondController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/22.
//

import Foundation
import RxSwift
class SecondViewModel {
    let temperate : PublishSubject<Int> = PublishSubject()
    let rainRate : PublishSubject<Int> = PublishSubject()
    let humiRate : PublishSubject<Int> = PublishSubject()
    let desc: PublishSubject<String> = PublishSubject()
    let logout: PublishSubject<Bool> = PublishSubject()
    let disposeBag = DisposeBag()
    init() {
        
    }
    
    func getWeather(county:String, town: String) {
        let urlReq = UrlRequestService()
        guard let weatherObserver = urlReq.WeatherGetRet(county: county, town: town) else {
            return
        }
        weatherObserver.subscribe(onNext: { [self] data in
            temperate.onNext(data.weather.temperature)
            rainRate.onNext(data.weather.rain_chance)
            humiRate.onNext(data.weather.humidity)
            desc.onNext(data.weather.desc)
        }, onError: { [self] error in
            temperate.onError(error)
            rainRate.onError(error)
        }, onCompleted: {
            print("取得 json 任务成功完成")
        })
    }
    
    func logoutAct() {
        UserService.shared.clear()
        logout.onNext(true)
    }
}
