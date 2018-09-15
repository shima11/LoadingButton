//
//  ViewController.swift
//  LoadingButton
//
//  Created by Jinsei Shima on 2018/09/14.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit
import EasyPeasy

fileprivate final class LoadingButton: UIControl {

  enum State {
    case loading
    case completed
  }

  // TODO: 実装メモ

  enum Style {
    case title(title: String?)
    case icon(image: UIImage?)
    case titleIcon(title: String?, image: UIImage?)
  }



  fileprivate var loadingState: LoadingButton.State = .completed {
    didSet {
      switch loadingState {
      case .completed:
        indicatorView.stopAnimating()
        titleLabel.isHidden = false
      case .loading:
        indicatorView.startAnimating()
        titleLabel.isHidden = true
      }
    }
  }

  let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  let titleLabel = UILabel()
  let imageView = UIImageView()

  init(title: String?, image: UIImage?) {
    super.init(frame: .zero)

    // TODO: このままだと文字か画像のどっちかをCenterに表示する想定になってしまう

    addSubview(titleLabel)
    addSubview(indicatorView)
    addSubview(imageView)

    titleLabel.text = title
    imageView.image = image
    imageView.contentMode = .center

    titleLabel.easy.layout(Center())
    indicatorView.easy.layout(Center())
    imageView.easy.layout(Center())

    addTarget(self, action: #selector(didTap), for: .touchUpInside)

  }

  func forceTap() {
    sendAction(#selector(didTap), to: self, for: nil)
  }

  func completed() {
    loadingState = .completed
  }

  @objc func didTap() {
    print("did tap")
    loadingState = .loading

    #if DEBUG
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      print("execute")
      self.completed()
    }
    #endif
  }

  override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
    print("event:", event ?? "nil")
    super.sendAction(action, to: target, for: event)
  }

  override func layoutIfNeeded() {
    super.layoutIfNeeded()
    print("layout if needed")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    print("layout subviews")
  }

  override func layoutMarginsDidChange() {
    super.layoutMarginsDidChange()
    print("layout margins did change")
  }

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    print("layout sublayouers:", layer)
  }

  override func setNeedsLayout() {
    super.setNeedsLayout()
    print("set needs layout")
  }

  override func display(_ layer: CALayer) {
    super.display(layer)
    print("display:", layer)
  }

  override func willMove(toSuperview newSuperview: UIView?) {
    super.willMove(toSuperview: newSuperview)
    print("will move to super view:")
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    print("did move to super view")
  }

  override func willMove(toWindow newWindow: UIWindow?) {
    super.willMove(toWindow: newWindow)
    print("will move to window:")
  }

  override func didMoveToWindow() {
    super.didMoveToWindow()
    print("did move to window")
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let loadingButton = LoadingButton(title: "Send", image: nil)
    loadingButton.backgroundColor = .lightGray
    view.addSubview(loadingButton)

    loadingButton.layer.cornerRadius = 30
    loadingButton.clipsToBounds = true

    loadingButton.easy.layout(
      Width(120),
      Height(60),
      Center()
    )

  }

}

