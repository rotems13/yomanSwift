
//
//  accountsDataSource.swift
//  yoman
//
//  Created by רותם שיין on 29/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire
//completionHandler: @escaping (Data?, URLResponse?,
class accountsDataSource {
    static func getData(completion: @escaping ([Account]?, String?) -> ()){
        var result = [Account]()
        let mySitesUrl = "https://mdev1.yoman.co.il/api/Client/GetMySites"
        
        AlmofireService.getData(url: mySitesUrl, method: .get, parameters: nil, headers: ["TaTtkn" : TaTtkn!], completionHandler: { success, err in
            if success != nil {
                
                let accArr = success!["data"] as? [JSON]
    
                for acc in accArr! {
                    guard let nick = acc["nick"] as? String,
                        let title = acc["title"] as? String,
                        let contactAddress = acc["contactAddress"] as? String,
                        let contactNumber = acc["contactNumber"] as? String,
                        let futureEvents = acc["futureEvents"] as? Int,
                        let description = acc["description"] as? String,
                        let siteURL = acc["siteURL"] as? String else {return}
                    
                    let account = Account(nick: nick, title: title, contactNumber: contactNumber, contactAdress: contactAddress, futureEvents: futureEvents, siteURL: siteURL, description: description)
                    result.append(account)
                }
                print("finish bring ")
                completion(result, nil)
            }else {
                completion(nil, err)
            }
        })
    }
}
        typealias JSON = [String: Any]

