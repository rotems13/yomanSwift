
//
//  accountsDataSource.swift
//  yoman
//
//  Created by רותם שיין on 29/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire

let semaphore = DispatchSemaphore(value: 1)

class accountsDataSource {
    static func getData(completion: @escaping (_ result: [Account]) -> ()){
        var result = [Account]()
        
        let queue = OperationQueue()
        queue.addOperation {
            let mySitesUrl = "https://mdev1.yoman.co.il/api/Client/GetMySites"
            semaphore.wait()
            
            AlmofireService.getData(url: mySitesUrl, method: .get, parameters: nil, headers: ["TaTtkn" : TaTtkn!]) {responseObject, error in
                
                let accArr = responseObject!["data"] as? [JSON]
                
                for acc in accArr! {
                    guard let nick = acc["nick"] as? String,
                        let title = acc["title"] as? String,
                        let contactAddress = acc["contactAddress"] as? String,
                        let contactNumber = acc["contactNumber"] as? String,
                        let futureEvents = acc["futureEvents"] as? Int,
                        let siteURL = acc["siteURL"] as? String else {return}
                    
                    let account = Account(nick: nick, title: title, contactNumber: contactNumber, contactAdress: contactAddress, futureEvents: futureEvents, siteURL: siteURL)
                    result.append(account)
                }
                print("finish bring ")
                semaphore.signal();
                completion(result)
            }
        }
    }
}
typealias JSON = [String: Any]

//            Alamofire.request(mySitesUrl,method: .get ,encoding: JSONEncoding.default, headers: ["TaTtkn" : Tkn!]).responseJSON { response in
//                switch response.result {
//                case .success:
//                    if response.response?.statusCode == 200 {
//                        let data: Data // received from a network request, for example
//                        data = response.data!
//
//                        //                let responseData = String(data: data, encoding: String.Encoding.utf8)
//                        //                print(responseData)
//
//                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                        print(json)
//                        guard let item = json as? JSON,
//                            let accArr = item["data"] as? [JSON]
//
//                            else{ return}
//
//                        for acc in accArr {
//                            //description
//                            guard let nick = acc["nick"] as? String,
//                                let title = acc["title"] as? String,
//                                //let description = acc["description"] as? String,
//                                let contactAddress = acc["contactAddress"] as? String,
//                                let contactNumber = acc["contactNumber"] as? String,
//                                let futureEvents = acc["futureEvents"] as? Int,
//                                let siteURL = acc["siteURL"] as? String
//
//                                else {return}
//
//                            let account = Account(nick: nick, title: title, contactNumber: contactNumber, contactAdress: contactAddress, futureEvents: futureEvents, siteURL: siteURL)
//                            result.append(account)
//                            print(account)
//
//                        }
//                        semaphore.signal();
//                        print("result!!!!!")
//                        print(result)
//                    }
//
//                    else {print("Error - code not 200 in accountsDataSource ")}
//
//
//                case .failure(let error):
//                    print(error)
//                }
//            }
//            semaphore.wait();
//            print("finish??")
//
//        }
//        print("returning")
//        return result
//
//    }
//}


