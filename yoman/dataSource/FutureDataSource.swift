//
//  FutureDataSource.swift
//  yoman
//
//  Created by רותם שיין on 29/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire

class FutureDataSource {
    static func getData(completion: @escaping ([futureEvent]?, String?) -> ()){
       
        var result = [futureEvent]()
        let GetEventsUrl = "https://mdev1.yoman.co.il/api/Client/GetEvents?siteNick=" + acount.nick + "&phoneNum=" + phoneNumber!
        
        AlmofireService.getData(url: GetEventsUrl, method: .get, parameters: nil, headers: ["TaTtkn" : TaTtkn!], completionHandler: {success, err in
            if success != nil {
                let accArr = success!["data"] as? [JSON]
                
                for item in accArr! {

                    guard let resource = item["resource"] as? String,
                        let services = item["services"] as? String,
                        let status = item["eStatus"] as? String,
                        let eColor = item["eColor"] as? String,
                        let eStatusColor = item["eStatusColor"] as? String,
                        let eURL = item["eURL"] as? String,
                        let dt = item["dt"] as? String
                        
                        else {return}
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    let date = dateFormatter.date(from: dt)!
                    
                    let calendar = NSCalendar.current
                    let hour = calendar.component(.hour, from: date )
                    let minutes = calendar.component(.minute, from: date)
                    let day = calendar.component(.day, from: date)
                    let month = calendar.component(.month, from: date)
                    let year = calendar.component(.year, from: date)
                    
                    let theDateFormatHeader = DateFormatter()
                    theDateFormatHeader.dateStyle = DateFormatter.Style.full
                    theDateFormatHeader.locale = Locale(identifier: "he_IL")
                    
                    let dateString = theDateFormatHeader.string(from: date)
                    
                    let fullTimeFormat = DateFormatter()
                    fullTimeFormat.timeStyle = .short
                    let timeString = fullTimeFormat.string(from: date)
                    
                    let ev = futureEvent(startTime: timeString , resource: resource, services: services, status: status, eColor: eColor,eStatusColor: eStatusColor, date: dateString, Url: eURL, year: year, month: month, day: day, hour: hour, minute: minutes, dateObj: date)
                    result.append(ev)
                }
                result.sort(by: { $0.dateObj < $1.dateObj })
                
                print("finish bring ")
                completion(result, nil)
            }else {
                completion(nil, err)
            }
        })
    }
}




