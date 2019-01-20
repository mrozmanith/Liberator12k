use <../Meta/Manifold.scad>;
use <../Meta/Units.scad>;

module T_Lug2d(
              width=UnitsImperial(0.5),
             height=UnitsImperial(1),
          tabHeight=UnitsImperial(0.25),
           tabWidth=UnitsImperial(1),
          clearance=UnitsImperial(0.005),
          clearVertical=false,
             cutter=false) {
  clearance = cutter ? clearance : 0;
  render()
  union() {

    // Vertical
    translate([-height, -(width/2)-(clearVertical ? clearance : 0)])
    square([height+clearance, width+(clearVertical ? clearance*2 : 0)]);

    // Horizontal
    translate([-tabHeight-clearance, -(tabWidth/2)-clearance])
    square([tabHeight+(clearance*2),tabWidth+(clearance*2)]);
  }
}

module T_Lug(length=0.75,
              width=UnitsImperial(0.5),
             height=UnitsImperial(1),
          tabHeight=UnitsImperial(0.25),
           tabWidth=UnitsImperial(1),
          clearance=UnitsImperial(0.005),
      clearVertical=false,
             cutter=false) {

  clearance = cutter ? clearance : 0;

  render()
  rotate([0,90,0])
  translate([0,0,-clearance])
  linear_extrude(height=length+(clearance*2))
  T_Lug2d(width=width,
         height=height,
      tabHeight=tabHeight,
       tabWidth=tabWidth,
      clearance=clearance,
  clearVertical=clearVertical,
         cutter=cutter);
}

T_Lug(cutter=false);
