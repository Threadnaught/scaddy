//like MGN7C on https://www.alibaba.com/product-detail/Mini-Linear-Guide-Rail-MGN7-Linear_62386755141.html?spm=a2700.galleryofferlist.normal_offer.d_title.456135d73sATHY&s=p

ep=0.001;//epsilon
epp=ep*2;

module MGNxx_rail(length, width, height, 
	hole_initial_spacing, hole_spacing,
	hole_top_dia, hole_shoulder_depth, hole_bottom_dia){
	shoulder_height = height - hole_shoulder_depth;
	difference(){
		//Rail:
		translate([0,0,height/2])cube([length, width, height], true);
		//Screw Holes:
		for(x=[hole_initial_spacing-(length/2) : hole_spacing : length/2]){
			translate([x,0,-ep])cylinder(shoulder_height+epp,d=hole_bottom_dia);
			translate([x,0,shoulder_height])cylinder(hole_shoulder_depth+ep,d=hole_top_dia);
		}
	}
}
module MGNxx_carriage(length, width, carriage_end_height,
	carriage_start_height, rail_height, rail_width,
	screw_long_spacing, screw_width_spacing, screw_dia, screw_depth){
	height = carriage_end_height - carriage_start_height;
	difference(){
		//Carriage body:
		translate([0,0,(height/2)+carriage_start_height])cube([length, width, height], true);
		//Rail slot:
		translate([0,0,rail_height/2])cube([length+epp,rail_width,rail_height],true);
		//Screw holes
		for(x=[-screw_long_spacing/2 : screw_long_spacing : screw_long_spacing/2]){
			for(y=[-screw_width_spacing/2 : screw_width_spacing : screw_width_spacing/2]){
				translate([x,y,carriage_end_height-screw_depth])cylinder(screw_depth+ep,d=screw_dia);	
			}
		}
	}
}
module MGN7x_rail(length=100){
	MGNxx_rail(length=length, width=7, height=4.8, 
		hole_initial_spacing=5, hole_spacing=15,
		hole_top_dia=4.8, hole_shoulder_depth=2.3, hole_bottom_dia=2.4);
}
module MGN7C_carriage(){
	MGNxx_carriage(length=22.5, width=17, carriage_start_height=1.5, carriage_end_height=8,
		rail_height=4.8, rail_width=7,
		screw_long_spacing=8, screw_width_spacing=12, screw_dia=2,screw_depth=6 );
}

$fn=48;

MGN7x_rail();
MGN7C_carriage();