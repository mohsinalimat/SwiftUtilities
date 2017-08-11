//
//  WebServices.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import Foundation

import Alamofire

typealias CompletionBlock = (AnyObject, AnyObject) -> Void

typealias FailureBlock = (AnyObject, AnyObject) -> Void

// ((Swift.Int) -> Swift.Void)? = nil )

// http://fuckingswiftblocksyntax.com

/// https://www.raywenderlich.com/121540/alamofire-tutorial-getting-started

class WebServices {

    class func post(jsonObject: AnyObject, completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {

        let parameters: Parameters = (jsonObject as? Parameters)!

        Alamofire.request(baseURL, method: .post, parameters: parameters)

            .responseJSON {
            response in

            print(response.request as Any) // original URL request

            print(response.response as Any) // HTTP URL response

            print(response.data as Any) // server data

            print(response.result) // result of response serialization

            if let json = response.result.value {

                print("WebServices : - ", json)

                completionHandler!(json as AnyObject, response.result as AnyObject)
            } else {

                failureHandler?("" as AnyObject, "" as AnyObject)

            }

        }
        .responseString { _ in
            // print("responseString Success: \(response.result.isSuccess)")

            //  print("Response String: \(response.result.value)")
        }

        .responseData { response in
            debugPrint("responseData All Response Info: \(response)")

            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }

    class func upload(jsonObject: AnyObject, files: Array<Any>? = nil, completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {

        Alamofire.upload(multipartFormData: { multipartFormData in

                if let filesO = files {
                    for i in filesO.enumerated() {
                        let image = UIImage(named: "\(i.element)")

                        let data = UIImageJPEGRepresentation(image!, 1)!

                        multipartFormData.append(data, withName: "imgFiles[]", fileName: "\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")

                        // imgFiles[] give array in Php Side

                        // imgFiles   will give string in PHP String

                    }

                }

                for (key, value) in jsonObject as! [String: String] {

                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)

                }

            },
                         to: baseURL) { result
            in
            switch result {
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { _ in
                        // Print progress
                })

                upload.responseJSON { response in

                    print("JSON: \(response)")

                    if let json = response.result.value {
                        print("JSON: \(json)")

                        completionHandler!(json as AnyObject, response.result as AnyObject)
                    } else {
                        failureHandler?("" as AnyObject, "" as AnyObject)

                    }

                }
            case .failure(let encodingError):
                failureHandler?("" as AnyObject, "" as AnyObject)
                print(encodingError)

            }

        }

    }

}
