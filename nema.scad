module nema(face_size=20.5,depth=30,bolt_cross=16,bolt_dia=2,bolt_depth=3.5,shaft_dia=3.5,shaft_len=10,shaft_other=10){
	difference(){
		translate([0,0,-depth/2])cube([face_size,face_size,depth],center=true);
		for(x = [-1 : 2 : 1]){
			for(y = [-1 : 2 : 1]){
				translate([x*bolt_cross/2,y*bolt_cross/2,1-bolt_depth])cylinder(bolt_depth+1,bolt_dia/2,bolt_dia/2);
			}
		}
	}
	cylinder(shaft_len,shaft_dia/2, shaft_dia/2);
	if (shaft_other > 0)translate([0,0,-depth-shaft_other])cylinder(shaft_len,shaft_dia/2, shaft_dia/2);
}
//$fn=48;
//nema();