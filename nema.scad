ep=0.001;//epsilon
epp=ep*2;

module nema(face_size,depth,
	bolt_cross,bolt_dia,bolt_depth,
	shaft_dia,shaft_len,shaft_other,hollow_shaft_dia,
	shoulder_dia,shoulder_height){
	difference(){
		union(){
			//Motor body:
			translate([0,0,-depth/2])cube([face_size,face_size,depth],center=true);
			if(shoulder_dia != 0 && shoulder_height != 0){
				cylinder(shoulder_height,shoulder_dia/2,shoulder_dia/2);
			}
			//Motor shaft:
			cylinder(shaft_len,shaft_dia/2, shaft_dia/2);
			//Motor shaft (other):
			if (shaft_other > 0)translate([0,0,-depth-shaft_other])cylinder(shaft_len,shaft_dia/2, shaft_dia/2);
		}
		//Screw holes:
		for(x = [-1 : 2 : 1]){
			for(y = [-1 : 2 : 1]){
				translate([x*bolt_cross/2,y*bolt_cross/2,ep-bolt_depth])cylinder(bolt_depth+ep,bolt_dia/2,bolt_dia/2);
			}
		}
		//Hollow shaft:
		if(hollow_shaft_dia>0){
			if(shaft_other>0) {
				translate([0,0,-shaft_len-depth-ep])cylinder(depth+shaft_len+shaft_other+epp,hollow_shaft_dia/2,hollow_shaft_dia/2);
			} else {
				cylinder(depth+bolt_depth,hollow_shaft_dia/2,hollow_shaft_dia/2,center=true);
			}
		}
	}
}

//Standard 42mm stepper
module nema_17(depth=42){
	nema(face_size=42.3,depth=depth,
		bolt_cross=31,bolt_dia=3,bolt_depth=4.5,
		shaft_dia=5,shaft_len=24,shaft_other=0,hollow_shaft_dia=0,
		shoulder_dia=22,shoulder_height=2);
}

//Thin 20mm stepper
module nema_17_thin(){
	//nema_17(depth=20):
}

//Hollow 8mm stepper, like one of these: https://www.alibaba.com/product-detail/8HY1002-10SK-nema-8-hollow-hollow_60076603585.html?spm=a2700.galleryofferlist.normal_offer.d_title.40f921a2eyXW43
module nema_8_pnp(){
	nema(face_size=20.5,depth=30,
		bolt_cross=16,bolt_dia=2,bolt_depth=3.5,
		shaft_dia=5,shaft_len=10,shaft_other=10,hollow_shaft_dia=2.5,
		shoulder_dia=15,shoulder_height=1.5);
}

//Lightweight nema 14, like one of these: https://www.alibaba.com/product-detail/0-9-Degree-Frame-36mm-nema_1600147409651.html?spm=a2700.galleryofferlist.normal_offer.d_image.564e4eb5ebwqj5
module nema_14_round(){
	bolt_cross = 43.85;
	bolt_dia = 3;
	difference(){
		union(){
			//Body:
			translate([0,0,-20])cylinder(20,36.3/2,36.3/2);
			//Shoulder:
			cylinder(1.4,16/2,16/2);
			//Shaft:
			cylinder(15,5/2,5/2);
			//Motor flange:
			translate([0,0,-1])cube([10,50.8,2],center=true);
		}
		//Screw holes:
		for(x = [-1 : 2 : 1]){
			translate([0,x*bolt_cross/2,-2-ep])cylinder(2+epp,bolt_dia/2,bolt_dia/2);
		}
	}
}

//$fn=48;
//nema_17();
//translate([0,50,0])nema_17(20);
//translate([0,100,0])nema_14_round();
//translate([0,150,0])nema_8_pnp();
