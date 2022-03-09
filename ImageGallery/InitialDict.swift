//
//  InitialDict.swift
//  ImageGallery
//
//  Created by Vasile Sebastian Catur on 09.03.2022.
//

import Foundation

class InitialDict {
    var themesArrayOfDict = [
        ["Cars": ["https://cdn.motor1.com/images/mgl/mrz1e/s1/coolest-cars-feature.webp", "https://i.insider.com/592f4169b74af41b008b5977?width=700", "https://cdn.motor1.com/images/mgl/8e8Mo/s1/most-expensive-new-cars-ever.webp", "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/gallery_slide/public/images/car-reviews/first-drives/legacy/98_-_fastest_accelerating_road_cars_-_ferrari_f8_tributo.jpg?itok=K_MW2s7l", "https://elitetraveler.com/wp-content/uploads/2019/07/Screenshot-2020-05-12-at-15.10.34.png", "https://s7g10.scene7.com/is/image/maserati/maserati/regional/us/models/my22/levante/22_LV_Trofeo_PS_T1_HomePage_1920x1080.jpg?$1920x2000$&fit=constrain"]],

        ["Buildings": ["https://i.insider.com/5cbf3c8fb14bf426443fd865?width=700", "https://www.jll.ro/images/global/treant-and-insights/global-cities-why-timber-buildings.jpg.rendition/cq5dam.web.1280.1280.jpeg", "https://cdn.britannica.com/08/187508-050-D6FB5173/Shanghai-Tower-Gensler-San-Francisco-world-Oriental-2015.jpg", "https://media.architecturaldigest.com/photos/585811cfdcb583e908275f46/16:9/w_2560%2Cc_limit/buildings-with-trees-001.jpg", "http://prod-upp-image-read.ft.com/cdf77c06-0a90-11e9-a242-6043097d0789", "https://assets.weforum.org/article/image/v2gQQH6Qq5EAJSemo1Yqie27aYBOHE4pSwA6jSkFHKg.jpg", "https://media.istockphoto.com/photos/low-angle-of-tall-building-in-manhattan-picture-id1291177121?b=1&k=20&m=1291177121&s=170667a&w=0&h=aI1PkWS_GkXJ4Qz0gz2cTOud95SS4hUa4iZc1kqWYL4="]],

        ["Nature": ["https://natureconservancy-h.assetsadobe.com/is/image/content/dam/tnc/nature/en/photos/tnc_17360603.jpg?crop=328,0,983,1230&wid=480&hei=600&scl=2.05", "https://natureconservancy-h.assetsadobe.com/is/image/content/dam/tnc/nature/en/photos/joe-ciciarelli-qWVL0Io50PQ-unsplash.jpg?crop=0,392,6720,3696&wid=4000&hei=2200&scl=1.68", "https://www.iucn.org/sites/dev/files/content/images/2020/shutterstock_1458128810.jpg", "https://media.cntraveler.com/photos/60596b398f4452dac88c59f8/16:9/w_3999,h_2249,c_limit/MtFuji-GettyImages-959111140.jpg", "https://static.educalingo.com/img/en/800/nature.jpg", "https://th-thumbnailer.cdn-si-edu.com/vSnitgUqCQCRSx7mkHZtHZHry4U=/1072x720/filters:no_upscale()/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/04/8e/048ed839-a581-48af-a0ae-fac6fec00948/gettyimages-168346757_web.jpg"]]
    ]

    init() {
        UserDefaults.standard.set(themesArrayOfDict, forKey: "themesArrayOfDict")
    }
}
