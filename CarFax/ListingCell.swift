//
//  ListingCell.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation
import SnapKit

class ListingCell: UITableViewCell {
    private let photo = UIImageView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let phoneButton = UIButton(type: .system)

    public var onTapPhoneButton: ((String) -> Void)?

    public var listing: Listing? {
        didSet {
            guard let listing = listing else {
                return
            }
            if let imageLink = listing.images?.firstPhoto?.medium, let url = URL(string: imageLink) {
                photo.loadURL(url: url)
            }

            if let year = listing.year, let make = listing.make, let model = listing.model, let trim = listing.trim {
                title.text = String(format: "%d %@ %@ %@", year, make, model, trim)
            }

            if let price = listing.listPrice, let mileage = listing.mileage, let city = listing.dealer?.city, let state = listing.dealer?.state {
                subtitle.text = String(format: "$%d | %dk Mi | %@ %@", price, mileage / 1000, city, state)
            }
            if let phone = listing.dealer?.phone {
                phoneButton.setTitle(String(format: "Call: %@", phone), for: .normal)
                phoneButton.isHidden = false
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        photo.snp.makeConstraints { make in
            make.height.equalTo(200).priority(999)
        }

        title.font = .boldSystemFont(ofSize: 20)

        phoneButton.backgroundColor = .black
        phoneButton.setTitleColor(.white, for: .normal)
        phoneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)

        stackView.addArrangedSubview(photo)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(phoneButton)

        phoneButton.addTarget(self, action: #selector(tapPhone), for: .touchDown)
    }

    @objc func tapPhone() {
        guard let phone = listing?.dealer?.phone else {
            return
        }
        onTapPhoneButton?(phone)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = "-"
        subtitle.text = "-"
        photo.image = #imageLiteral(resourceName: "carPlaceholder")
        phoneButton.isHidden = true
    }
}
