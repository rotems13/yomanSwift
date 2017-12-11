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
    
    static func getData(url:String,method : Alamofire.HTTPMethod,  parameters: [String: Any]!, headers:[String: String]? , completionHandler: @escaping (JSON?, Error?) -> ()){
                
        Alamofire.request(url,method: method , parameters: parameters ,encoding: JSONEncoding.default, headers: headers).responseJSON{
            (response) in
            switch response.result {
            case .success(let value):
                if response.response?.statusCode == 200 {
                    //                print(response.response?.statusCode as Any)
                    //                print(response.response)

                    let data: Data  = response.data!
                    let responseData = String(data: data, encoding: String.Encoding.utf8)
                    print(responseData as Any)
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    guard let JsonItem = json as? JSON  else{ return}
                    
                    completionHandler(JsonItem as? JSON, nil)

                }
                
                else {print("Error - code not 200 ")
                }
            case .failure(let error):
                completionHandler(nil , error)
                print(error)

            }
        }
    }
}
    
    


