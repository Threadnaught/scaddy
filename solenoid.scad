ep=0.001;//epsilon
epp=ep*2;
$fn=48;

module solenoid(depl=0){
	difference(){
		cube([13,30,16.6],center=true);
		translate([0,-7,-8.3-ep])cylinder(h=1+ep,d=2);
		translate([0,8,-8.3-ep])cylinder(h=1+ep,d=2);
	}
	translate([0,-15.1,0])rotate([90,0,0])cylinder(h=21.4-depl,d=13);
	translate([0,15.1,0])rotate([-90,0,0])cylinder(h=8+depl,d=3);
}
solenoid(5+(sin(360*$t)*5));