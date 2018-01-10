//
//  MapViewController.swift
//  map
//
//  Created by   chironyf on 2017/8/6.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MAMapViewDelegate {

    var mapView: MAMapView?
    var groundOverlay: MAGroundOverlay!
    var tileOverlay: MATileOverlay!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "导航"
//        self.tabBarItem.image = UIImage(named: "icon_compus_pre(2)")
        initMapView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initMapView() {
        
        //AMapServices.shared().enableHTTPS = true
        
        mapView = MAMapView(frame: self.view.bounds)
        mapView!.delegate = self
        mapView!.showsUserLocation = true
        mapView!.userTrackingMode = MAUserTrackingMode.follow
        
        //自定义蓝点
//        let r = MAUserLocationRepresentation()
//        r.showsAccuracyRing = true
//        r.showsHeadingIndicator = true
//        r.fillColor = UIColor.red
//        r.strokeColor = UIColor.blue
//        r.lineWidth = 2
//        r.enablePulseAnnimation = false
//        r.locationDotBgColor = UIColor.green
//        r.locationDotFillColor = UIColor.gray
//        r.image = UIImage(named: "userPosition")
//        mapView!.update(r)
        //设置自定义样式
//        var path = Bundle.main.bundlePath
//        path.append("/mystyle_sdk_1502193873_0100.data")
//        print(path)
//        let jsonData = NSData.init(contentsOfFile: path)
////        print(jsonData)
//        self.mapView!.setCustomMapStyleWithWebData(jsonData as Data!)
//        self.mapView!.customMapStyleEnabled = true;
        
        //添加标注
        let pointAnnotation1 = MAPointAnnotation()
        pointAnnotation1.coordinate = CLLocationCoordinate2D(latitude: 30.90569524, longitude: 118.71260762)
        pointAnnotation1.title = "新安学堂"
        pointAnnotation1.subtitle = "（二号教学楼）"
        mapView!.addAnnotation(pointAnnotation1)
        
        let pointAnnotation2 = MAPointAnnotation()
        pointAnnotation2.coordinate = CLLocationCoordinate2D(latitude: 30.9036516, longitude: 118.71089101)
        pointAnnotation2.title = "图书馆"
//        pointAnnotation2.portraitImageView.image = UIImage(named: "userPosition")
        mapView!.addAnnotation(pointAnnotation2)
        
        let pointAnnotation3 = MAPointAnnotation()
        pointAnnotation3.coordinate = CLLocationCoordinate2D(latitude: 30.90865015, longitude: 118.71254325)
        pointAnnotation3.title = "校医院"
        mapView!.addAnnotation(pointAnnotation3)
        
        let pointAnnotation4 = MAPointAnnotation()
        pointAnnotation4.coordinate = CLLocationCoordinate2D(latitude: 30.90753632, longitude: 118.71272564)
        pointAnnotation4.title = "北区停车棚"
        mapView!.addAnnotation(pointAnnotation4)
        
        let pointAnnotation5 = MAPointAnnotation()
        pointAnnotation5.coordinate = CLLocationCoordinate2D(latitude: 30.90671704, longitude: 118.70883107)
        pointAnnotation5.title = "工程训练中心"
        mapView!.addAnnotation(pointAnnotation5)
        
        
        let pointAnnotation6 = MAPointAnnotation()
        pointAnnotation6.coordinate = CLLocationCoordinate2D(latitude: 30.90583332, longitude: 118.70844483)
        pointAnnotation6.title = "化工楼"
        mapView!.addAnnotation(pointAnnotation6)
        
        let pointAnnotation7 = MAPointAnnotation()
        pointAnnotation7.coordinate = CLLocationCoordinate2D(latitude: 30.9049588, longitude: 118.70846629)
        pointAnnotation7.title = "综合实验楼1"
        mapView!.addAnnotation(pointAnnotation7)
        
        let pointAnnotation8 = MAPointAnnotation()
        pointAnnotation8.coordinate = CLLocationCoordinate2D(latitude: 30.90475627, longitude: 118.707726)
        pointAnnotation8.title = "综合实验楼2"
        mapView!.addAnnotation(pointAnnotation8)
        
        let pointAnnotation9 = MAPointAnnotation()
        pointAnnotation9.coordinate = CLLocationCoordinate2D(latitude: 30.90411188, longitude: 118.70844483)
        pointAnnotation9.title = "计算中心楼"
        mapView!.addAnnotation(pointAnnotation9)
        
        let pointAnnotation10 = MAPointAnnotation()
        pointAnnotation10.coordinate = CLLocationCoordinate2D(latitude: 30.90167235, longitude: 118.71033311)
        pointAnnotation10.title = "大学生活动中心"
        mapView!.addAnnotation(pointAnnotation10)
        
        let pointAnnotation11 = MAPointAnnotation()
        pointAnnotation11.coordinate = CLLocationCoordinate2D(latitude: 30.89920515, longitude: 118.70796204)
        pointAnnotation11.title = "青弋江餐厅"
        mapView!.addAnnotation(pointAnnotation11)
        
        let pointAnnotation12 = MAPointAnnotation()
        pointAnnotation12.coordinate = CLLocationCoordinate2D(latitude: 30.90011655, longitude: 118.7047863)
        pointAnnotation12.title = "学生公寓6号楼"
        mapView!.addAnnotation(pointAnnotation12)
        
        let pointAnnotation13 = MAPointAnnotation()
        pointAnnotation13.coordinate = CLLocationCoordinate2D(latitude: 30.90002449, longitude: 118.70589137)
        pointAnnotation13.title = "学生公寓7号楼"
        mapView!.addAnnotation(pointAnnotation13)
        
        let pointAnnotation14 = MAPointAnnotation()
        pointAnnotation14.coordinate = CLLocationCoordinate2D(latitude: 30.89934324, longitude: 118.70574117)
        pointAnnotation14.title = "学生公寓8号楼"
        mapView!.addAnnotation(pointAnnotation14)
        
        let pointAnnotation15 = MAPointAnnotation()
        pointAnnotation15.coordinate = CLLocationCoordinate2D(latitude: 30.89965625, longitude: 118.70698571)
        pointAnnotation15.title = "学生公寓9号楼"
        mapView!.addAnnotation(pointAnnotation15)
        
        let pointAnnotation16 = MAPointAnnotation()
        pointAnnotation16.coordinate = CLLocationCoordinate2D(latitude: 30.89889214, longitude: 118.70687842)
        pointAnnotation16.title = "学生公寓10号楼"
        mapView!.addAnnotation(pointAnnotation16)
        
        let pointAnnotation17 = MAPointAnnotation()
        pointAnnotation17.coordinate = CLLocationCoordinate2D(latitude: 30.9006597, longitude: 118.70371342)
        pointAnnotation17.title = "南区教师公寓"
        mapView!.addAnnotation(pointAnnotation17)
        
        let pointAnnotation18 = MAPointAnnotation()
        pointAnnotation18.coordinate = CLLocationCoordinate2D(latitude: 30.902492, longitude: 118.712067)
        pointAnnotation18.title = "东门广场"
        mapView!.addAnnotation(pointAnnotation18)
        
        let pointAnnotation19 = MAPointAnnotation()
        pointAnnotation19.coordinate = CLLocationCoordinate2D(latitude: 30.904886, longitude: 118.714921)
        pointAnnotation19.title = "体育馆"
        mapView!.addAnnotation(pointAnnotation19)
        
        let pointAnnotation20 = MAPointAnnotation()
        pointAnnotation20.coordinate = CLLocationCoordinate2D(latitude: 30.904269, longitude: 118.715618)
        pointAnnotation20.title = "篮球场"
        mapView!.addAnnotation(pointAnnotation20)
        
        let pointAnnotation21 = MAPointAnnotation()
        pointAnnotation21.coordinate = CLLocationCoordinate2D(latitude: 30.905051, longitude: 118.716949)
        pointAnnotation21.title = "排球场"
        mapView!.addAnnotation(pointAnnotation21)
        
        let pointAnnotation22 = MAPointAnnotation()
        pointAnnotation22.coordinate = CLLocationCoordinate2D(latitude: 30.906248, longitude: 118.716723)
        pointAnnotation22.title = "风雨操场"
        mapView!.addAnnotation(pointAnnotation22)
        
        let pointAnnotation23 = MAPointAnnotation()
        pointAnnotation23.coordinate = CLLocationCoordinate2D(latitude: 30.908034, longitude: 118.714996)
        pointAnnotation23.title = "学生公寓1号楼"
        mapView!.addAnnotation(pointAnnotation23)
        
        let pointAnnotation24 = MAPointAnnotation()
        pointAnnotation24.coordinate = CLLocationCoordinate2D(latitude: 30.907159, longitude: 118.71461)
        pointAnnotation24.title = "学生公寓2号楼"
        mapView!.addAnnotation(pointAnnotation24)
        
        let pointAnnotation25 = MAPointAnnotation()
        pointAnnotation25.coordinate = CLLocationCoordinate2D(latitude: 30.908098, longitude: 118.71403)
        pointAnnotation25.title = "学生公寓3号楼"
        mapView!.addAnnotation(pointAnnotation25)
        
        let pointAnnotation26 = MAPointAnnotation()
        pointAnnotation26.coordinate = CLLocationCoordinate2D(latitude: 30.907389, longitude: 118.713869)
        pointAnnotation26.title = "学生公寓4号楼"
        mapView!.addAnnotation(pointAnnotation26)
        
        let pointAnnotation27 = MAPointAnnotation()
        pointAnnotation27.coordinate = CLLocationCoordinate2D(latitude: 30.908466, longitude: 118.713204)
        pointAnnotation27.title = "学生公寓5号楼"
        mapView!.addAnnotation(pointAnnotation27)
        
        let pointAnnotation28 = MAPointAnnotation()
        pointAnnotation28.coordinate = CLLocationCoordinate2D(latitude: 30.907399, longitude: 118.716734)
        pointAnnotation28.title = "北区教师公寓"
        mapView!.addAnnotation(pointAnnotation28)
        
        let pointAnnotation29 = MAPointAnnotation()
        pointAnnotation29.coordinate = CLLocationCoordinate2D(latitude: 30.90634883, longitude: 118.71428132)
        pointAnnotation29.title = "南漪湖餐厅"
        mapView!.addAnnotation(pointAnnotation29)
        
        let pointAnnotation30 = MAPointAnnotation()
        pointAnnotation30.coordinate = CLLocationCoordinate2D(latitude: 30.90627518, longitude: 118.71738195)
        pointAnnotation30.title = "网球场"
        mapView!.addAnnotation(pointAnnotation30)
        
        let pointAnnotation31 = MAPointAnnotation()
        pointAnnotation31.coordinate = CLLocationCoordinate2D(latitude: 30.90323734, longitude: 118.71298313)
        pointAnnotation31.title = "行政楼"
        mapView!.addAnnotation(pointAnnotation31)
        
        let pointAnnotation32 = MAPointAnnotation()
        pointAnnotation32.coordinate = CLLocationCoordinate2D(latitude: 30.90575968, longitude: 118.71083736)
        pointAnnotation32.title = "敬亭学堂"
        mapView!.addAnnotation(pointAnnotation32)
        
        initGroundOverlay()
        mapView!.add(groundOverlay)
        
        
        
        //设置指南针
        mapView!.compassOrigin = CGPoint(x: 20, y: 40)
        
        //设置比例尺
        mapView!.showsScale = true
        mapView!.scaleOrigin = CGPoint(x: SCREEN_RECT.width - 100, y: 20)
        
        //设置地图的显示范围
        self.mapView!.limitRegion = MACoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: 30.9036516, longitude: 118.71089101), span: MACoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView!.limitRegion = self.mapView!.limitRegion
        
        //设置地图的中心点 ,图书馆的位置 30.9036516, longitude: 118.71089101
        self.mapView!.setCenter(CLLocationCoordinate2D(latitude: 30.9036516, longitude: 118.71089101), animated: true)
        self.mapView!.zoomLevel = 15
        
        
        self.view.addSubview(mapView!)

    }
    
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        
        if (overlay.isKind(of: MAGroundOverlay.self))
        {
            let renderer = MAGroundOverlayRenderer.init(groundOverlay: overlay as! MAGroundOverlay)
            print("renderer")
            return renderer;
        } else if (overlay.isKind(of: MATileOverlay.self)) {
            let renderer = MATileOverlayRenderer.init(tileOverlay: overlay as! MATileOverlay!)
            return renderer;
        }
        return nil;
    }
    
    //初始化图片覆盖物
    func initGroundOverlay() {
        let coordBounds = MACoordinateBounds.init(northEast: CLLocationCoordinate2DMake(30.897535, 118.698897), southWest: CLLocationCoordinate2DMake(30.912596, 118.721298));
        groundOverlay = MAGroundOverlay.init(bounds: coordBounds, icon: UIImage.init(named: "mapNew"))
    }
    
    //初始化瓦片图层
