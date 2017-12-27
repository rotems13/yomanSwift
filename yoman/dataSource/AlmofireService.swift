//
//  AlmofireService.swift
//  yoman
//
//  Created by רותם שיין on 30/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire

class AlmofireService {
    
    static func getData(url:String,method : Alamofire.HTTPMethod,  parameters: [String: Any]!, headers:[String: String]? , completionHandler: @escaping (JSON?, String?) -> ()){
                
        Alamofire.request(url,method: method , parameters: parameters ,encoding: JSONEncoding.default, headers: headers).responseJSON{
            (response) in
            switch response.result {
            case .success:
                    let data: Data  = response.data!
                    let responseData = String(data: data, encoding: String.Encoding.utf8)
                    print(responseData as Any)
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    guard let JsonItem = json as? JSON  else{ return}
                    
                if response.response?.statusCode == 200 {

                    completionHandler(JsonItem , nil)

                }
                else {
        
                    let messege = JsonItem["Message"] as? String
                     completionHandler(nil , messege)
                }
                
            case .failure(let error):
                completionHandler(nil , error as? String)
                print(error)

            }
        }
    }
}
    
    


