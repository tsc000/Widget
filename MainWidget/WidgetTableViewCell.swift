// Copyright © 2019年 Zilly, Inc. All rights reserved.

import UIKit

class WidgetTableViewCell: UITableViewCell {

    private var contentHeightAnchor: NSLayoutConstraint?
    private var dateTopAnchor: NSLayoutConstraint?

    private var iconImageView: UIImageView = {
        let iconImageView = UIImageView(image: UIImage(named: "row-unit"))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()

    private var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0x5a/0xff, green: 0x5a/0xff, blue: 0x5a/0xff, alpha: 1.0)
        return label
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0x1e/0xff, green: 0x1e/0xff, blue: 0x1e/0xff, alpha: 1.0)
        return label
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5:30 pm"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0x5a/0xff, green: 0x5a/0xff, blue: 0x5a/0xff, alpha: 1.0)
        return label
    }()

    private var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0x1e/0xff, green: 0x1e/0xff, blue: 0x1e/0xff, alpha: 1.0)
        label.text = "No Recent Messages"
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = UIColor.clear
        setUpUI()
    }

    private func setUpUI() {
        [ iconImageView, nameLabel, contentLabel, dateLabel, emptyLabel ].forEach(contentView.addSubview)
        //iconImageView
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
            ])
        dateTopAnchor = dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35)
        //dateLabel
        NSLayoutConstraint.activate([
            dateTopAnchor!,
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            dateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0)
            ])
        //nameLabel
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            nameLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 0),
            ])
        contentHeightAnchor = contentLabel.heightAnchor.constraint(equalToConstant: 36)
        //contentLabel
        NSLayoutConstraint.activate([
            contentLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            contentLabel.rightAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 0),
            contentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            contentHeightAnchor!,
            ])
        //contentLabel
        NSLayoutConstraint.activate([
            emptyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            emptyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            emptyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            emptyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            ])

    }

    func setName(_ name: String?) {
        nameLabel.text = name
    }

    func setDate(_ date: String?) {
        dateLabel.text = date
    }

    func setImage(_ imageName: String?) {
        iconImageView.image = UIImage(named: imageName ?? "")
    }

    func displayEmptyMessage(_ display: Bool) {
        iconImageView.isHidden = display
        nameLabel.isHidden = display
        dateLabel.isHidden = display
        contentLabel.isHidden = display
        emptyLabel.isHidden = !display
    }

    func setContent(_ content: String?) {
        contentLabel.text = content
        let attributes = [NSAttributedString.Key.font:contentLabel.font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = (contentLabel.text ?? "").boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 8 - 88, height: 1000), options: option, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        if rect.size.height > 17 {
            contentHeightAnchor?.constant = 36
            dateTopAnchor?.constant = 26
        } else {
            contentHeightAnchor?.constant = 18
            dateTopAnchor?.constant = 35
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
