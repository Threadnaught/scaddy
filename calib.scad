ep=0.01;//epsilon

$fn=48;


module round_square(w,r){
	offset(r)square(w-r-r,center=true);
}
module rounded_frustrum(wb,wt,r,h,ep){
	grad = (wt - wb) / h;
	epg = ep * grad;
	translate([0,0,-ep])linear_extrude(h+ep+ep, scale=(wt + epg) /(wb - epg))scale((wb - epg) / wb)round_square(wb,r);
}
module calib_cone(){
	rounded_frustrum(20,5,5,7.5,0);
}
module calib_block(){
	difference(){
		translate([-12.5,-12.5])cube([25,25,7.5]);
		rounded_frustrum(20,5,5,7.5,ep);
	}
}

calib_cone();
translate([0,0,7.5])rotate([180,0,0])translate([30,0])calib_block();