//    func buildOverlay(type:UInt) -> MATileOverlay! {
//        if (type == 0)
//        {
//            tileOverlay = LocalTileOverlay.init()
//            tileOverlay.minimumZ = 4;
//            tileOverlay.maximumZ = 17;
//        }
//        else // type == 1
//        {
//            tileOverlay = MATileOverlay.init(urlTemplate: "http://cache1.arcgisonline.cn/arcgis/rest/services/ChinaCities_Community_BaseMap_ENG/BeiJing_Community_BaseMap_ENG/MapServer/tile/{z}/{y}/{x}")
//            
//            /* minimumZ 是tileOverlay的可见最小Zoom值. */
//            tileOverlay.minimumZ = 11;
//            /* minimumZ 是tileOverlay的可见最大Zoom值. */
//            tileOverlay.maximumZ = 13;
//            
//            /* boundingMapRect 是用来 设定tileOverlay的可渲染区域. */
//            tileOverlay.boundingMapRect = MAMapRectWorld;
//        }
//        return tileOverlay;
//    }
    
    
    //标记回调
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            
            
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            

            annotationView!.canShowCallout = true
            annotationView!.animatesDrop = true
            annotationView!.isDraggable = true
            
//            annotationView!.image = UIImage(frame: CGRect(x: 20, y: 30, width: 200, height: 100))
//            print(annotationView!.annotation.title?.description ?? <#default value#>)
//            if (annotationView!.annotation.title == "图书馆") {
//                annotationView!.image = UIImage(named: "library-new")
////                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
//            }
            print(annotationView!.annotation)
//
            
//            annotationView!.image = UIImage(named: "mark")
            
            annotationView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)

            
//            let idx = annotationView!.index(ofAccessibilityElement: annotation as! MAPointAnnotation)
//            annotationView!.pinColor = MAPinAnnotationColor(rawValue: idx?)!
            
            return annotationView!
        }
        
        return nil
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

