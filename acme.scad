
ep=0.0001;//epsilon
epp=ep*2;

module acme_profile(p,ir,or){
	rotate([90,0,0])linear_extrude(ep)offset(0.2)polygon([[ir,0*p],[or,0.134*p],[or,0.5*p],[ir,(0.5+0.134)*p]]);
}
$fn=24;

module thread_chunk(p,ir,or){
	hull(){
		acme_profile(p,ir,or);
		rotate([0,0,360/$fn])translate([0,0,p/$fn])acme_profile(p,ir,or);
	}
}

module thread(p,ir,or,c){
	for(up=[0:c-1]){
		translate([0,0,up])for(th=[0:$fn-1]){
			translate([0,0,th/24])rotate(th*360/$fn)thread_chunk(1,1.5,2);
		}
	}
}

for(m=[-1:2:1])scale([1,1,m])intersection(){
	union(){
		thread(1,1.5,2,12);
		cylinder(12,d=3);
	}
	translate([0,0,1])cylinder(10,d=4+epp);
}
cylinder(2,d=4,center=true);

!difference(){
	translate([0,0,0.5])cylinder(2,d=6);
	union(){
		translate([0,0,-1])thread(1,1.5,2,4);
		cylinder(4,d=3.5);
	}
}