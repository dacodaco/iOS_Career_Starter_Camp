//
//  EditViewController.swift
//  ProjectManager
//
//  Created by YB on 2021/07/09.
//

import UIKit

enum Mode {
    case select
    case edit
}

class EditViewController: UIViewController, ModelMakable {

    var mode: Mode = .select
    var leftButton: UIBarButtonItem!
    var rightButton: UIBarButtonItem!
    var indexPath: IndexPath!
    var task: Task!

    let stackView: UIStackView = {
        let myStackView = UIStackView()

        myStackView.axis = .vertical
        myStackView.alignment = .fill
        myStackView.spacing = 10
        myStackView.translatesAutoresizingMaskIntoConstraints = false

        return myStackView
    }()

    var registerTitle: UITextField = {
        let registerTitle = UITextField()

        registerTitle.backgroundColor = .white
        registerTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        registerTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        registerTitle.layer.shadowColor = UIColor.black.cgColor
        registerTitle.layer.shadowOpacity = 0.6
        registerTitle.clipsToBounds = false
        registerTitle.placeholder = "Title"

        registerTitle.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: registerTitle.frame.height))
        registerTitle.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: registerTitle.frame.height))
        registerTitle.leftViewMode = .always
        registerTitle.rightViewMode = .always
        registerTitle.translatesAutoresizingMaskIntoConstraints = false

        return registerTitle
    }()

    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()

    var registerDescription: UITextView = {
        let description = UITextView()

        description.backgroundColor = .white
        description.font = UIFont.preferredFont(forTextStyle: .title3)
        description.layer.shadowOffset = CGSize(width: 0, height: 3)
        description.layer.shadowColor = UIColor.black.cgColor
        description.layer.shadowOpacity = 0.6
        description.clipsToBounds = false
        description.text = "설명을 입력해주세요"
        description.textColor = UIColor.lightGray
        description.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        description.translatesAutoresizingMaskIntoConstraints = false

        return description
    }()

    func setMode(){
        switch mode {
        case .select:
            leftButton = UIBarButtonItem(title: "Edit",
                                         style: .done,
                                         target: self,
                                         action: #selector(didHitEditbutton))
            
            rightButton = UIBarButtonItem(title: "Done",
                                          style: .done,
                                          target: self,
                                          action: #selector(didHitdoneButton))

            navigationItem.leftBarButtonItem = leftButton
            navigationItem.rightBarButtonItem = rightButton

            registerTitle.isUserInteractionEnabled = false
            datePicker.isUserInteractionEnabled = false
            registerDescription.isUserInteractionEnabled = false
        case .edit:
            leftButton = UIBarButtonItem(title: "Cancel",
                                         style: .done,
                                         target: self,
                                         action: #selector(didHitCancelButton))
            
            rightButton = UIBarButtonItem(title: "Done",
                                          style: .done,
                                          target: self,
                                          action: #selector(didHitdoneButton))

            navigationItem.leftBarButtonItem = leftButton
            navigationItem.rightBarButtonItem = rightButton

            registerTitle.isUserInteractionEnabled = true
            datePicker.isUserInteractionEnabled = true
            registerDescription.isUserInteractionEnabled = true
        }
    }

    func receiveTaskInformation() {
        registerTitle.text = task.title
        datePicker.date = Date(timeIntervalSince1970: task.date)
        registerDescription.text = task.myDescription
    }

    @objc func didHitEditbutton() {
        mode = .edit
        setMode()
    }

    @objc func didHitdoneButton() {
        switch mode {
        case .select:
            self.dismiss(animated: true, completion: nil)
        case .edit:
            task = convertToModel(title: registerTitle.text,
                                  date: convertDateToDouble(datePicker.date),
                                  myDescription: registerDescription.text,
                                  status: task.status,
                                  identifier: task.identifier)

            switch task.status {
            case "TODO":
                Task.todoList.remove(at: indexPath.row)
                Task.todoList.insert(task, at: indexPath.row)
            case "DOING":
                Task.doingList.remove(at: indexPath.row)
                Task.doingList.insert(task, at: indexPath.row)
            case "DONE":
                Task.doneList.remove(at: indexPath.row)
                Task.doneList.insert(task, at: indexPath.row)
            default: return
            }

            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func didHitCancelButton() {
        mode = .select
        setMode()
        receiveTaskInformation()
        checkDefaultDescription()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDescription.delegate = self

        setMode()
        navigationItem.title = task.status
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        checkDefaultDescription()
        configureView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: didDismissNotificationCenter, object: nil, userInfo: nil)
    }
}

extension EditViewController {

    func configureView() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        stackView.addArrangedSubview(registerTitle)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(registerDescription)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),

            registerTitle.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
    }
}

extension EditViewController: UITextViewDelegate {

    private func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit

        return isAtLimit
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "설명을 입력해주세요"
            textView.textColor = UIColor.lightGray
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return self.textLimit(existingText: textView.text, newText: text, limit: 1000)
    }

    func checkDefaultDescription() {
        if registerDescription.text == "설명을 입력해주세요" {
            registerDescription.textColor = UIColor.lightGray
        } else {
            registerDescription.textColor = UIColor.black
        }
    }
}
