//
//  SecondController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/22.
//

import Foundation
class SecondController {
    func getWeather() {
        let urlReq = UrlRequestService()
        guard let weatherObserver = urlReq.WeatherGetRet() else {
            return
        }
        weatherObserver.subscribe(onNext: { data in
            print("溫度：\(data.weather.temperature)°C")
            print("降雨率：\(data.weather.rain_chance)%")
            print("濕度：\(data.weather.humidity)%")
            print("概況：\(data.weather.desc)")
        }, onError: { error in
            print("取得 json 失败 Error: \(error.localizedDescription)")
        }, onCompleted: {
            print("取得 json 任务成功完成")
        })
    }
}
