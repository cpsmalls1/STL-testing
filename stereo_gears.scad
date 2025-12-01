//
// stereo_gears.scad
// Parametric spur gear set (3 gears)
// For 3D printing & mechanical fit tuning.
//

//////////////////////////////
//  PARAMETRIC GEAR MODULE  //
//////////////////////////////

// Spur gear generator (approximate involute)
module spur_gear(teeth=20, module=0.5, thickness=2, bore=1.5, backlash=0.0) {
    
    // Derived dimensions
    pitch_diameter = teeth * module;
    outer_diameter = pitch_diameter + 2 * module;
    root_diameter  = pitch_diameter - 2.5 * module;
    tooth_width    = 360 / teeth;

    difference() {

        // Gear body
        union() {
            // Outer cylinder (tooth tips)
            cylinder(h = thickness, d = outer_diameter, $fn = 180);

            // Teeth
            for (i = [0 : teeth - 1]) {
                rotate([0,0,i * tooth_width])
                    translate([(outer_diameter/2 - module/2), 0, 0])
                        cube([module, module*1.8, thickness], center=true);
            }
        }

        // Bore
        cylinder(h = thickness + 0.1, d = bore, $fn = 60);
    }
}

//////////////////////////////
//   GEAR SET DEFINITIONS  //
//////////////////////////////

// Gear A — small idler
module gear_A() {
    spur_gear(
        teeth = 12,
        module = 0.5,
        thickness = 2,
        bore = 1.5,
        backlash = 0
    );
}

// Gear B — medium
module gear_B() {
    spur_gear(
        teeth = 24,
        module = 0.5,
        thickness = 2.5,
        bore = 1.5,
        backlash = 0
    );
}

// Gear C — large
module gear_C() {
    spur_gear(
        teeth = 40,
        module = 0.5,
        thickness = 3,
        bore = 2.0,
        backlash = 0
    );
}

//////////////////////////////
//  OUTPUT OPTIONS         //
//////////////////////////////

// Uncomment ONE to preview/export

// gear_A();
// gear_B();
// gear_C();

// Or show all with spacing:
// translate([0,0,0])    gear_A();
// translate([25,0,0])   gear_B();
// translate([55,0,0])   gear_C();
