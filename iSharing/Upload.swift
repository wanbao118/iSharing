//
//  Upload.swift
//  iSharing
//
//  Created by 姜万宝 on 08/03/2018.
//  Copyright © 2018 姜万宝. All rights reserved.
//

import Foundation
import UIKit

//let boundaryStr = "--"
//let boundaryID = "aws-file-upload"

func uploadFileToAWS(urlString: String, name: String, fileName: String, mimeType: String, parameters: [String: String], fileData: Data, sucess:@escaping (NSData?)-> Void, failure:@escaping (NSData?)->Void){
    
    let request:NSMutableURLRequest = NSMutableURLRequest()
    request.url = NSURL(string: urlString)! as URL
    request.httpMethod = "POST"
    request.timeoutInterval = 10
    let body:NSMutableData = NSMutableData()
    //设置表单分隔符
    let boundary:NSString = "----------------------1465789351321346"
    let contentType = "multipart/form-data;boundary=\(boundary)"
    request.addValue(contentType, forHTTPHeaderField: "Content-Type")
    //写入Info内容
    for(key, value) in parameters {
        body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"%@\r\n", value).data(using: String.Encoding.utf8.rawValue)!)
    }
    
    //写入图片内容
    let ImgPath = fileName
    print(ImgPath)
    body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
    body.append(NSString(format: "Content-Disposition:form-data;name=\"%@\";filename=\"\(ImgPath)\"\r\n" as NSString, "file").data(using: String.Encoding.utf8.rawValue)!)
    body.append("Content-Type:image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
    body.append(fileData)
    body.append("\r\n".data(using: String.Encoding.utf8)!)
    
    //写入尾部
    body.append(NSString(format: "--%@--\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
    request.httpBody = body as Data
    
    print(request)
    
    //method 1: session uploadTaskWithRequest
    let session=URLSession.shared
    let task = session.uploadTask(with: request as URLRequest, from: nil) { (responseData, response, error) -> Void in
        if error==nil{
            sucess(responseData as NSData?)
        }
        else{
            failure(error as? NSData)
        }
    }
    print(task.progress)
    task.resume()
    
    //method 2: session dataTaskWithRequest
    //    let session = URLSession.shared
    //    session.dataTask(with: request as URLRequest, completionHandler: {(responseData, response, error) in
    //        if responseData != nil {
    //            sucess(responseData as NSData?)
    //        }else if error != nil {
    //            failure(error as? NSData)
    //        }else if response != nil {
    //            print(response ?? "response completed")
    //        }
    //    }).resume()
    
    //method 3: NSURLConnection.sendAsynchronousRequest
    //    let que=OperationQueue()
    //    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: que, completionHandler: {
    //
    //        (response, data, error) ->Void in
    //
    //        if (error != nil){
    //
    //            print(error ?? "")
    //
    //        }else{
    //
    //            //Handle data in NSData type
    //
    //            let tr:String=NSString(data:data!,encoding:String.Encoding.utf8.rawValue)! as String
    //
    //            print(tr)
    //        }
    //
    //    })
    
}

func uploadFileToAWS(viewController: UploadViewController, session: URLSession, urlString: String, name: String, fileName: String, mimeType: String, parameters: [String: String], fileData: Data) -> URLSessionUploadTask {
    
    let request:NSMutableURLRequest = NSMutableURLRequest()
    request.url = NSURL(string: urlString)! as URL
    request.httpMethod = "POST"
    request.timeoutInterval = 10
    let body:NSMutableData = NSMutableData()
    //设置表单分隔符
    let boundary:NSString = "----------------------1465789351321346"
    let contentType = "multipart/form-data;boundary=\(boundary)"
    request.addValue(contentType, forHTTPHeaderField: "Content-Type")
    //写入Info内容
    for(key, value) in parameters {
        body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"%@\r\n", value).data(using: String.Encoding.utf8.rawValue)!)
    }
    
    //写入图片内容
    let ImgPath = fileName
    print(ImgPath)
    body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
    body.append(NSString(format: "Content-Disposition:form-data;name=\"%@\";filename=\"\(ImgPath)\"\r\n" as NSString, "file").data(using: String.Encoding.utf8.rawValue)!)
    body.append("Content-Type:image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
    body.append(fileData)
    body.append("\r\n".data(using: String.Encoding.utf8)!)
    
    //写入尾部
    body.append(NSString(format: "--%@--\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
    request.httpBody = body as Data
    
    print(request)
    
    //method 1: session uploadTaskWithRequest
    //    let session=URLSession.shared
    let task = session.uploadTask(with: request as URLRequest, from: nil) { (responseData, response, error) -> Void in
        if error==nil{
            print(responseData ?? "")
        }
        else{
            print(error ?? "")
            let alertView = UIAlertView(title: "Alert", message: error?.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            viewController.uploadButton.isEnabled = true
        }
    }
    //    print(task.progress)
    //    task.resume()
    return task
}


