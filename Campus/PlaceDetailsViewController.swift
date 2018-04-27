//
//  PlaceDetailsViewController.swift
//  Campus
//
//  Created by Matt Hansen on 4/24/18.
//  Copyright © 2018 The Pennsylvania State University. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet var placeDetailTitleLabel: UILabel!
    @IBOutlet var placeDetailImageView: UIImageView!
    @IBOutlet var placeDetailTextView: UITextView!
    
    public var detailTitle: String = ""
    public var detailImage: UIImage? = nil
    public var detailText: String = ""
    
    public let markerImages = [
        1: [#imageLiteral(resourceName: "oldmainclose"), #imageLiteral(resourceName: "oldmain1855"), #imageLiteral(resourceName: "oldmainloc"), #imageLiteral(resourceName: "oldmainrearloc")], 2: [#imageLiteral(resourceName: "univhouseclose"), #imageLiteral(resourceName: "univhouseloc"), #imageLiteral(resourceName: "univhousephoto")], 3: [#imageLiteral(resourceName: "oldbotanyclose"), #imageLiteral(resourceName: "oldbotanybldg")], 4: [#imageLiteral(resourceName: "athertonclose"), #imageLiteral(resourceName: "atherton"), #imageLiteral(resourceName: "athertonloc")], 5: [#imageLiteral(resourceName: "schwabclose"), #imageLiteral(resourceName: "schwabloc")],
        6: [#imageLiteral(resourceName: "carnegieclose"), #imageLiteral(resourceName: "carnegieloc")], 7: [#imageLiteral(resourceName: "aghillclose"), #imageLiteral(resourceName: "aghillloc")], 8: [#imageLiteral(resourceName: "jordansoilplotsclose"), #imageLiteral(resourceName: "jordansoilplotslocation")], 9: [#imageLiteral(resourceName: "atomfirstseen"), #imageLiteral(resourceName: "atomfirstseenloc")], 10: [#imageLiteral(resourceName: "Industryclose"), #imageLiteral(resourceName: "industrialengrloc")],
        11: [#imageLiteral(resourceName: "progesteroneclose"), #imageLiteral(resourceName: "progesteroneloc"), #imageLiteral(resourceName: "Markermarker")], 12: [#imageLiteral(resourceName: "artsemclose"), #imageLiteral(resourceName: "artsemloc")], 13: [#imageLiteral(resourceName: "bernreuterclose"), #imageLiteral(resourceName: "bernreuterloc")], 14: [#imageLiteral(resourceName: "hapclose"), #imageLiteral(resourceName: "haploc")], 15: [#imageLiteral(resourceName: "firstagdegreesclose"), #imageLiteral(resourceName: "firstagdegreesloc")],
        16: [#imageLiteral(resourceName: "atomsforpeaceclose"), #imageLiteral(resourceName: "atomsforpeaceloc")], 17: [#imageLiteral(resourceName: "facultycottagesclose"), #imageLiteral(resourceName: "facultycottagesloc")], 18: [#imageLiteral(resourceName: "driveredclose"), #imageLiteral(resourceName: "driversedloc")], 19: [#imageLiteral(resourceName: "amerlitclose"), #imageLiteral(resourceName: "amerlitloc")], 20: [#imageLiteral(resourceName: "artedclose"), #imageLiteral(resourceName: "artedloc")],
        21: [#imageLiteral(resourceName: "creameryclose"), #imageLiteral(resourceName: "creameryloc")], 22: [#imageLiteral(resourceName: "atmosphereclose"), #imageLiteral(resourceName: "atmosphereloc")], 23: [#imageLiteral(resourceName: "combinatoryclose"), #imageLiteral(resourceName: "combinatoryloc")], 24: [#imageLiteral(resourceName: "willowclose"), #imageLiteral(resourceName: "willowloc")], 25: [#imageLiteral(resourceName: "industrialengrclose"), #imageLiteral(resourceName: "industrialengrloc")],
        26: [#imageLiteral(resourceName: "mrlclose"), #imageLiteral(resourceName: "mrlloc")], 27: [#imageLiteral(resourceName: "archengclose"), #imageLiteral(resourceName: "archengloc")], 28: [#imageLiteral(resourceName: "pennstacclose"), #imageLiteral(resourceName: "pennstacloc"), #imageLiteral(resourceName: "pennstac1"), #imageLiteral(resourceName: "pennstac2")], 29: [#imageLiteral(resourceName: "correspondenceclose"), #imageLiteral(resourceName: "correspondenceloc")], 30: [#imageLiteral(resourceName: "calorimeterclose"), #imageLiteral(resourceName: "calorimeterloc")],
        31: [#imageLiteral(resourceName: "pughclose"), #imageLiteral(resourceName: "pughloc"), #imageLiteral(resourceName: "pughportrait")], 32: [#imageLiteral(resourceName: "mgmtedclose"), #imageLiteral(resourceName: "mgmtedloc")], 33: [#imageLiteral(resourceName: "arlclose"), #imageLiteral(resourceName: "ARLdistant")], 34: [#imageLiteral(resourceName: "watertunnelclose"), #imageLiteral(resourceName: "watertunnelloc")], 35: [#imageLiteral(resourceName: "postwarclose"), #imageLiteral(resourceName: "postwarloc")],
        36: [#imageLiteral(resourceName: "nittanylionclose"), #imageLiteral(resourceName: "nittanylionloc")], 37: [#imageLiteral(resourceName: "purefoodlaws"), #imageLiteral(resourceName: "purefoodlawsloc")], 38: [#imageLiteral(resourceName: "agexperimentclose"), #imageLiteral(resourceName: "agexperimentloc")], 39: [#imageLiteral(resourceName: "mushroomclose"), #imageLiteral(resourceName: "mushroomloc")], 40: [#imageLiteral(resourceName: "sts"), #imageLiteral(resourceName: "stsloc")],
        41: [#imageLiteral(resourceName: "dieselengrclose"), #imageLiteral(resourceName: "dieselengrloc")], 42: [#imageLiteral(resourceName: "deuteriumclose"), #imageLiteral(resourceName: "deuteriumloc")], 43: [#imageLiteral(resourceName: "Armoryclose"), #imageLiteral(resourceName: "armoryloc"), #imageLiteral(resourceName: "armoryphoto")], 44: [#imageLiteral(resourceName: "rvalues"), #imageLiteral(resourceName: "rvaluesloc")], 45: [#imageLiteral(resourceName: "indianleadership"), #imageLiteral(resourceName: "indianleadershiploc")],
        46: [#imageLiteral(resourceName: "bigtenclose"), #imageLiteral(resourceName: "bigtenloc")], 47: [#imageLiteral(resourceName: "contedclose"), #imageLiteral(resourceName: "contedloc")], 48: [#imageLiteral(resourceName: "americanelms"), #imageLiteral(resourceName: "americanelmsloc"), #imageLiteral(resourceName: "blurryelms"), #imageLiteral(resourceName: "elmsmall")], 49: [#imageLiteral(resourceName: "oldengrclose"), #imageLiteral(resourceName: "oldengrloc"), #imageLiteral(resourceName: "oldengrbldg")], 50: [#imageLiteral(resourceName: "oldbeaverfieldclose"), #imageLiteral(resourceName: "oldbeaverfieldloc")],
        51: [#imageLiteral(resourceName: "mtnittanyclose"), #imageLiteral(resourceName: "mtnittanylocation")], 52: [#imageLiteral(resourceName: "oakcottageclose"), #imageLiteral(resourceName: "oakcottageloc")], 53: [#imageLiteral(resourceName: "collegianclose"), #imageLiteral(resourceName: "collegianloc")], 54: [#imageLiteral(resourceName: "beaverclose"), #imageLiteral(resourceName: "beaverloc")], 55: [#imageLiteral(resourceName: "mosesclose"), #imageLiteral(resourceName: "mosesloc"), #imageLiteral(resourceName: "mosesmansion")],
        56: [#imageLiteral(resourceName: "mlkingclose"), #imageLiteral(resourceName: "mlkingloc")], 57: [#imageLiteral(resourceName: "ionosphereclose"), #imageLiteral(resourceName: "ionosphereloc")], 58: [#imageLiteral(resourceName: "waketurbulenceclose"), #imageLiteral(resourceName: "waketurbulenceloc")], 59: [#imageLiteral(resourceName: "biomechanicsclose"), #imageLiteral(resourceName: "biomechanicsloc"), #imageLiteral(resourceName: "biomechphoto")], 60: [#imageLiteral(resourceName: "walnutbuildingclose"), #imageLiteral(resourceName: "walnutbuildingloc"), #imageLiteral(resourceName: "walnutbuildingphoto"), #imageLiteral(resourceName: "walnutdedication")],
        61: [#imageLiteral(resourceName: "laboreducationclose"), #imageLiteral(resourceName: "laboreducationlocation")], 62: [#imageLiteral(resourceName: "publicspeakingclose"), #imageLiteral(resourceName: "publicspeakingloc")], 63: [#imageLiteral(resourceName: "championsforequalityclose"), #imageLiteral(resourceName: "championsforequalityloc")], 64: [#imageLiteral(resourceName: "studentbroadcasting"), #imageLiteral(resourceName: "studentbroadcastinginstall")], 65: [#imageLiteral(resourceName: "hospitalitymanagement"), #imageLiteral(resourceName: "hospitalitymanagementunveil"), #imageLiteral(resourceName: "hospitalitymanagementded"), #imageLiteral(resourceName: "hospitalitymanagementstudents")],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaceDetailsViewController", "viewDidLoad")

        placeDetailTitleLabel.text = detailTitle
        placeDetailImageView.image = detailImage
        placeDetailTextView.text = detailText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
