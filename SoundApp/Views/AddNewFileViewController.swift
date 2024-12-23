//
//  AddNewFileViewController.swift
//  SoundApp
//
//  Created by Faisal Iqbal on 19/12/2024.
//

import UIKit
import MobileCoreServices

class AddNewFileViewController: UIViewController {
    
    private let addNewFileButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add New File", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let fileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "No file selected"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        addTargets()
    }
    private func setupViews() {
        view.addSubview(addNewFileButton)
        view.addSubview(fileNameLabel)
        
        NSLayoutConstraint.activate([
            addNewFileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewFileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addNewFileButton.heightAnchor.constraint(equalToConstant: 60),
            addNewFileButton.widthAnchor.constraint(equalToConstant: 150),
            
            fileNameLabel.topAnchor.constraint(equalTo: addNewFileButton.bottomAnchor, constant: 20),
            fileNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fileNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fileNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private func addTargets() {
        addNewFileButton.addTarget(self, action: #selector(addNewFileTapped), for: .touchUpInside)
    }
    @objc private func addNewFileTapped() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}
extension AddNewFileViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        if selectedFileURL.pathExtension.lowercased() == "mp3" {
            fileNameLabel.text = "Selected File: \(selectedFileURL.lastPathComponent)"
        } else {
            fileNameLabel.text = "Invalid file type. Please select an MP3 file."
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        fileNameLabel.text = "File selection cancelled."
    }
}
