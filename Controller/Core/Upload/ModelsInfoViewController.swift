//
//  ModelsInfoViewController.swift
//  colonCancer
//
//  Created by KH on 08/07/2023.
//

import UIKit

class ModelsInfoViewController: UIViewController, UITextViewDelegate {
    
    
    private var body: UITextView = {
        let label = UITextView()
        label.textColor = .label
        label.isEditable = false
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Regular", size: 20)

        return label
    }()
    
    func configureNavigationBar(){
        let ReminderView = UILabel()
        ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
        ReminderView.textColor = .label
        if UploadViewViewModel.model.isSsequance {
            ReminderView.text =  "Hard Voting"
        } else {
            ReminderView.text = "ResNet50"
        }
        navigationItem.titleView = ReminderView
      
    }

    private var header: String = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        body.delegate = self

        colors.setBackGround(view)
        view.addSubview(body)
        //this dosent work
//        body.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        body.widthAnchor.constraint(equalToConstant: 355).isActive = true
        body.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        body.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        body.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        body.contentOffset = CGPoint.zero
      
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false
        
        if UploadViewViewModel.model.isSsequance {
            body.text = """

        Accuracy of Model: 95%

        - Hard Voting Classifier:
        
        The hard voting classifier is an ensemble method that combines multiple individual classifiers and makes predictions based on a majority vote.
        Each individual classifier independently predicts the class label, and the class label that receives the most votes is chosen as the final prediction.
        In the case of ties, the class label selected can be based on different tie-breaking rules (e.g., first occurrence, highest confidence score).
        The hard voting classifier can be used for both classification and regression tasks.
        It benefits from the diversity of the individual classifiers, as they may use different algorithms or have different strengths and weaknesses.
        The hard voting classifier tends to be more robust and accurate than any single individual classifier if the individual classifiers are sufficiently diverse.

       - Decision Tree Classifier:

        The decision tree classifier is a predictive model that uses a tree-like structure to make decisions based on features in the input data.
        It splits the data based on feature values and creates decision rules at each internal node of the tree.
        The decision tree classifier can handle both categorical and numerical features.
        It is easy to interpret and visualize, making it useful for understanding the decision-making process.
        Decision trees are prone to overfitting, so techniques like pruning can be used to prevent overfitting.
        K-Nearest Neighbors (KNN) Classifier:

        The KNN classifier is a non-parametric lazy learning algorithm used for classification tasks.
        It classifies new data points based on the majority vote of their k nearest neighbors in the training dataset.
        The choice of k (number of neighbors) and the distance metric (e.g., Euclidean, Manhattan) can affect the performance of the KNN classifier.
        KNN can handle both categorical and numerical features and does not assume any underlying distribution of the data.
        It is relatively simple and easy to implement but can be computationally expensive for large datasets.

        - Support Vector Machine (SVM) Classifier:

        The SVM classifier finds an optimal hyperplane that separates data points of different classes with the maximum margin.
        It is effective in high-dimensional spaces and less affected by the curse of dimensionality.
        SVM can handle both linear and non-linear classification problems by using different kernel functions (e.g., linear, polynomial, radial basis function).
        It can handle both categorical and numerical features and is known for handling outliers well.
        SVM can be memory-intensive and training time can be longer for large datasets.
        By combining the decision tree, KNN, and SVM classifiers in a hard voting classifier, you benefit from the diverse perspectives and decision-making strategies of each individual classifier. The final prediction is based on the majority vote of the individual classifiers.

"""
        
        } else {
            body.text = """

    Accuracy of Model: 100%

    ResNet-50 is a deep convolutional neural network architecture that was introduced by Microsoft Research in 2015. It is part of the ResNet (Residual Network) family of models and has been widely used for various computer vision tasks, including image classification, object detection, and image segmentation.

    Here are some key features of the ResNet-50 architecture:

    - Deep Network: ResNet-50 is a deep neural network consisting of 50 layers. It is deeper than previous network architectures like VGG-16 and VGG-19.

    - Skip Connections: ResNet-50 introduced the concept of skip connections or residual connections. These connections allow the network to learn residual mappings, which help in mitigating the degradation problem caused by deep networks. By propagating the input signal directly to deeper layers, ResNet-50 enables the network to learn more effectively and improves gradient flow during training.

    - Convolutional Layers: ResNet-50 primarily consists of convolutional layers, which are responsible for learning hierarchical features from the input image. The network employs various sizes of convolutional filters, including 1x1, 3x3, and 1x1 filters, to capture different levels of information.

    - Pooling Layers: ResNet-50 includes max pooling layers, which downsample the feature maps and reduce spatial dimensions while retaining important features. Max pooling helps in extracting the most relevant information from the feature maps.

    - Fully Connected Layers: At the end of the network, ResNet-50 typically includes fully connected layers followed by a softmax activation function for classification tasks. These layers perform the final classification based on the extracted features.

    ResNet-50 has achieved state-of-the-art performance on various benchmark datasets, such as ImageNet, and has become a popular architecture for transfer learning and feature extraction in computer vision applications.
    """
        }
        
    }
    

   
}

