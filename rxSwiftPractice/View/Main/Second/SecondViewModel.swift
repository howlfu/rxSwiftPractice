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
    let coordinator: MainCoordinator!
    
    init(coor: MainCoordinator) {
        coordinator = coor
    }
    
    func backToLogin() {
        self.coordinator.backToLogin()
    }
    
    func getWeather(county:String, town: String) {
        let urlReq = UrlRequestService()
        var countyData = county, townData = town
        if countyData == "" || townData == "" {
            countyData = "新北市"
            townData = "樹林區"
        }
        guard let weatherObserver = urlReq.WeatherGetRet(county: countyData, town: townData) else {
            return
        }
        
        weatherObserver.subscribe(onNext: { [self] data in
            temperate.onNext(data.weather.temperature)
            rainRate.onNext(data.weather.rain_chance)
            humiRate.onNext(data.weather.humidity)
            desc.onNext(data.weather.desc)
        }, onError: { [self] error in
            temperate.onError(error)
        }, onCompleted: {
            print("取得 json 任务成功完成")
        }, onDisposed: {
            print("disposed")
        })
    }
    
    func logoutAct() {
        UserService.shared.clear()
        logout.onNext(true)
    }
    
    func toImageFlow() {
        coordinator.secToImageFlow()
    }
}
