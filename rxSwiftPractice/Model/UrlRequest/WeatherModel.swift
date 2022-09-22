//
//  WeatherModel.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/21.
//

import Foundation
//{
//    "weather": {
//        "desc": "多雲",
//        "temperature": 27,
//        "humidity": 94,
//        "rain_chance": 10
//    },
//    "alarm_set": [{
//      "type": "flood"
//      "title": "淹水"
//      "desc": "某某區淹水嚴重"
//     }]
//}
struct WeatherModel: Decodable {
    let weather: WeatherDetail
    let alarm_set: [AlarmDetail]
}

struct WeatherDetail: Decodable {
    let desc: String
    let temperature: Int
    let humidity: Int
    let rain_chance: Int
    let pm25: Int?
}

struct AlarmDetail: Decodable {
    let type: String  //eng
    let title: String //chi
    let desc: String
}


