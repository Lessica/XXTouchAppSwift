//
//  PhotoViewController.swift
//  XXTouchApp
//
//  Created by mcy on 16/7/1.
//  Copyright © 2016年 mcy. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
  //  private let scrollView = UIScrollView()
  //  private let imageView = UIImageView()
  private let image: UIImage
  private let name: String
  //  private var currentScale: CGFloat = 0
  //  private var maxScale: CGFloat = 4.0
  //  private var minScale: CGFloat = 0.15
  //  private let photoEditView = PhotoEditView()
  //  private var isOpen = false
  private var photoView: VIPhotoView!
  private var contextSheet: VLDContextSheet!
  
  init(image: UIImage, name: String) {
    self.image = image
    self.name = name
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  // 隐藏电池栏
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    makeConstriants()
    setupAction()
    bind()
  }
  
  private func setupUI() {
    automaticallyAdjustsScrollViewInsets = false
    view.backgroundColor = UIColor.whiteColor()
    photoView = VIPhotoView(frame: self.view.bounds, andImage: self.image, nav: self.navigationController, showView: self.view)
    photoView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    
    let item1 = VLDContextSheetItem(title: "取色", image: UIImage(named: "add"), highlightedImage: UIImage(named: "add_highlighted"))
    let item2 = VLDContextSheetItem(title: "gift", image: UIImage(named: "gift"), highlightedImage: UIImage(named: "gift_highlighted"))
    let item3 = VLDContextSheetItem(title: "gift", image: UIImage(named: "gift"), highlightedImage: UIImage(named: "gift_highlighted"))
    contextSheet = VLDContextSheet(items: [item1, item2, item3])
    contextSheet.delegate = self
    
    view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(show(_:))))
    
    //    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .Plain, target: self, action: #selector(edit(_:)))
    
    //    imageView.userInteractionEnabled = true
    //    imageView.contentMode = .ScaleAspectFit
    //    
    //    
    //    scrollView.frame = view.bounds
    //    scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    //    scrollView.delegate = self
    //    scrollView.maximumZoomScale = maxScale
    //    
    //    scrollView.showsVerticalScrollIndicator = false
    //    scrollView.showsHorizontalScrollIndicator = false
    //    scrollView.backgroundColor = UIColor.lightGrayColor()
    
    //    photoEditView.hidden = true
    
    //    scrollView.addSubview(imageView)
    //    view.addSubview(scrollView)
    //    view.addSubview(photoEditView)
    view.addSubview(photoView)
  }
  
  private func makeConstriants() {
    //    photoEditView.snp_makeConstraints { (make) in
    //      make.bottom.leading.trailing.equalTo(view)
    //      make.height.equalTo(80)
    //    }
    //    menuButton.snp_makeConstraints { (make) in
    //      make.bottom.trailing.equalTo(view).inset(-60)
    //      make.width.height.equalTo(200)
    //    }
  }
  
  private func setupAction() {
    //    let tap = UITapGestureRecognizer(target: self, action: #selector(doubleSize(_:)))
    //    tap.numberOfTapsRequired = 2
    //    imageView.addGestureRecognizer(tap)
    
    //    let tap = UITapGestureRecognizer(target: self, action: #selector(navHidden(_:)))
    //    tap.requireGestureRecognizerToFail(photoView.tapGestureRecognizer)
    //    photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navHidden(_:))))
  }
  
  private func bind() {
    navigationItem.title = self.name
    //    imageView.image = self.image
    //    imageView.sizeToFit()
    //    scrollView.contentSize = self.image.size
    //    minScale = scrollView.frame.width/self.image.size.width
    //    scrollView.minimumZoomScale = minScale
    //    scrollView.zoomScale = minScale
  }
}

extension PhotoViewController: VLDContextSheetDelegate {
  func contextSheet(contextSheet: VLDContextSheet!, didSelectItem item: VLDContextSheetItem!) {
    print(item.title)
  }
  
  @objc private func show(long: UILongPressGestureRecognizer) {
    if long.state == UIGestureRecognizerState.Began {
      contextSheet.startWithGestureRecognizer(long, inView: self.view)
    }
  }
}

//extension PhotoViewController: UIScrollViewDelegate {
//  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//    return imageView
//  }
//  
//  func scrollViewDidZoom(scrollView: UIScrollView) {
//    centerScrollViewContent()
//  }
//  
//  func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
//    currentScale = scale
//  }
//  
//  /**
//   滚动视图内容居中
//   */
//  private func centerScrollViewContent() {
//    var leftInset: CGFloat = (scrollView.frame.width - scrollView.contentSize.width)/2
//    var topInset: CGFloat = (scrollView.frame.height - scrollView.contentSize.height - Constants.Size.axtNavigationBarHeight)/2
//    topInset = max(topInset, 0)
//    leftInset = max(leftInset, 0)
//    var bottomInset: CGFloat = 0
//    if isOpen {
//      bottomInset = 80
//    }
//    scrollView.contentInset = UIEdgeInsets(top: topInset+Constants.Size.axtNavigationBarHeight,
//                                           left: leftInset,
//                                           bottom: bottomInset,
//                                           right: 0)
//  }
//  
//  @objc private func doubleSize(tap: UITapGestureRecognizer) {
//    //当前倍数等于最大放大倍数
//    //双击默认为缩小到原图
//    if currentScale == maxScale {
//      currentScale = minScale
//      scrollView.setZoomScale(currentScale, animated: true)
//      return
//    }
//    //当前等于最小放大倍数
//    //双击默认为放大到最大倍数
//    if currentScale == minScale {
//      currentScale = maxScale
//      scrollView.setZoomScale(currentScale, animated: true)
//      return
//    }
//    
//    let aveScale = minScale+(maxScale-minScale)/2.0 //中间倍数
//    
//    //当前倍数大于平均倍数
//    //双击默认为放大最大倍数
//    if (currentScale >= aveScale) {
//      currentScale = maxScale
//      scrollView.setZoomScale(currentScale, animated: true)
//      return
//    }
//    
//    //当前倍数小于平均倍数
//    //双击默认为放大到最小倍数
//    if (currentScale < aveScale) {
//      currentScale = minScale
//      scrollView.setZoomScale(currentScale, animated: true)
//      return
//    }
//  }
//}
//
//extension PhotoViewController {
//  @objc private func edit(barButton: UIBarButtonItem) {
//    isOpen = true
//    scrollView.contentInset.bottom = 80
//    photoEditView.transform = CGAffineTransformTranslate(photoEditView.transform, 0, 80)
//    photoEditView.hidden = false
//    UIView.animateWithDuration(0.3, animations: {
//      self.photoEditView.transform = CGAffineTransformIdentity
//    }) { (_) in
//      
//    }
//  }
//}