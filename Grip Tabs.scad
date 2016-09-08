use <Components/Manifold.scad>;
use <Components/Units.scad>;

use <Vitamins/Nuts And Bolts.scad>;


function GripWidth() = 1;
function GripFloor() = 0.6;
function GripFloorZ() = -GripFloor();


function GripTabWidth() = 1;

function GripTabFrontLength() = 0.75;
function GripTabFrontMaxX() = 1.6;
function GripTabFrontMinX() = GripTabFrontMaxX()-GripTabFrontLength();

function GripTabRearLength() = 0.75;
function GripTabRearMinX() = -1.5;
function GripTabRearMaxX() = GripTabRearMinX()+GripTabRearLength();


function GripTabBoltRadius() = 0.0775;

function GripTabBoltX(bolt) = bolt[0];
function GripTabBoltY(bolt) = bolt[1];
function GripTabBoltZ(bolt) = bolt[2];

// XYZ
function GripTabBoltsArray() = [

   // Front-Top
   [GripTabFrontMaxX()+0.25,(GripWidth()/2)+0.125,GripFloorZ()+(GripFloor()/2)],

   // Back-Top
   [GripTabRearMinX()+(GripTabRearLength()/2), (GripWidth()/2)+0.125, GripFloorZ()+0.375]
];

module GripTabBoltHoles(boltSpec=Spec_BoltM3(), length=UnitsMetric(30),
                        clearance=true, $fn=8) {

  capHeightExtra = clearance ? 1 : 0;
  nutHeightExtra = clearance ? 1 : 0;

  color("SteelBlue")
  for (bolt = GripTabBoltsArray())
  translate([GripTabBoltX(bolt), GripTabBoltY(bolt), GripTabBoltZ(bolt)])
  rotate([90,0,0])
  rotate(90)
  NutAndBolt(bolt=boltSpec, boltLength=length, clearance=clearance,
              capHeightExtra=capHeightExtra,
              nutHeightExtra=nutHeightExtra, nutBackset=0.02);
}



module GripTab(length=1, width=0.5, height=0.75, extraTop=ManifoldGap(),
               tabHeight=0.25, tabWidth=GripTabWidth(), hole=false,
               clearance=0.007) {
  render()
  difference() {

    // Grip Tab
    union() {

      // Vertical
      translate([-clearance,-width/2,-height])
      cube([length+(clearance*2), width, height+extraTop]);

      // Horizontal
      translate([-clearance,-(tabWidth/2)-clearance,-height-clearance])
      cube([length+(clearance*2), tabWidth+(clearance*2), tabHeight+(clearance*2)]);
    }

    // Grip Bolt Hole
    if (hole)
    translate([length/2,0,-0.225])
    rotate([90,0,0])
    cylinder(r=GripTabBoltRadius(), h=width*2, center=true, $fn=8);
  }
}

module GripTabRear(clearance=0, height=.75, extraTop=ManifoldGap(), hole=true) {
  color("LightGreen")
  translate([GripTabRearMinX(),0,0])
  GripTab(length=GripTabRearLength(),
          height=height, extraTop=extraTop,
          hole=hole, clearance=clearance);
}

module GripTabFront(clearance=0, extraTop=ManifoldGap()) {
  color("Orange")
  translate([GripTabFrontMaxX(),0,0])
  mirror([1,0,0])
  GripTab(length=GripTabFrontLength(), tabWidth=1.25,
          height=0.5, extraTop=extraTop,
         clearance=clearance);
}

GripTabRear();

GripTabFront();

GripTabBoltHoles(clearance=false);
