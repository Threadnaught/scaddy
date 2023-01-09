//Cheap linear bearing and rod

ep=0.001;//epsilon
epp=ep*2;
$fn=48;

module linear_bearing(id=8,od=15,l=24){
	rotate([90,0,0])difference(){
		cylinder(l,d=od,center=true);
		cylinder(l+epp,d=id,center=true);
	}

}
module linear_rod(d=8,h=200){
	rotate([90,0,0])cylinder(h,d=d,center=true);
}
linear_bearing();
linear_rod();