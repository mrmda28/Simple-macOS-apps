//
//  ViewController.swift
//  URL-Shortener
//
//  Created by Dmitriy Maslennikov on 02/01/2022.
//  Copyright © 2022 Dmitriy Maslennikov. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    private let label: NSTextField = {
        let label = NSTextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.stringValue = "URL Shortener"
        label.isBezeled = false
        label.drawsBackground = false
        label.isEditable = false
        label.isSelectable = false
        label.font = NSFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let inputField: NSTextField = {
        let field = NSTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholderString = "URL to shorten"
        field.wantsLayer = true
        field.layer?.cornerRadius = 5
        return field
    }()
    
    private let clearButton: NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "✕"
        button.wantsLayer = true
        button.isBordered = false
        button.action = #selector(clearField)
        return button
    }()
    
    @objc private func clearField() {
        inputField.stringValue = ""
        outputField.stringValue = ""
        clipboardButton.layer?.borderColor = .clear
    }
    
    private let outputField: NSTextField = {
        let field = NSTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholderString = "Shortened URL"
        field.isEditable = false
        field.isSelectable = true
        field.wantsLayer = true
        field.layer?.cornerRadius = 5
        return field
    }()
    
    private let clipboardButton: NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "❏"
        button.wantsLayer = true
        button.isBordered = false
        button.layer?.cornerRadius = 10
        button.layer?.borderColor = .clear
        button.layer?.backgroundColor = .clear
        button.layer?.borderWidth = 1
        button.action = #selector(copyURL)
        return button
    }()
    
    @objc private func copyURL() {
        guard outputField.stringValue != "" else { return }
        
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(outputField.stringValue, forType: .string)
        
        clipboardButton.layer?.borderColor = .init(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)
    }
    
    private let shortenButton: NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Shorten"
        button.contentTintColor = .white
        button.wantsLayer = true
        button.isBordered = false
        button.layer?.cornerRadius = 8
        button.layer?.backgroundColor = CGColor(red: 37/255.0, green: 25/255.0, blue: 195/255.0, alpha: 1.0)
        button.action = #selector(getURL)
        return button
    }()
    
    @objc private func getURL() {
        guard inputField.stringValue != "" else { return }
        
        outputField.stringValue = inputField.stringValue
        clipboardButton.layer?.borderColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }

    override var representedObject: Any? {
        didSet {}
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.title = "URL Shortener"
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(inputField)
        view.addSubview(clearButton)
        view.addSubview(outputField)
        view.addSubview(clipboardButton)
        view.addSubview(shortenButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 300),
            view.heightAnchor.constraint(equalToConstant: 160),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 20),
            
            inputField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            inputField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            inputField.widthAnchor.constraint(equalToConstant: 300 - 65),
            inputField.heightAnchor.constraint(equalToConstant: 20),
            
            clearButton.centerYAnchor.constraint(equalTo: inputField.centerYAnchor),
            clearButton.leftAnchor.constraint(equalTo: inputField.rightAnchor, constant: 5),
            clearButton.widthAnchor.constraint(equalToConstant: 20),
            clearButton.heightAnchor.constraint(equalToConstant: 20),

            outputField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            outputField.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 12),
            outputField.widthAnchor.constraint(equalToConstant: 300 - 65),
            outputField.heightAnchor.constraint(equalToConstant: 20),
            
            clipboardButton.centerYAnchor.constraint(equalTo: outputField.centerYAnchor),
            clipboardButton.leftAnchor.constraint(equalTo: outputField.rightAnchor, constant: 5),
            clipboardButton.widthAnchor.constraint(equalToConstant: 20),
            clipboardButton.heightAnchor.constraint(equalToConstant: 20),
            
            shortenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shortenButton.topAnchor.constraint(equalTo: outputField.bottomAnchor, constant: 12),
            shortenButton.widthAnchor.constraint(equalToConstant: 100),
            shortenButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

