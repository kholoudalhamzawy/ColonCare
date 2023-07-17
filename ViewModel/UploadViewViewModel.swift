//
//  File.swift
//  colonCancer
//
//  Created by KH on 05/07/2023.
//

import Foundation
import Combine
import FirebaseAuth
import UIKit
import CoreML
import Vision
import CoreImage


final class UploadViewViewModel: ObservableObject {
    
    static var model = UploadViewViewModel()
    
    @Published var dnaSequance: String?
    @Published var colonImage: UIImage?
    @Published var resultLabel: String?
    @Published var requestResults: [String] = []
    @Published var isImageClasified: Bool = false
    @Published var CNNCancerResult: Bool?
    @Published var sequanceCancerResult: Bool?
    @Published var isSsequance: Bool = false
    @Published var row: Int?
    @Published var fileURL: URL?
    @Published var isSequanceDone: Bool = false
    @Published var didGetCNNCancerResult: Bool = false

    private var subscriptions: Set<AnyCancellable> = []
    
    func classifyImage(){
        if isImageClasified {
            
            let newSize = CGSize(width: 64, height: 64)
            
            guard let userPickedImage =  UploadViewViewModel.model.colonImage else {
                fatalError("Failed to find image.")}
            
            guard let resizedImage = userPickedImage.resize(to: newSize) else {
                fatalError("Failed to resize image.")}
            
            let sourceImage = CIImage(image: resizedImage)

            let resizeFilter = CIFilter(name:"CILanczosScaleTransform")!

            // Desired output size
            let targetSize = CGSize(width:64, height:64)

            // Compute scale and corrective aspect ratio
            let scale = targetSize.height / (sourceImage?.extent.height)!
            let aspectRatio = targetSize.width/((sourceImage?.extent.width)! * scale)

            // Apply resizing
            resizeFilter.setValue(sourceImage, forKey: kCIInputImageKey)
            resizeFilter.setValue(scale, forKey: kCIInputScaleKey)
            resizeFilter.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)
            let outputImage = resizeFilter.outputImage
            
            detect(image: outputImage! )
            UploadViewViewModel.model.isImageClasified = false
            
        } else {
            
        }
    }
    
    
    //detect is the function to classify the image
    func detect(image: CIImage){
        
        guard let resnetModel = try? VNCoreMLModel(for: resnet().model)
        else{ fatalError("Loading CoreML Model Failed") }
      
        let request = VNCoreMLRequest(model: resnetModel){ (request, error) in
          guard let results = request.results as? [VNCoreMLFeatureValueObservation] else {
                fatalError("Model failed to process image.")}
    //            print(results)
            
            if let firstResult = results.first{
                let myArr = firstResult.featureValue.multiArrayValue!
                let one = Float(myArr[0])
                print(myArr)
                //resnet
                    print(round(one))
                    if round(one) != 0{
                        
                    UploadViewViewModel.model.resultLabel = "Cancer :("
                    UploadViewViewModel.model.CNNCancerResult = true

                  } else{
                    UploadViewViewModel.model.resultLabel = "Not Concer :)"
                    UploadViewViewModel.model.CNNCancerResult = false
                  }
                
                UploadViewViewModel.model.didGetCNNCancerResult = true

            }

        }
        
        request.imageCropAndScaleOption = .scaleFill
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }catch {
            print(error)
        }
        
        
        
        guard let vggModel = try? VNCoreMLModel(for: vggfinal().model)
        else{ fatalError("Loading CoreML Model Failed") }
      
        let request2 = VNCoreMLRequest(model: vggModel){ (request, error) in
          guard let results2 = request.results as? [VNCoreMLFeatureValueObservation] else {
                fatalError("Model failed to process image.")}
    //            print(results)
            
            if let firstResult2 = results2.first{
                let myArr = firstResult2.featureValue.multiArrayValue!
                let one = Float(myArr[0])
                , two = Float(myArr[1])
                print(myArr)

                //0 cancer 1 not
                if one < two {
                    UploadViewViewModel.model.requestResults.append( "Cancer :(")
                } else{
                    UploadViewViewModel.model.requestResults.append( "Not cancerouse :)")
                }

            }

        }
        
        request2.imageCropAndScaleOption = .scaleFill
        let handler2 = VNImageRequestHandler(ciImage: image)
        do {
            try handler2.perform([request2])
        }catch {
            print(error)
        }
        
    }
    
    func makePredictionRequest() {
        guard let image = UploadViewViewModel.model.colonImage else {
            print("no Image in request")
            return
        }
        // API endpoint URL
        guard let url = URL(string: "http://127.0.0.1:5000/prediction") else {
            print("Invalid URL")
            return
        }
        
        // Convert image to Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            return
        }
        
        // Create request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        // Create multipart/form-data body
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let body = createRequestBody(with: imageData, boundary: boundary)
        request.httpBody = body
        
        // Create URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    print(String(data: data, encoding: .utf8))
