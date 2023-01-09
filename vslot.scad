$fn=24;
module v_slot_8th(){
	polygon([[0,0],[3.9,0],[3.9,2.84],[7.15,6.2],[8.15,6.2],[8.15,3.2],[10,3.2+1.85],[10,10]]);
}
module v_profile_2020(){
	difference(){
		for(th=[0:90:360]) rotate(th){
			scale([-1,1])v_slot_8th();
			v_slot_8th();
		}
		circle(d=4.2);
	}
}

module extruded_2020_v(length=100){
	linear_extrude(length,convexity=6)v_profile_2020();
}
module extruded_2040_v(length=100){
	translate([-10,0])extruded_2020_v(length);
	translate([10,0])extruded_2020_v(length);
}
module extruded_4040_v(length=100){
	translate([0,-10])extruded_2040_v(length);
	translate([0,10])extruded_2040_v(length);
}

extruded_4040_v();