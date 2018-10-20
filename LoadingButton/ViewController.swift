//
//  ViewController.swift
//  LoadingButton
//
//  Created by Jinsei Shima on 2018/09/14.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit
import EasyPeasy

fileprivate final class LoadingButton1: UIControl {

  enum LoadingState {
    case loading
    case completed
  }

  // TODO: 実装メモ

  enum Style {
    case title(title: NSAttributedString?)
    case icon(image: UIImage?)
    case titleIcon(title: NSAttributedString?, image: UIImage?)
  }


  fileprivate var loadingState: LoadingButton1.LoadingState = .completed {
    didSet {
      switch loadingState {
      case .completed:
        isEnabled = true
        indicatorView.stopAnimating()
        titleLabel.isHidden = false
      case .loading:
        isEnabled = false
        indicatorView.startAnimating()
        titleLabel.isHidden = true
      }
    }
  }

  override var backgroundColor: UIColor? {
    didSet {
      var grayScale: CGFloat = 0
      var alpha: CGFloat = 0
      guard let isWhite = backgroundColor?.getWhite(&grayScale, alpha: &alpha) else { return }
      print("gray scale:", grayScale)
      print("alpha:", alpha)
      print("is white:", isWhite)
      indicatorView.style = isWhite ? .gray : .white
    }
  }

  let indicatorView = UIActivityIndicatorView()
  let titleLabel = UILabel()
  let imageView = UIImageView()

  init(title: NSAttributedString?, image: UIImage?) {
    super.init(frame: .zero)

    // TODO: このままだと文字か画像のどっちかをCenterに表示する想定になってしまう

    addSubview(titleLabel)
    addSubview(indicatorView)
    addSubview(imageView)

    titleLabel.attributedText = title
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

    action?()

    #if DEBUG
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      print("execute")
      self.completed()
    }
    #endif
  }

  private var action: (() -> Void)?

  func touchUpInside(action: (() -> Void)? = nil) {
    self.action = action
  }

  override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
    print("send action:")//, event ?? "nil")
    super.sendAction(action, to: target, for: event)
  }

  override func layoutIfNeeded() {
    print("layout if needed")
    super.layoutIfNeeded()
  }

  override func layoutSubviews() {
    print("layout subviews")
    super.layoutSubviews()
  }

  override func layoutMarginsDidChange() {
    print("layout margins did change")
    super.layoutMarginsDidChange()
  }

  override func layoutSublayers(of layer: CALayer) {
    print("layout sublayouers:", layer)
    super.layoutSublayers(of: layer)
  }

  override func setNeedsLayout() {
    print("set needs layout")
    super.setNeedsLayout()
  }

  override func display(_ layer: CALayer) {
    print("display:", layer)
    super.display(layer)
  }

  override func willMove(toSuperview newSuperview: UIView?) {
    print("will move to super view:")
    super.willMove(toSuperview: newSuperview)
  }

  override func didMoveToSuperview() {
    print("did move to super view")
    super.didMoveToSuperview()
  }

  override func willMove(toWindow newWindow: UIWindow?) {
    print("will move to window:")
    super.willMove(toWindow: newWindow)
  }

  override func didMoveToWindow() {
    print("did move to window")
    super.didMoveToWindow()
  }

  override func layerWillDraw(_ layer: CALayer) {
    print("layer will draw")
    super.layerWillDraw(layer)
  }

  override func updateConstraints() {
    print("update constraints")
    super.updateConstraints()
  }

  override func setNeedsUpdateConstraints() {
    print("set needs updaet constraints")
    super.setNeedsUpdateConstraints()
  }

  override func setNeedsDisplay() {
    print("set needs display")
    super.setNeedsDisplay()
  }

  override var isTracking: Bool {
    return true
  }

  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    print("begin tracking:======")//, touch, event ?? "nil")
    return super.beginTracking(touch, with: event)
  }

  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    print("continue tracking:")//, touch, event ?? "nil")
    return super.continueTracking(touch, with: event)
  }

  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    print("end tracking:======")//, touch ?? "nil", event ?? "nil")
    super.endTracking(touch, with: event)
  }

  override func cancelTracking(with event: UIEvent?) {
    print("cancel tracking:")//, event ?? "nil")
    super.cancelTracking(with: event)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


private final class LoadingButton2: UIView {

  enum State {
    case loading
    case completed
  }

  private var loadingState: LoadingButton2.State = .completed {
    didSet {
      switch loadingState {
      case .loading:
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        button.isHidden = true
      case .completed:
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        button.isHidden = false
      }
    }
  }

  private let button = UIButton(type: .system)
  private let indicatorView = UIActivityIndicatorView(style: .gray)
  private var action: (() -> Void)?

  override init(frame: CGRect) {

    super.init(frame: frame)

    addSubview(button)
    addSubview(indicatorView)

    indicatorView.easy.layout(
      Center()
    )

    button.easy.layout(
      Edges(),
      Center()
    )

    button.addTarget(self, action: #selector(didTap), for: .touchUpInside)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setTitle(title: NSAttributedString) {
    button.setAttributedTitle(title, for: .normal)
  }

  func loading() {
    loadingState = .loading
  }

  func completed() {
    loadingState = .completed
  }

  func touchUpInside(action: (() -> Void)? = nil) {
    self.action = action
  }

  @objc
  private func didTap() {

    print("did tap")

    loadingState = .loading

    action?()

    #if DEBUG
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      print("execute")
      self.completed()
    }
    #endif
  }
}



class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let loadingButton1 = LoadingButton1(
      title: NSAttributedString(
        string: "Send1",
        attributes: [
          .font : UIFont.systemFont(ofSize: 18, weight: .bold),
          .foregroundColor : UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
        ]
      ),
      image: nil
    )
    loadingButton1.backgroundColor = UIColor.groupTableViewBackground
    loadingButton1.layer.cornerRadius = 30
    loadingButton1.clipsToBounds = true
    loadingButton1.touchUpInside {
      print("loading button1 touch up inside")
    }

    view.addSubview(loadingButton1)
    
    loadingButton1.easy.layout(
      Width(120),
      Height(60),
      CenterX(),
      CenterY(-60)
    )


    let loadingButton2 = LoadingButton2()
    loadingButton2.setTitle(
      title: NSAttributedString(
        string: "Send2",
        attributes: [
          .font : UIFont.systemFont(ofSize: 18, weight: .bold),
          .foregroundColor : UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
        ]
      )
    )
    loadingButton2.backgroundColor = UIColor.groupTableViewBackground
    loadingButton2.layer.cornerRadius = 30
    loadingButton2.clipsToBounds = true
    loadingButton2.touchUpInside {
      print("loading button2 touch up inside")
    }
    view.addSubview(loadingButton2)

    loadingButton2.easy.layout(
      Width(120),
      Height(60),
      CenterX(),
      CenterY(60)
    )

  }

}

