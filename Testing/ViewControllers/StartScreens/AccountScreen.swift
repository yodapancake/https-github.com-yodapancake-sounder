//
//  AccountScreen.swift
//  Testing
//
//  Created by user187615 on 12/7/20.
//

import Firebase
import UIKit

class AccountScreen: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    let profileImageViewWidth: CGFloat = 100
    let editProfileImageViewButton: UIButton = UIButton()
    let profileImageView: UIImageView = UIImageView()
    var profileImage: UIImage? = nil
    let listingsTableView: UITableView = {
        let tv = UITableView.init(frame: CGRect.zero, style: .grouped)
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    var headerStackView: HeaderStackView? = nil
    
    override func viewDidLoad() {
        if profileImage == nil {
            profileImage = UIImage(named: "default_profile_image")
        }
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Settings"), style: .plain, target: self, action: #selector(settingsButtonPressed))
        listingsTableView.dataSource = self
        listingsTableView.delegate = self
        prepareListingsTableView()

    }
    func prepareListingsTableView() {
        listingsTableView.register(listingCell.self, forCellReuseIdentifier: "cellId")
        listingsTableView.separatorStyle = .none
        listingsTableView.backgroundColor = .systemIndigo
        view.addSubview(listingsTableView)
        NSLayoutConstraint.activate([
            listingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            listingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            listingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
        ])

    }
    @objc func settingsButtonPressed() {
        self.navigationController?.pushViewController(SettingsScreen(), animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! listingCell
        cell.selectionStyle = .none
        cell.backgroundColor = .systemIndigo
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerStackView = HeaderStackView(image: profileImage!, rating: 5, firstName: "Maximus", lastName: "Hirsch", role: "Coder", bio:  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", accountScreen: self)
        return headerStackView
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        headerStackView?.profileImageView.image = newImage
        profileImage = newImage
        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

class listingCell: UITableViewCell {
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }

}

class HeaderStackView: UIStackView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let profileImageViewWidth: CGFloat = 100
    let listingsLabel: UILabel = UILabel()
    let addListingButton: UIButton = UIButton()
    let editProfImgView: UIButton = UIButton()
    
    var profileImageView: UIImageView = UIImageView()
    var ratingLabel: UILabel = UILabel()
    var reviewsButton: UIButton = UIButton()
    var firstNameLabel: UILabel = UILabel()
    var lastNameLabel: UILabel = UILabel()
    var roleLabel: UILabel = UILabel()
    var bioLabel: UILabel = UILabel()
    var accountScreen: AccountScreen? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(image: UIImage, rating: CGFloat, firstName: String, lastName: String, role: String, bio:  String, accountScreen: AccountScreen) {
        self.init(frame: .zero)
        self.profileImageView = createCircularProfileImageView(image: image)
        self.ratingLabel.text = rating.description
        self.roleLabel.text = String("Role: " + role)
        self.bioLabel.text = String("Bio: " + bio)
        self.firstNameLabel.text = String("First name: " + firstName)
        self.lastNameLabel.text = String("Last name:" + lastName)
        self.accountScreen = accountScreen
        setup()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .systemGray
        self.layer.cornerRadius = 20
        self.distribution = .fillProportionally
        self.spacing = 10
        self.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        self.isLayoutMarginsRelativeArrangement = true
        self.axis = .vertical
        self.addArrangedSubview(getTopRowView())
        self.addArrangedSubview(firstNameLabel)
        self.addArrangedSubview(lastNameLabel)
        self.addArrangedSubview(roleLabel)
        self.addArrangedSubview(bioLabel)
        
        styleObjects()
    }
    func styleObjects() {
        //bioLabel
        bioLabel.numberOfLines = 0
        bioLabel.lineBreakMode = .byWordWrapping
        
        //editProfImgView
        editProfImgView.setTitle("Edit", for: .normal)
        editProfImgView.addTarget(self, action: #selector(editProfileImageViewButtonPressed), for: .touchUpInside)
    }

    func getTopRowView() -> UIView {
        let view = UIView()
        view.addSubview(profileImageView)
        view.addSubview(ratingLabel)
        view.addSubview(reviewsButton)
        view.addSubview(editProfImgView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewsButton.translatesAutoresizingMaskIntoConstraints = false
        editProfImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 170),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewWidth),
            ratingLabel.leftAnchor.constraint(greaterThanOrEqualTo: profileImageView.rightAnchor, constant: 10),
            ratingLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 25),
            editProfImgView.topAnchor.constraint(greaterThanOrEqualTo: profileImageView.bottomAnchor, constant: 5),
            editProfImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return view
    }

    func createCircularProfileImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image.withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = profileImageViewWidth / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    @objc func editProfileImageViewButtonPressed(sender: UIButton!) {
        let picker = UIImagePickerController()
        picker.delegate = accountScreen
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        accountScreen!.present(picker, animated: true)
    }
}
