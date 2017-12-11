//
//  FutureDataSource.swift
//  yoman
//
//  Created by רותם שיין on 29/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire

let semaphore1 = DispatchSemaphore(value: 1)




class FutureDataSource {
    static func getData(completion: @escaping (_ result: [futureEvent]) -> ()){
        var result = [futureEvent]()
        
        let queue = OperationQueue()
        queue.addOperation {
            let GetEventsUrl = "https://mdev1.yoman.co.il/api/Client/GetEvents?siteNick=" + acount.nick + "&phoneNum=" + phoneNumber!
            
//            let parameters: Parameters = ["siteNick" : acount.nick, "phoneNum": phoneNumber!,]
            semaphore.wait()
            
            AlmofireService.getData(url: GetEventsUrl, method: .get, parameters: nil, headers: ["TaTtkn" : TaTtkn!]) {responseObject, error in
//                print(responseObject!)
                
                let accArr = responseObject!["data"] as? [JSON]
                
                for item in accArr! {
                    //description
                    guard let resource = item["resource"] as? String,
                        let services = item["services"] as? String,
                        let status = item["eStatus"] as? String,
                        let eColor = item["eColor"] as? String,
                        let eStatusColor = item["eStatusColor"] as? String,
                        let eURL = item["eURL"] as? String
                        else {return}
                    
                    let ev = futureEvent(startTime: "12:00", resource: resource, services: services, status: status, eColor: eColor, date: "1/1/2018", Url: eURL, year: 18, month: 01, day: 01, hour: 12, minute: 00)
                    result.append(ev)
                }
                print("finish bring ")
//                print(result)
                semaphore.signal();
                completion(result)
            }
        }
    }
}



