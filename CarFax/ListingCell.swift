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

    public var listing: Listing? {
        didSet {

        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }

        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFit
        photo.snp.makeConstraints { make in
            make.height.equalTo(200).priority(999)
        }

        title.font = .boldSystemFont(ofSize: 20)
        stackView.addArrangedSubview(photo)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        subtitle.text = nil
        photo.image = nil
    }
}