//                     Parse JSON response
                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                       let prediction = json["prediction"] as? [Int] {
                        // Handle prediction result
                        print("Prediction: \(prediction)")
//                    let prediction = try JSONDecoder().decode(Int.self, from: data)
                        self.calculateResult(arr: prediction)
                        UploadViewViewModel.model.isImageClasified = false
                    }
                } catch {
                    print("Error parsing JSON response: \(error)")
                }
            }
        }
        
        // Start the request
        task.resume()
    }

    func createRequestBody(with imageData: Data, boundary: String) -> Data {
        var body = Data()
        
        // Add image data to the request body
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"img\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Add final boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    
    func calculateResult(arr: [Int]){
        for i in 0..<arr.count {
            
            if (UploadViewViewModel.model.isSsequance && i==0 ) {
                UploadViewViewModel.model.didGetCNNCancerResult = true
                if (arr[0] == 1) {
                    UploadViewViewModel.model.resultLabel = "Not Concer :)"
                    UploadViewViewModel.model.CNNCancerResult = false
                    
                } else {
                    UploadViewViewModel.model.resultLabel = "Cancer :("
                    UploadViewViewModel.model.CNNCancerResult = true
                    
                }
                continue
            }
            
            else if (arr[i] == 1 ) {
                UploadViewViewModel.model.requestResults.append( "Not cancerouse :)")
            } else {
                UploadViewViewModel.model.requestResults.append( "Cancerouse :(")
            }
        }
        
          
    }
    
    
    func validateSequanceRequest(){
        guard let fileURL =  UploadViewViewModel.model.fileURL,
              let fileRow =  UploadViewViewModel.model.row
              else {
                  UploadViewViewModel.model.isSequanceDone = false
                  print ("empty")
            return
        }
        UploadViewViewModel.model.isSequanceDone = true

    }
    

    
    func makeRequest(){
       
        // Create a request
        let url = URL(string: "http://127.0.0.1:5000/sequance")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the file as the request body
        let fileData = try! Data(contentsOf: UploadViewViewModel.model.fileURL!)
        let boundary = "Boundary-\(UUID().uuidString)"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\( UploadViewViewModel.model.fileURL!.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Add the 'row' field to the request body
        let row =  UploadViewViewModel.model.row!// Replace with your desired value
        let rowFieldData = "row=\(row)".data(using: .utf8)!
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"row\"\r\n\r\n".data(using: .utf8)!)
        body.append(rowFieldData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle the response from the Flask backend
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                       let prediction = json["prediction"] as? [Int] {
                        // Handle prediction result
                        print("Prediction: \(prediction)")
    //                    let prediction = try JSONDecoder().decode(Int.self, from: data)
                        self.calculateResult(arr: prediction)
                        UploadViewViewModel.model.isImageClasified = false
                    }
                } catch {
                    print("Prediction: error")

                    return
                }
            }
        }
        task.resume()
    }

        
    

    
    
}

extension UIImage {
    
    // Helper method to resize a UIImage to a specific size
    
        func resize(to newSize: CGSize) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            defer { UIGraphicsEndImageContext() }
            self.draw(in: CGRect(origin: .zero, size: newSize))
            return UIGraphicsGetImageFromCurrentImageContext()
        
    }
    
    
}
