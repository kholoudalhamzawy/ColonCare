//
//  SearchViewController.swift
//  colonCancer
//
//  Created by KH on 21/04/2023.
//

import UIKit
import PhotosUI
import Combine

class uploadPhotoViewController: UIViewController {
    
    private var subscriptions: Set<AnyCancellable> = []

    
    private let colonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.clipsToBounds = true
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 60
//        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "tray.and.arrow.up")
        imageView.tintColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let uploadLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 18)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.text = "Upload a colon image from gallery, or a Dna Sequence from files..."
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uploadImageBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderWidth = 0.5
        btn.setTitle("Image", for: .normal)
        btn.addTarget(self, action: #selector(didTapToUpload), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let uploadSequanceBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.setTitleColor(.white.withAlphaComponent(0.7), for: .disabled) //this makes the button dim when it's disabaled
        btn.layer.borderWidth = 0.5
        btn.setTitle("Sequance", for: .normal)
        btn.addTarget(self, action: #selector(didTapToUploadSequance), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private let classifyBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.setTitleColor(.white.withAlphaComponent(0.4), for: .disabled) //this makes the button dim when it's disabaled
        btn.layer.borderWidth = 0.5
        btn.setTitle("Classify", for: .normal)
        btn.addTarget(self, action: #selector(didTapToClassify), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        
        return btn
    }()
    
    
    @objc private func didTapToUploadSequance() {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
      
          
          present(documentPicker, animated: true, completion: nil)

      }
      
      @objc func nextButtonTapped() {
      // Create and present the new view controller
            let newViewController = EnterRowViewController()
            self.present(newViewController, animated: true, completion: nil)
          
      }
        
    
    
    @objc func didTapToClassify(){
        print("Classify!")
        if UploadViewViewModel.model.isSsequance {
            UploadViewViewModel.model.isImageClasified = true
            UploadViewViewModel.model.makeRequest()
        } else {
            UploadViewViewModel.model.isImageClasified = true
            UploadViewViewModel.model.classifyImage()
            UploadViewViewModel.model.makePredictionRequest()

        }
        
        
    }
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images //accepts only images
        configuration.selectionLimit = 1 //aceepts one image
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
        
    
    func configureNavigationBar(){
        let ReminderView = UILabel()
        ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
        ReminderView.textColor = .label
        ReminderView.text = "Classification"
        navigationItem.titleView = ReminderView
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapPlus))
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors.setBackGround(view)
        configureNavigationBar()
        view.addSubview(colonImageView)
        view.addSubview(uploadLbl)
        view.addSubview(uploadImageBtn)
        view.addSubview(uploadSequanceBtn)
        view.addSubview(classifyBtn)
        bindViews()

        colonImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload))) //adding an action for a view like a button
        configureConstraints()

    }
    
    private func configureConstraints() {
        
        let colonImageViewConstraints = [
            colonImageView.widthAnchor.constraint(equalToConstant: 100),
            colonImageView.heightAnchor.constraint(equalToConstant: 100),
            colonImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            colonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ]
        let uploadLabelConstraints = [
            uploadLbl.widthAnchor.constraint(equalToConstant: 330),
            uploadLbl.heightAnchor.constraint(equalToConstant: 70),
            uploadLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadLbl.topAnchor.constraint(equalTo: colonImageView.bottomAnchor, constant: 20)
        ]
        
        let uploadImageBtnConstraints = [
            uploadImageBtn.widthAnchor.constraint(equalToConstant: 150),
            uploadImageBtn.heightAnchor.constraint(equalToConstant: 45),
            uploadImageBtn.topAnchor.constraint(equalTo: uploadLbl.bottomAnchor, constant: 60),
            uploadImageBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35)

        ]
        
        let uploadSequanceBtnBtnConstraints = [
            uploadSequanceBtn.widthAnchor.constraint(equalToConstant: 150),
            uploadSequanceBtn.heightAnchor.constraint(equalToConstant: 45),
            uploadSequanceBtn.topAnchor.constraint(equalTo: uploadLbl.bottomAnchor, constant: 60),
            uploadSequanceBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)

         
        ]
        
        let classifyBtnConstraints = [
            classifyBtn.widthAnchor.constraint(equalToConstant: 320),
            classifyBtn.heightAnchor.constraint(equalToConstant: 45),
            classifyBtn.topAnchor.constraint(equalTo: uploadImageBtn.bottomAnchor, constant: 35),
            classifyBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         
        ]
        NSLayoutConstraint.activate(colonImageViewConstraints)
        NSLayoutConstraint.activate(uploadLabelConstraints)
        NSLayoutConstraint.activate(uploadImageBtnConstraints)
        NSLayoutConstraint.activate(uploadSequanceBtnBtnConstraints)
        NSLayoutConstraint.activate(classifyBtnConstraints)

    }
    



}

extension uploadPhotoViewController: UIDocumentPickerDelegate {
    

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let fileURL = urls.first else {
            return
        }
        UploadViewViewModel.model.fileURL = fileURL
        let newViewController = EnterRowViewController()
        newViewController.hidesBottomBarWhenPushed = true
//        let vc = UINavigationController(rootViewController: HelloViewController())
        present(newViewController, animated: true)

      
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func bindViews(){
       
        UploadViewViewModel.model.$isSequanceDone.sink{ [weak self] validationState in
            if validationState {
                UploadViewViewModel.model.isSsequance = true
                self?.colonImageView.image = UIImage(systemName: "doc.fill")
                self?.classifyBtn.isEnabled = true
            }

        }
        .store(in: &subscriptions)
        
        UploadViewViewModel.model.$didGetCNNCancerResult.sink{ [weak self] validationState in
            if validationState {
                DispatchQueue.main.async {
                    let vc = ResultViewController()
                    vc.hidesBottomBarWhenPushed = true
                    self?.navigationController?.pushViewController(vc, animated: true)
                    self?.colonImageView.image = UIImage(systemName: "tray.and.arrow.up")
                    self?.classifyBtn.isEnabled = false
                    UploadViewViewModel.model.didGetCNNCancerResult = false
                }
                
               
                
            }
            
        }
        .store(in: &subscriptions)
    }
}



extension uploadPhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true) //to seelect the image and dismiss the gallery picked from
        
        for result in results { //although we specified the results to be one image but it returns an array so we iterate throw it
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.colonImageView.image = image
                        UploadViewViewModel.model.colonImage = image
                        self?.classifyBtn.isEnabled = true
                        UploadViewViewModel.model.isSsequance = false
                        

                    }
                }
            }
        }
    }
    
    
}
